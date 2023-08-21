import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fistan/modules/login/login_screen.dart';
import 'package:fistan/modules/profile/profile.dart';
import 'package:fistan/shared/cubit/states.dart';
import 'package:fistan/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/login_model.dart';
import '../../modules/broduct/product_screen.dart';
import '../../modules/favorite/favorite_screen.dart';
import '../../modules/fistan_book/fistan_book_screen.dart';
import '../network/local/cash_helper.dart';
import 'package:image_picker/image_picker.dart';


class FistanCubit extends Cubit<FistanState>{
  FistanCubit(): super(FistanInitialState());
  //-------------------------------------------------------------//
  static FistanCubit get(context)=>BlocProvider.of(context);
  List<Widget> screen=[
    ProductScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  int currentIndex=0;
  List<int> favorite=[];
  List<FistanData>fistanData=[
    FistanData(
        id: 1,
        image:'assets/images/first.png' ,
        title:' فستان سهرة',
        Price: 'السعر 700.000 ل.س',
        isFavorite: false
    ),
    FistanData(
        id: 2,
        image:'assets/images/second.png' ,
        title:' فستان عرس',
        Price: 'السعر 2000.000 ل.س',
        isFavorite: false

    ),
    FistanData(
        id: 3,
        image:'assets/images/third.png' ,
        title:' فستان خطبة',
        Price: 'السعر 1000.000 ل.س',
        isFavorite: false

    ),
    FistanData(
        id: 4,
        image:'assets/images/fourth.jpg' ,
        title:' فستان خطبة',
        Price: 'السعر 5000.000 ل.س',
        isFavorite: false

    ),
  ];
  var emailController=TextEditingController();
  var PasswordController=TextEditingController();
  var emailRegisterController=TextEditingController();
  var PasswordRegisterController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  bool isHide=true;
  bool isBoarding=false;
  late LoginModel dataLogin;
  late LoginModel dataRegister;
  //-------------------------------------------------------------//
  void setSecureText(){
    isHide=!isHide;
    emit(FistanChangeSecureState());
  }
  //-------------------------------------------------------------//
  void loginUser(){
    emit(FistanLoginProgressState());
     DioHelper.getData(
        path: 'login',
      lang: 'ar',
      queryParameters: {
        "email":emailController.text,
        "password":PasswordController.text
      }
    ).then((value) {
     dataLogin=LoginModel.fromjson(value.data);
      emit(FistanLoginSuccessState(dataLogin));
    }).catchError((onError){
      print(onError.toString());
      emit(FistanLoginErrorState());

    });
  }
  //-------------------------------------------------------------//
  void RigisterUser(){
    emit(FistanRegisterProgressState());
     DioHelper.getData(
        path: 'register',
      lang: 'ar',
      queryParameters: {
        "email":emailRegisterController.text,
        "password":PasswordRegisterController.text,
        "name":nameController.text,
        "phone":phoneController.text,
      }
    ).then((value) {
       dataRegister=LoginModel.fromjson(value.data);
      emit(FistanRegisterSuccessState(dataRegister));
    }).catchError((onError){
      print(onError.toString());
      emit(FistanRegisterErrorState());

    });
  }
  //-------------------------------------------------------------//
  void logout({
    context
}){
    CashHelper.clearCashData(key: 'token');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    emit(FistanLogoutState());
  }
  //-------------------------------------------------------------//
  void changeScreen(int value){
    currentIndex=value;
    emit(FistanChangeScreenState());
  }
  //-------------------------------------------------------------//
getDAta()async{
  CollectionReference fistanInfo = FirebaseFirestore.instance.collection('fistanInfo');
  await fistanInfo.get().then((value) {
    value.docs.forEach((element) { print(element.data());});
    print(value);
  });
}
  //-------------------------------------------------------------//
  void clickONimage({
    context,
    data
}){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FistanBookScreen(id: data.id,image: data.image,title: data.title,price: data.Price,isFavorite: data.isFavorite),)
    );
    emit(FistanChangeScreenToBookScreen());
  }
  IconData favoritIcon=Icons.favorite_border_outlined;
  //-------------------------------------------------------------//
  void changeFavoriteInfo(id){
    if(favorite.contains(id)==true) {
      favorite.remove(id);
    }
      else{
      favorite.add(id);

    }
      emit(FistanChangeFavoriteIcon());
  }
  //-------------------------------------------------------------//
Widget getFavoriteFistan(index){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
              width: 200,
              height: 200,
              child: Image(
                  image: AssetImage('${fistanData[favorite[index]-1].image}'),
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Container(
            height: 200,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text('${fistanData[favorite[index]-1].title}')),

                Text(
                    '${fistanData[favorite[index]-1].Price}',
                style: TextStyle(color: Colors.pink),),
              ],
            ),
          ),
        ),
      ],
    );
}
   late File image;
  final pikerImage=ImagePicker();
  ImageProvider imagePr=AssetImage('assets/images/person.png');
  uploadImageFromCamera(context)async{
    var piked=await pikerImage.pickImage(source: ImageSource.camera);
    image=File(piked!.path);
    if(image==null){
      imagePr=AssetImage('assets/images/person.png');
    }
    else{
      imagePr= FileImage(image);
    }
    emit(FistanChangeImageFromCamera());
    Navigator.pop(context);
  }
  uploadImageFromGallery(context)async{
    var piked=await pikerImage.pickImage(source: ImageSource.gallery);
    image=File(piked!.path);
    if(image==null){
      imagePr=AssetImage('assets/images/person.png');
    }
    else{
      imagePr= FileImage(image);
    }
    emit(FistanChangeImageFromGallery());
    Navigator.pop(context);
  }

  int i=0;
  void minimize(){
     i--;
     emit(FistanMinimize());
  }
  void increament(){
     i++;
     emit(FistanIncremant());

  }
}
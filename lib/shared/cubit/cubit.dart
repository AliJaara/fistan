import 'package:bloc/bloc.dart';
import 'package:fistan/shared/cubit/states.dart';
import 'package:fistan/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/login_model.dart';

class FistanCubit extends Cubit<FistanState>{
  FistanCubit(): super(FistanInitialState());

  static FistanCubit get(context)=>BlocProvider.of(context);

  var emailController=TextEditingController();

  var PasswordController=TextEditingController();

  var emailRegisterController=TextEditingController();
  var PasswordRegisterController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  bool isHide=true;
  void setSecureText(){
    isHide=!isHide;
    emit(FistanChangeSecureState());
  }
  late LoginModel dataLogin;
  late LoginModel dataRegister;
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

}
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fistan/modules/fistan_book/fistan_book_screen.dart';
import 'package:fistan/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget DefultTextFormField({
  required TextEditingController contoller,
  required String title,
  required TextInputType keyboardType,
  bool obscure=false,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? onChange,
   Function? onSubmitted,
  Function? validate,
  Function?SecureText

}){
  return TextFormField(
    textDirection: TextDirection.rtl,
    validator: (value){return validate!(value);},
  controller: contoller,
    obscureText: obscure,
  decoration: InputDecoration(

    hintTextDirection: TextDirection.rtl,
    labelText:title,
    border: OutlineInputBorder(),
    prefixIcon:Icon(prefixIcon),
    suffixIcon:IconButton( onPressed: (){SecureText!();}, icon: Icon(suffixIcon)) ,
),
    onChanged:(value){onChange!(value);} ,
    onFieldSubmitted:(value){onSubmitted!(value);} ,
  );
}

Widget DefultButton({
  required double width,
  required Color  backgroundColor,
  double? radios,
  required String title,
  bool upperCase=false,
  required Function OnPressed
}){
  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(radios!),
      color: backgroundColor,
    ),
    child: MaterialButton(
        onPressed: (){OnPressed();},
      child: Text(
        upperCase?title.toUpperCase():title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}
Future getMessage({
  required String message,
  ToastGravity? gravity,
  Color? backgroundColor
})async{

  Fluttertoast.showToast(
      msg: message,
    gravity: gravity,
    backgroundColor:backgroundColor,
  );
}
Future navigatorBush({context,required Widget PageName}) async {
  return await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageName));
}

Widget fistanBuilder(context,data){
 return Column(
   children: [
     InkWell(
       onTap: () {
         FistanCubit.get(context).clickONimage(context: context,data: data);

       },
       child: Image(image: AssetImage('${data.image}',),fit: BoxFit.cover,),
     ),
  SizedBox(height: 10,),
  Row(
      textDirection: TextDirection.rtl,
    children: [
      Text(
          '${data.title}'
          ,style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey[800]
      )
      ),
      Spacer(),
      Text(
        '${data.Price}',
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.pinkAccent),),
    ],
  ),
   ],
 );
}


  ShowOptionDialog(context){
  return showDialog (
      context: context,
      builder: (context) =>AlertDialog(
        title: Text('choose an option'),
        content:SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.image),
                title: Text('From Gallery'),
                onTap: () {
                  FistanCubit.get(context).uploadImageFromGallery(context);
                },

              ),
              ListTile(
                leading: Icon(Icons.camera_alt_outlined),
                title: Text('From Camera'),
                onTap: () {
                  FistanCubit.get(context).uploadImageFromCamera(context);
                },
              )
            ],
          ),
        )) ,

      );
      }
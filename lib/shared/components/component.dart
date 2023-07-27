import 'package:flutter/material.dart';
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
    validator: (value){return validate!(value);},
  controller: contoller,
    obscureText: obscure,
  decoration: InputDecoration(
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
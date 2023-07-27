import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fistan/modules/login/login_screen.dart';
import 'package:fistan/shared/cubit/cubit.dart';
import 'package:fistan/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/component.dart';

class RegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  bool isHide=true;
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => FistanCubit(),
      child: BlocConsumer<FistanCubit,FistanState>(
        listener: (context, state){
          if(state is FistanRegisterSuccessState)
            if(state.object.status==true){
              getMessage(message: '${state.object.message}');
            }
            else{
              getMessage(message: '${state.object.message}');
            }
        },
        builder: (context, state) {
          var cubit= FistanCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create an acount and see our OffeR',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 20,),
                            DefultTextFormField(
                                contoller: cubit.nameController,
                                title: 'Name',
                                keyboardType: TextInputType.name,
                                prefixIcon: Icons.person,
                                validate: (String value){
                                  if(value==null || value.isEmpty){
                                    return 'Name  cannt be empty';
                                  }
                                  else
                                    return null;
                                },
                                onSubmitted: (value){
                                }),
                            SizedBox(height: 20,),
                            DefultTextFormField(
                                contoller: cubit.phoneController,
                                title: 'Phone',
                                keyboardType: TextInputType.phone,
                                prefixIcon: Icons.phone_android,
                                validate: (String value){
                                  if(value==null || value.isEmpty){
                                    return 'Phone cannt be empty';
                                  }
                                  else
                                    return null;
                                },
                                onSubmitted: (value){

                                }),
                            SizedBox(height: 20,),

                            DefultTextFormField(
                                contoller: cubit.emailRegisterController,
                                title: 'Email Address',
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email,
                                validate: (String value){
                                  if(value==null || value.isEmpty){
                                    return 'Email Address cannt be empty';
                                  }
                                  else
                                    return null;
                                },
                                onSubmitted: (value){
                                }),
                            SizedBox(height: 20,),
                            DefultTextFormField(
                                contoller: cubit.PasswordRegisterController,
                                title: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                obscure: isHide?true:false,
                                prefixIcon: Icons.lock,
                                SecureText: (){

                                },
                                suffixIcon: isHide?Icons.remove_red_eye:Icons.remove_red_eye_outlined,
                                validate: (String value){
                                  if(value.isEmpty){
                                    return 'password cannt be empty';
                                  }
                                  else
                                    return null;
                                },
                                onSubmitted: (){}),
                            SizedBox(height: 20,),
                            DefultButton(
                                title: 'Register',
                                width: double.infinity,
                                backgroundColor: Colors.blue,
                                upperCase: true,
                                radios: 15,
                                OnPressed: ()async{
                                  if(formKey.currentState!.validate()){
                                    FistanCubit.get(context).RigisterUser();
                                  }
                                }),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("if you have an account"),
                                SizedBox(width: 3,),
                                TextButton(onPressed: (){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginScreen(),));

                                },
                                    child: Text(
                                      'click here',
                                      style: TextStyle(
                                          color: Colors.blue
                                      ),
                                    ))
                              ],)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },),
    );
  }
  //  signUp() async{
  //   try {
  //     print(emailController.text);
  //     print("++++++++++++++++++++++++++++");
  //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailController.text,
  //         password: PasswordController.text
  //     );
  //     print("******************************************");
  //     print(userCredential);
  //     print("******************************************");
  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       AwesomeDialog(context: context,title: "Error",body: Text('The password provided is too weak.'));
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       AwesomeDialog(context: context,title: "Error",body: Text('The account already exists for that email.'));
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print('sdsdsssssssss====================');
  //     print(e);
  //   }
  //
  // }
}

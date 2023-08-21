import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fistan/layout/fistan_layout.dart';
import 'package:fistan/modules/login/register_screen.dart';
import 'package:fistan/shared/cubit/cubit.dart';
import 'package:fistan/shared/cubit/states.dart';
import 'package:fistan/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/components/component.dart';

class LoginScreen extends StatelessWidget {
  //test
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FistanCubit(),
      child: BlocConsumer<FistanCubit,FistanState>(
        listener: (context,state) {
    if(state is FistanLoginSuccessState){
      if(state.object.status==true) {
        FistanCubit.get(context).isBoarding=true;
        CashHelper.setValue(key: 'token', value: state.object.data?.token);
        getMessage(message: 'Login Success');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FistanLayout(),));
      }
      else {
        getMessage(message: state.object.message!, backgroundColor: Colors.red);
      }

    }
    },
        builder: (context, state) {
          FistanCubit cubit=FistanCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.all(40),
                      child: Image(
                        image: AssetImage('assets/images/fistan.png'),
                        height: 175,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login Now And see Our Hot Offer',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(height: 20,),
                          DefultTextFormField(
                              contoller: cubit.emailController,
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
                                print(cubit.emailController.text);
                              }),
                          SizedBox(height: 20,),
                          DefultTextFormField(
                              contoller: cubit.PasswordController,
                              title: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock,
                              SecureText: (){
                                cubit.setSecureText();
                              },
                              suffixIcon: cubit.isHide?Icons.remove_red_eye:Icons.remove_red_eye_outlined,
                              obscure: cubit.isHide?true:false,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'password cannt be empty';
                                }
                                else
                                  return null;
                              },
                              onSubmitted: (){}),
                          SizedBox(height: 20,),
                          ConditionalBuilder(
                            builder: (context) => DefultButton(
                                title: 'Login',
                                width: double.infinity,
                                backgroundColor: Colors.blue,
                                upperCase: true,
                                radios: 15,
                                OnPressed: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.loginUser();
                                  }
                                }),
                            condition:state is! FistanLoginProgressState ,
                            fallback:(context) =>  Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("if you don't have an account"),
                              SizedBox(width: 3,),
                              TextButton(onPressed: (){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterScreen()
                                      )
                                );
                              },
                                  child: Text(
                                    'click here',
                                    style: TextStyle(
                                        color: Colors.blue
                                    ),
                                  ))
                            ],),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          );
      }
      )
    );
  }
}

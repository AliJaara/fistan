import 'package:bloc/bloc.dart';
import 'package:fistan/layout/fistan_layout.dart';
import 'package:fistan/modules/on_boarding.dart';
import 'package:fistan/modules/login/login_screen.dart';
import 'package:fistan/shared/bloc_observer.dart';
import 'package:fistan/shared/cubit/cubit.dart';
import 'package:fistan/shared/cubit/states.dart';
import 'package:fistan/shared/network/local/cash_helper.dart';
import 'package:fistan/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  var token=CashHelper.getCashData(key: 'token');
  if(token!= null){
    CashHelper.setValue(key: 'isBoarding', value: true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Widget screen;
    bool isBoarding=CashHelper.getCashData(key: 'isBoarding');
    print(isBoarding);
    print('////////////////////////////////////////////////////////////');
    if(isBoarding && CashHelper.getCashData(key: 'token')!=null){
      screen=FistanLayout();
    }
    else if (isBoarding && CashHelper.getCashData(key: 'token')==null)
      screen=LoginScreen();
    else
      screen=OnBoardingScreen();
    return BlocProvider(
        create: (context) => FistanCubit(),
      child: BlocConsumer<FistanCubit,FistanState>(
        listener:(context, state) =>  (){},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a blue toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),

            home: screen
            // Directionality( // add this
            //   textDirection: TextDirection.rtl, // set this property
            //   child: screen,
            // ),
          );

        },
      ),
    );

  }
}


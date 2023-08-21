import 'package:fistan/modules/broduct/product_screen.dart';
import 'package:fistan/shared/cubit/cubit.dart';
import 'package:fistan/shared/cubit/states.dart';
import 'package:fistan/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FistanLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FistanCubit,FistanState>(
      listener: (context, state) => (){},
      builder: (context, state) {
        var cubit=FistanCubit.get(context);
        return Scaffold(
          body:cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex,
            onTap: (value) {
              cubit.changeScreen(value);
            },
            selectedItemColor: Colors.pinkAccent,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                label: 'Favorite'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded),
                label: 'Me'
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:fistan/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FistanCubit,FistanState>(
      listener: (context, state) => (){}
      ,builder: (context, state) {
        var cubit=FistanCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                itemBuilder: (context, index) => cubit.getFavoriteFistan(index),
                separatorBuilder:(context, index) =>  Divider(color: Colors.grey),
                itemCount: cubit.favorite.length),
          ),
        );
      });
  }
}

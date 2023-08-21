import 'package:fistan/shared/components/component.dart';
import 'package:fistan/shared/cubit/cubit.dart';
import 'package:fistan/shared/cubit/states.dart';
import 'package:fistan/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FistanBookScreen extends StatelessWidget {
  var notes=TextEditingController();
  int i=0;
  dynamic?id;
  String? image;
  String? price;
  String? title;
   bool? isFavorite;
  FistanBookScreen(
      {
        this.id,
        this.image
        ,this.price,
        this.title,
        this.isFavorite
      }
      );
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FistanCubit,FistanState>(
      listener: (context, state){
      } ,
      builder: (context, state) {
        var cubit=FistanCubit.get(context);
        return Scaffold(
          body: Container(
            width: double.infinity,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(

                    children: [
                      Container(
                          width: double.infinity,
                          child: Image(image: AssetImage('$image'),fit: BoxFit.cover,)),
                      Positioned(
                        top: 10,
                        left: 5,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          child: IconButton(
                              icon: Icon(
                                cubit.favorite.contains(id)==true?Icons.favorite:Icons.favorite_border_outlined,
                                  color: Colors.pink),
                              onPressed: (){
                                cubit.changeFavoriteInfo(id);

                              }),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 5,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: IconButton(
                              icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.pink,
                                  size: 25),
                              onPressed: (){
                                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                                Navigator.pop(context);
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        '$title',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey[800]
                        ),
                      ),
                      Spacer(),
                      Text(
                        '$price',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.pinkAccent
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: DefultTextFormField(
                        contoller: notes,
                        title: 'اخبرنا ايضا',
                        keyboardType: TextInputType.text),
                  ),
                ),
                Container(

                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       child: IconButton(
                         onPressed:() {
                         cubit.increament();
                       },
                           icon: Icon(Icons.add),
                         iconSize: 30,
                         color: Colors.pinkAccent,
                         alignment: Alignment.center,
                       ),
                     ),
                     Container(
                       padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                       child: Text(
                           '${cubit.i}',
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.w700
                         ),
                       ),
                     ),

                     Container(
                       child: IconButton(onPressed: () {
                         cubit.minimize();
                       },
                           icon: Icon(Icons.minimize_sharp),
                         iconSize: 40,
                         color: Colors.pinkAccent,
                         padding: EdgeInsetsDirectional.only(bottom: 25),
                       ),
                     ),

                   ],

                  ),
                ),
                DefultButton(
                    radios: 40,
                    width: double.infinity,
                    backgroundColor: Colors.pinkAccent,
                    title: 'أضف الى السلة',
                    OnPressed: (){})
              ],
            ),
          ),

        );
      },
    );

  }
}

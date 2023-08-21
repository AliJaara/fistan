import 'package:fistan/shared/cubit/cubit.dart';
import 'package:fistan/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/component.dart';
import '../../shared/network/local/cash_helper.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FistanCubit,FistanState>(
        listener:(context, state) =>  (){},
      builder: (context, state) {
          var cubit=FistanCubit.get(context);
          return Scaffold(
          body: Container(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [

                        Container(
                          color: Colors.pinkAccent,
                        ),
                        CircleAvatar(
                          backgroundImage:cubit.imagePr,
                          maxRadius: 50,
                          backgroundColor: Colors.grey[300],
                        ),
                        Container(
                          alignment: AlignmentDirectional(0.25, 0.3),
                          child: IconButton(
                              onPressed: (){
                                ShowOptionDialog(context);
                              },
                              color: Colors.black,
                              icon: Icon(Icons.camera_alt_outlined),
                            iconSize: 30,
                          ),
                        ),
                        ClipPath(
                          clipper: CustomPath('width',0.0),
                          child: Container(
                            color: Colors.white30,
                          ),
                        ),
                        ClipPath(
                          clipper: CustomPath(0.0,'height'),
                          child: Container(
                            color: Colors.white30,
                          ),
                        ),
                      ]
                  ),
                ),
                Card(
                  margin: EdgeInsetsDirectional.all(8),
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)),),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          color: Colors.pink,
                          height: 25,
                          width: 2,
                        ),
                      ),
                      Text('About Us'),
                      Spacer(),
                      IconButton(onPressed: (){}, icon:Icon(Icons.arrow_forward_ios) )
                    ],
                  ),),
                Card(
                  margin: EdgeInsetsDirectional.all(10),
                  elevation: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.pink,
                          height: 25,
                          width: 2,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text('Polices'),
                      Spacer(),
                      IconButton(onPressed: (){}, icon:Icon(Icons.arrow_forward_ios) )
                    ],
                  ),),
                SizedBox(height: 30,),
                MaterialButton(
                  textColor: Colors.green,

                  onPressed: (){
                    CashHelper.clearCashData(key: 'token');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    height: 50,
                    child: Center(child: Text('Logout'),
                    )),),

                Expanded(child: Container())
              ],
            ),
          ),

        );}
    );
  }
}
class CustomPath extends  CustomClipper<Path>{
  dynamic x;
  dynamic y;
  CustomPath(this.x,this.y);
  @override
  getClip(Size size) {
    Path path=Path();
    path.addOval(Rect.fromCenter(
        center: Offset(x=='width'?size.width:0,y=='height'?size.height:0),
        width: 250,
        height: 250));
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
  
}
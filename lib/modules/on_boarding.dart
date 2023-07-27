import 'package:fistan/modules/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoarding{
   String? photo;
   String? title;
   onBoarding({this.photo,this.title});
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
List<onBoarding> item=[
  onBoarding(
      photo: 'assets/images/first.png',
    title: 'this app the first app for sell the fistan'
  ),
  onBoarding(
      photo: 'assets/images/second.png',
      title: 'you can now see and choose any fistan from your home'
  ),
  onBoarding(
      photo: 'assets/images/third.png',
      title: 'engoy and know the price before you coming'
  ),
];

  var pageController =PageController();

  bool Islast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()),(route) => false,);
                  }, child: Text('Skip')),
                ],
        ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder:(context, index) =>itemBuilder(item[index]),
                itemCount: item.length,
                onPageChanged: (value) {
                  if(value==item.length-1){
                    setState(() {
                      Islast=true;
                    });
                  }
                  else{
                    setState(() {
                      Islast=false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: item.length,
                  effect: ExpandingDotsEffect(
                    spacing:3 ,
                    offset: 30,
                    expansionFactor: 2,
                    activeDotColor: Colors.pink
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.pink,
                  onPressed: () {
                    if(Islast){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),),(route) => false,);
                    }
                    else{
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    }
                  },
                  child: Icon(
                      Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),

          ],
        ),
      )
    );

  }

  Widget itemBuilder(item){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Image(
                image:AssetImage(
                  '${item.photo}',
                ),
              fit:BoxFit.cover ,
            ),
          ),
          SizedBox(height: 15,),
          Expanded(
              child: Text(
                  '${item.title}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                ),
              )
          )
        ],
      ),
    );
  }
}

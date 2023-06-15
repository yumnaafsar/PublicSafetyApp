import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// import 'package:publicsafety/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:public_safety_app/screens/login_page.dart';

import '../utils/dim.dart';
class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(nextScreen: LoginPage(),splashIconSize: 800, duration:4000,splashTransition: SplashTransition.slideTransition, 
    pageTransitionType: PageTransitionType.leftToRight,animationDuration:Duration(seconds: 4),
    splash: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Public Safety",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green[400],fontFamily:'Pacifico',fontSize: Dim.font40,fontStyle: FontStyle.italic),),
        SizedBox(height: Dim.height10,),
        
        Text("Make Your City Safer",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green[200],fontFamily:'Pacifico',fontSize: Dim.font19,fontStyle: FontStyle.normal),),    
        SizedBox(height: Dim.height15,),
        //Lottie.network('https://assets6.lottiefiles.com/packages/lf20_98prpsbd.json',width: 290,height: 180),
       // Lottie.network('https://assets10.lottiefiles.com/private_files/lf30_iojccx08.json',width: Dim.width290,height: 180),
        Lottie.network('https://assets10.lottiefiles.com/packages/lf20_cigcffd3.json',width: Dim.width290,height: 280),
        //Lottie.network('https://assets10.lottiefiles.com/packages/lf20_bUYtXQygsL.json',width: 290,height: 180),

      ],
      //child: Lottie.network('https://assets9.lottiefiles.com/private_files/lf30_97kchk6i.json'),


    ),
   backgroundColor: Colors.black,
    );
  }
}
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_safety_app/screens/crime_alert/Videosfiles/lastVideoTry.dart';
import 'package:public_safety_app/screens/health_safety/disease.dart';
import 'package:public_safety_app/screens/health_safety/health_issues.dart';
import 'package:public_safety_app/screens/personal_safety/near_me.dart';
import 'package:public_safety_app/utils/dimension.dart';
import 'package:shake/shake.dart';
import '../../widgets/app_bar.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_sms/background_sms.dart';




class HealthSaftey extends StatefulWidget {
  const HealthSaftey({super.key});

  @override
  State<HealthSaftey> createState() => _HealthSafteyState();
}

class _HealthSafteyState extends State<HealthSaftey> {
  
  directcall()async{
    await FlutterPhoneDirectCaller.callNumber("03340317184");
  }
 
  dynamic data;
  late User? currentUser;


  Future<dynamic> getData() async {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("UserInformation")
          .doc(currentUser!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          data = snapshot.data();
        });
      }
    }
  }

    void initState(){
    getData();
  super.initState();
  ShakeDetector.autoStart(
      onPhoneShake: () async {
         await directcall();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Called to medical dept'),
          ),
        );
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  
}

 
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
          child: Column(
            children: [
              customizedAppBar(),
         SizedBox(height: Dimensions.height30,),

              Text('Health Safety', style: TextStyle(
                  color:  Color.fromARGB(255, 14, 114, 22),
                  fontSize: Dimensions.font45,
                  fontWeight: FontWeight.bold),),

               SizedBox(height: Dimensions.height30,),

        
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         GestureDetector(
                          onTap: ()=>{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Diseases()))
                          },
                          child: optionContainer('Monitor Your Health')),
                         GestureDetector(
                          onTap: ()=>{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => YoutubePlayerExa()))
                          },
                          child: optionContainer('Safety Videos'))
                      ],
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [ 
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HealthIssues()));
                          },
                          child: optionContainer('Common Health Issues')),
                        // GestureDetector(
                        //   onTap: ()=>{
                           
                        //     // Navigator.push(context, MaterialPageRoute(builder: (context) => HarasmentReport()))
                        //   },
                        //   child: optionContainer('Report Harasment'))
                      ],
                    )
                  ],
                ),
              ),
        
              SizedBox(height: Dimensions.height50,),
        
            ],
          ),
            ),
        ),
      ),
    );
  }

  Widget optionContainer(String text){
    return  Container(
                        height: Dimensions.height150,
                        width: Dimensions.width170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 14, 114, 22),
                                blurRadius: 5.0,
                                offset: Offset(0,5)
                            ),
                            BoxShadow(
                              color: Color.fromARGB(255, 14, 114, 22),
                                blurRadius: 5.0,
                                offset: Offset(-5,5)
                            
                            )
                          ],
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height15),
                          child: Center(
                            child: Animate(
                              effects: [
                         FadeEffect(),
                         SlideEffect()
                        ],
                              child: Text(text, style: TextStyle(color: Colors.white, fontSize: Dimensions.font20),)) //font 24
                          ),
                        ),
                      );

  }
}


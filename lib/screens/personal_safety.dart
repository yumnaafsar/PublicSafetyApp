import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shake/shake.dart';
import '../widgets/app_bar.dart';

import 'emergency_contact.dart';
import 'harassment_report.dart';
import 'live_loc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_sms/background_sms.dart';




class personalSaftey extends StatefulWidget {
  const personalSaftey({super.key});

  @override
  State<personalSaftey> createState() => _personalSafteyState();
}

class _personalSafteyState extends State<personalSaftey> {
  // Position? _curentPosition;
  // String? _curentAddress;

  //   Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }


  // LocationPermission? permission;
  //  _getPermission() async => await [Permission.sms].request();
  // _isPermissionGranted() async => await Permission.sms.status.isGranted;
  // _sendSms(String phoneNumber, String message, {int? simSlot}) async {
  //   SmsStatus result = await BackgroundSms.sendMessage(
  //       phoneNumber: phoneNumber, message: message, simSlot: 1);
  //   if (result == SmsStatus.sent) {
  //     print("Sent");
  //     Fluttertoast.showToast(msg: "send");
  //   } else {
  //     Fluttertoast.showToast(msg: "failed");
  //   }
  // }

  //   _getCurrentLocation() async {
  //   final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _curentPosition = position;
  //       print(_curentPosition!.latitude);
  //       _getAddressFromLatLon();
  //     });
  //   }).catchError((e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   });
  // }

  // _getAddressFromLatLon() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _curentPosition!.latitude, _curentPosition!.longitude);

  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _curentAddress =
  //           "${place.locality},${place.postalCode},${place.street},";
  //     });
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  // getAndSendSMS()async{
    
  // }  






void initState() {
    super.initState();
    // _getPermission();
    // _getCurrentLocation();
    
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );


         final player= AudioPlayer();
         player.play(AssetSource('audio/alarm.wav'));
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    detector.startListening();
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
        
              SizedBox(height: 60,),
        
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         GestureDetector(
                          onTap: ()=>{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyContact()))
                          },
                          child: optionContainer('Emergency contacts')),
                         GestureDetector(
                          onTap: ()=>{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LiveLocation()))
                          },
                          child: optionContainer('Live Location'))
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [ 
                        optionContainer('Wrong Numbers'),
                        GestureDetector(
                          onTap: ()=>{
                           
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HarasmentReport()))
                          },
                          child: optionContainer('Report Harasment'))
                      ],
                    )
                  ],
                ),
              ),
        
              SizedBox(height: 40,),
        
              button(),
              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: 
                Text('Logout',)
                )
        
            ],
          ),
            ),
        ),
      ),
    );
  }

  Widget optionContainer(String text){
    return  Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
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
                          padding: const EdgeInsets.all(15),
                          child: Center(
                            child: Animate(
                              effects: [
                         FadeEffect(),
                         SlideEffect()
                        ],
                              child: Text(text, style: TextStyle(color: Colors.white, fontSize: 24),))
                          ),
                        ),
                      );

  }
}

Widget button(){

  return Center(
    
    child: GestureDetector(
      onTap: () async {
        final player= AudioPlayer();
        player.play(AssetSource('audio/alarm.wav'));
      },

      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(15),
           color: Colors.red,
           boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 122, 4, 4),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(4,4)
             ),
             BoxShadow(
              color: Color.fromARGB(255, 114, 1, 1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(-4,-4)
             )
           ]
        ),
        child: Center(
          child: Text('Panic', 
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold) ,),
        ),
      ),
    ),
  );
}
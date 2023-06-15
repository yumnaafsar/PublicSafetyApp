import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_safety_app/screens/personal_safety/near_me.dart';
import 'package:public_safety_app/utils/dimension.dart';
import 'package:shake/shake.dart';
import '../../widgets/app_bar.dart';

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

  Position? _currentPosition;
  String? _currentAddress;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services'),
      ));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.'),
      ));
      return false;
    }
    return true;
  }

  Future<void> _getPermission() async {
    await Permission.sms.request();
  }

  Future<bool> _isPermissionGranted() async {
    return await Permission.sms.status.isGranted;
  }

  Future<void> _getCurrentLocation() async {
    if (await _handleLocationPermission()) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      await _getAddressFromLatLon();
    }
  }

  Future<void> _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(_currentPosition!.latitude,
              _currentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _sendSms(String phoneNumber, String message,
      {int? simSlot}) async {
    if (phoneNumber.isNotEmpty && message.isNotEmpty) {
      SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber,
        message: message,
        simSlot: 1,
      );
      if (result == SmsStatus.sent) {
        print("Sent");
        Fluttertoast.showToast(msg: "SMS sent");
      } else {
        Fluttertoast.showToast(msg: "Failed to send SMS");
      }
    } else {
      Fluttertoast.showToast(msg: "Invalid phone number or message");
    }
  }

  Future<void> getAndSendSMS() async {
    // Get permission to send SMS
    bool permissionGranted = await _isPermissionGranted();
    if (!permissionGranted) {
      await _getPermission();
      permissionGranted = await _isPermissionGranted();
      if (!permissionGranted) {
        Fluttertoast.showToast(msg: "Permission denied for sending SMS");
        return;
      }
    }

    // Get current location
    await _getCurrentLocation();

    // Check if location is available
    if (_currentPosition == null || _currentAddress == null) {
      Fluttertoast.showToast(msg: "Failed to retrieve location");
      return;
    }

    // Get emergency contacts
    getData().then((value) {
      if (data != null) {
        String contact1 = data['contact1'];
        String contact2 = data['contact2'];
        String contact3 = data['contact3'];

        // Send SMS to emergency contacts
        String message =
            "Emergency! I need help! My location is: \n\n$_currentAddress";
        _sendSms(contact1, message);
        _sendSms(contact2, message);
        _sendSms(contact3, message);
      } else {
        Fluttertoast.showToast(msg: "Emergency contacts not found");
      }
    });
  }




void initState() {
  
    super.initState();

     ShakeDetector.autoStart(
            shakeThresholdGravity: 7,
            shakeSlopTimeMS: 500,
            shakeCountResetTime: 3000,
            minimumShakeCount: 1,
            onPhoneShake: () async {
             getData();
            });

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

              Text('Personal Safety', style: TextStyle(
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyContact()))
                          },
                          child: optionContainer('Emergency contacts')),

                          GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NearMe()));
                          },
                          child: optionContainer('Near Me')),
                        
                      ],
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [ 
                        
                        GestureDetector(
                          onTap: ()=>{
                           
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HarasmentReport()))
                          },
                          child: optionContainer('Report Harasment')),

                          //  GestureDetector(
                          // onTap: ()=>{
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) => LiveLocation()))
                          // },
                          // child: optionContainer('Live Location'))
                      ],
                    )
                  ],
                ),
              ),
        
              SizedBox(height: Dimensions.height50,),
        
              button(),
              
        
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

Widget button(){

  return Center(
    
    child: GestureDetector(
      onTap: () async {
        final player= AudioPlayer();
        player.play(AssetSource('audio/alarm.wav'));
      },

      child: Container(
        height: Dimensions.height50,
        width: Dimensions.width150,
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
            fontSize: Dimensions.font30,
            fontWeight: FontWeight.bold) ,),
        ),
      ),
    ),
  );
}

/*
GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: 
                Text('Logout',)
                )
*/
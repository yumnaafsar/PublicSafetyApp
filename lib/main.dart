import 'package:flutter/material.dart';
import 'package:public_safety_app/screens/crime_alert/home_page.dart';
import 'package:public_safety_app/screens/front_page.dart';
import 'package:public_safety_app/screens/health_safety/disease.dart';
import 'package:public_safety_app/screens/health_safety/health_issues.dart';
import 'package:public_safety_app/screens/missing_persons/missingPerson.dart';
import 'package:public_safety_app/screens/personal_safety/emergency_contact.dart';
import 'package:public_safety_app/screens/personal_safety/harassment_report.dart';
import 'package:public_safety_app/screens/info_collect.dart';
import 'package:public_safety_app/screens/login_page.dart';
import 'package:public_safety_app/screens/personal_safety/personal_safety.dart';
import 'package:public_safety_app/screens/register.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:public_safety_app/screens/precautions/safety_signs.dart';
import 'package:public_safety_app/screens/splashscreen.dart';
import 'package:public_safety_app/utils/flutter_background_Services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

// import 'widgets/camera.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  //  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    print('current height is '+MediaQuery.of(context).size.height.toString());
    return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/splashScreen',
            routes: {
              '/splashScreen': (context) => Screen(),  
              '/login': (context) => SafetySigns(),  
              '/register': (context) => RegisterPage(),  
              '/userInfo': (context) => InformationDetail(),  
              '/personalSafety': (context) => personalSaftey(),  
              '/harrasment': (context) => HarasmentReport(),  
              '/frontPage': (context) => FrontPage(),  
            },
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot){
                if(snapshot.hasData)
                {
                  return personalSaftey();
                }
                else{
                  return LoginPage();
                }
              }
              ),
          );
  }
}


import 'package:flutter/material.dart';
import 'package:public_safety_app/screens/harassment_report.dart';
import 'package:public_safety_app/screens/login_page.dart';
import 'package:public_safety_app/screens/personal_safety.dart';
import 'package:public_safety_app/screens/register.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';



// import 'widgets/camera.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
            debugShowCheckedModeBanner: false,
            
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


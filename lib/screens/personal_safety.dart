import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/app_bar.dart';

import 'emergency_contact.dart';
import 'harassment_report.dart';
import 'live_loc.dart';



class personalSaftey extends StatefulWidget {
  const personalSaftey({super.key});

  @override
  State<personalSaftey> createState() => _personalSafteyState();
}

class _personalSafteyState extends State<personalSaftey> {

 
  
  

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
                },
                child: Text('Logout',))
        
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
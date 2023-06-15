import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:public_safety_app/screens/health_safety/health_safety.dart';
import 'package:public_safety_app/screens/missing_persons/missingPerson.dart';
import 'package:public_safety_app/screens/personal_safety/personal_safety.dart';
import 'package:public_safety_app/screens/precautions/precautions.dart';
import 'package:public_safety_app/utils/dimension.dart';

import '../utils/dim.dart';
import 'crime_alert/Videosfiles/lastVideoTry.dart';
import 'crime_alert/home_page.dart';



class FrontPage extends StatefulWidget {
  const FrontPage({Key? key,
}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {

  dynamic data;
  late User? currentUser;
  String name='';
  String city='';
  String image='';
  

Future<void> getData() async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("UserInformation")
        .doc(currentUser.uid)
        .get();

    if (snapshot.exists) {
      setState(() {
      name = snapshot.get('name') as String? ?? '';
      city = snapshot.get('city') as String? ?? '';
      image = snapshot.get('imageUrl') as String? ?? '';
      });
    }
  }
}


 @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      getData();
    }
  }



 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,

        title: Text('Welcome',
        style: TextStyle(
          fontSize: Dimensions.height30
        ),),
        centerTitle: true,

      ),

      body: Column(

        children: [

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dim.height20),

            ),
            width: Dim.width400,
            height: Dim.height250,
            child: Image(image: AssetImage("assets/images/crime/Public Safety App.png",

            ),
            fit: BoxFit.fill,
            height: Dim.height250,),
          ),
          Expanded(child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,

              // crossAxisSpacing: 5,
              // mainAxisSpacing: 5,


          ),
            children: [

                GestureDetector(
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => const personalSaftey()));
                },
                child:Container(
                  margin: EdgeInsets.all(Dim.height20),

                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:           Color.fromARGB(255, 17, 131, 26),
                        blurRadius: 5,
                        offset: Offset(0,5),),
                      BoxShadow(
                        color:           Color.fromARGB(255, 17, 131, 26),
                        blurRadius: 5,
                        offset: Offset(-5,5),),

                    ],
                    borderRadius: BorderRadius.circular(Dim.height30),
                    border: Border.all(width: 5,
                      color: Colors.white,

                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/crime/personal-removebg-preview.png",
                        width: Dim.height100,
                        height: Dim.height80,),
                      Center(child: Text('Personal Safety ',
                          style: TextStyle(
                            fontFamily: "Times New Roman",
                            color: Colors.white,
                            fontSize: Dim.height15,
                            fontWeight: FontWeight.bold,

                          )
                      )),
                    ],
                  ),
                ),
              ),
   
//  add
Padding(
                padding: EdgeInsets.all(Dim.height10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HealthSaftey()));
                  },
                  child:Container(
                    margin: EdgeInsets.all(Dim.height10),

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:           Color.fromARGB(255, 17, 131, 26),
                          blurRadius: 5,
                          offset: Offset(0,5),),
                        BoxShadow(
                          color:           Color.fromARGB(255, 17, 131, 26),
                          blurRadius: 5,
                          offset: Offset(-5,5),),

                      ],
                      borderRadius: BorderRadius.circular(Dim.height30),
                      border: Border.all(width: 5,
                        color: Colors.white,

                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset("assets/images/crime/health.png",width: Dim.height100,
                          height: Dim.height80,),
                        Center(child: Text('Health Safety ',
                            style: TextStyle(
                              fontFamily: "Times New Roman",
                              color: Colors.white,
                              fontSize: Dim.height15,
                              fontWeight: FontWeight.bold,

                            )
                        )),
                      ],
                    ),
                  ),
                ),
              ),
               GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>  MyHomePage(

    )));
    },
    child:Container(
            margin: EdgeInsets.all(Dim.height20),

      decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
    color:           Color.fromARGB(255, 17, 131, 26),
    blurRadius: 5,
    offset: Offset(0,5),),
    BoxShadow(
    color:           Color.fromARGB(255, 17, 131, 26),
    blurRadius: 5,
    offset: Offset(-5,5),),

    ],
      borderRadius: BorderRadius.circular(Dim.height30),
      border: Border.all(width: Dim.width5,
        color: Colors.white,

      ),
      ),
      child: Column(
        children: [
          Image.asset("assets/images/crime/crime-removebg-preview.png",
              width: Dim.width150,
          height: Dim.height80),
          Center(child: Text('Crime Reporting ',
          style: TextStyle(
          fontFamily: "Times New Roman",
            color: Colors.white,
          fontSize: Dim.height15,
          fontWeight: FontWeight.bold,

          )
          )),
        ],
      ),
      ),
    ),
            
              Padding(
    padding:  EdgeInsets.all(Dim.height15),
    child: GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => const MissingPerson()));
    },
    child:Container(
            margin: EdgeInsets.all(Dim.height5),

      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:           Color.fromARGB(255, 17, 131, 26),
            blurRadius: 5,
            offset: Offset(0,5),),
          BoxShadow(
            color:           Color.fromARGB(255, 17, 131, 26),
            blurRadius: 5,
            offset: Offset(-5,5),),

        ],
      borderRadius: BorderRadius.circular(Dim.height30),
      border: Border.all(width: Dim.width5,
        color: Colors.white,

      ),
      ),
      child: Column(
        children: [
          Image.asset("assets/images/crime/miss-removebg-preview.png",width: Dim.height100,
          height: Dim.height80,),
          Center(child: Text('Missing Person ',
          style: TextStyle(
          fontFamily: "Times New Roman",
            color: Colors.white,
          fontSize: Dim.height15,
          fontWeight: FontWeight.bold,

          )
          )),
        ],
      ),
      ),
    ),
    ),

              

               Padding(
    padding:  EdgeInsets.all(Dim.height15),
    child: GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => const PrecautionsAndTips()));
    },
    child:Container(
            margin: EdgeInsets.all(Dim.height5),

      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:           Color.fromARGB(255, 17, 131, 26),
            blurRadius: 5,
            offset: Offset(0,5),),
          BoxShadow(
            color:           Color.fromARGB(255, 17, 131, 26),
            blurRadius: 5,
            offset: Offset(-5,5),),

        ],
      borderRadius: BorderRadius.circular(Dim.height30),
      border: Border.all(width: Dim.width5,
        color: Colors.white,

      ),
      ),
      child: Column(
        children: [
          Image.asset("assets/images/crime/precau-removebg-preview.png",width: Dim.height100,
          height: Dim.height80,),
          Center(child: Text('Precautions',
          style: TextStyle(
          fontFamily: "Times New Roman",
            color: Colors.white,
          fontSize: Dim.height15,
          fontWeight: FontWeight.bold,

          )
          )),
        ],
      ),
      ),
    ),
    ),


            ],
          ))
        ],
      ),
    );
  }
}

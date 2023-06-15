import 'package:flutter/material.dart';
import 'package:public_safety_app/screens/crime_alert/report_crime.dart';
import 'dart:io';

import '../../utils/dim.dart';




class CrimeHelp extends StatelessWidget {
  final String title;
  final String reporter;
  final String city;
  final String district;
  final TimeOfDay time1;
  final DateTime date2;
  final String Description;
  final File image1;
  final String CompleteLocation;

  const CrimeHelp({
    Key? key, required this.title,
    required this.reporter,
    required this.city, required this.district,
    required this.time1, required this.date2,
    required this.Description,
    required this.image1, required this.CompleteLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 131, 26),
        title: Text('Crime Report View'),
        centerTitle: true,
      ),
      body: Column(
        children: [
     Padding(
       padding:  EdgeInsets.all(Dim.height8),
       child: Center(child: Text("Report Submitted Successfully!",
       style: TextStyle(
         color: Colors.green,
         fontSize: Dim.height15
       ),)),
     ),
Padding(
  padding: EdgeInsets.all(Dim.height20),
  child:   Container(
    height: Dim.height450,
  width: Dim.width380,
  margin: EdgeInsets.all(Dim.height10),
    decoration: BoxDecoration(
      border: Border.all(
        width: 5,
        color: Colors.lightGreen
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child:  Padding(
      padding: EdgeInsets.all(Dim.height15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Dim.height20,

            ),
            Container(
              width: Dim.width290,
              height:Dim.height200,

              child: Image.file(image1,
              fit: BoxFit.cover,),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dim.height12,
                ),
                Center(
                  child:   SizedBox(
                    width: Dim.width150,
                    child:   Divider(
                      color: Color.fromARGB(255, 17, 131, 26),
                      thickness: Dim.width2,
                      height: Dim.width2,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dim.height10,
                ),
                Row(
mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: Dim.height10,),
                        Text(
                            date2.toString().substring(0,10)
                        ),
                        SizedBox(
                          width: Dim.height20,
                        ),
                        Row(
                          children: [
                            Icon(Icons.timelapse),
                            SizedBox(width: Dim.height10,),
                            Text(
                                time1.toString().substring(10,15)
                            ),
                          ],),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim.height10,
                ),
                Center(
                  child: Text(title,
                    style: TextStyle(
                        fontSize: Dim.height15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: Dim.width2

                    ),),
                ),
                SizedBox(
                  height: Dim.height10,
                ),
                Text("Reporter By:",
                  style: TextStyle(
                      fontSize: Dim.height12,
                      color: Colors.grey),),
                Text(reporter,
                  style: TextStyle(
                    fontSize: Dim.height12,
                  ),),
                Text("Location:",
                  style: TextStyle(
                      fontSize: Dim.height12,
                      color: Colors.grey),),
                Text(CompleteLocation+","+district+""
                    ", "+city,
                  style: TextStyle(
                    fontSize: Dim.height12,
                  ),),
                Text("Details:",
                  style: TextStyle(
                      fontSize: Dim.height12,
                      color: Colors.grey),),
                Text(Description,
                  style: TextStyle(
                    fontSize: Dim.height12,
                  ),),

              ],
            )
          ],
        ),
      ),
    ),
  ),
),
          ElevatedButton(onPressed:(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
            CrimeReport()));

    },    child: Text('Submit Another Report'),
    style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 17, 131, 26),
    fixedSize: Size(Dim.height200, Dim.height40),
    ),

    ),
        ],
      ),
    );
  }
}

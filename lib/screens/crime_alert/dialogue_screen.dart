import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dim.dart';


class DialogScreenCrime extends StatelessWidget {


  final String image;
  final String Date;
  final String Time;
  final String reporter;
  final String City;
  final String details;
  final String District;
  final String title;

  final String CompleteLocation;
  const DialogScreenCrime({Key? key,


    required this.image,
    required this.reporter,
    required this.City,
    required this.details,
    required this.District,
    required this.title,
    required this.Date,
    required this.Time,
    required this.CompleteLocation,
  }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(


        width: Dim.height300,
        height: Dim.height450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dim.height15),
          color: Colors.white,
          border: Border.all(width: 5,color: Colors.green)
        ),
        child: Padding(
          padding: EdgeInsets.all(Dim.height40),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(20),

                  ),

                  margin: EdgeInsets.all(Dim.height20),
                  width: Dim.height450,
                  height: Dim.height150,
                  child: Image.network(image,
                  width: Dim.height300,
                  height: Dim.height100,
                  fit: BoxFit.cover),
                ),
Center(
  child:   SizedBox(
    width: Dim.height150,
    child:   Divider(
color: Colors.green,
      thickness: Dim.width2,
      height: Dim.width2,

    ),
  ),
),
                SizedBox(
                  height: Dim.height10,
                ),
                Row(

                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width:Dim.height10,),
                        Text(
                          Date.toString().substring(0,10)
                        ),
                        SizedBox(
                          width:Dim.height20,
                        ),
                        Row(
                          children: [
                            Icon(Icons.timelapse),
                            SizedBox(width: Dim.height10,),
                            Text(
                                Time.toString().substring(10,15)
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
                        letterSpacing: Dim.width2,

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
                Text(CompleteLocation+","+District+""
                    ", "+City,

                  style: TextStyle(
                    fontSize:Dim.height12,

                  ),),
                Text("Details:",
                  style: TextStyle(
                      fontSize: Dim.height12,

                      color: Colors.grey),),

                Text(details,

                  style: TextStyle(
                    fontSize: Dim.height12,



                  ),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

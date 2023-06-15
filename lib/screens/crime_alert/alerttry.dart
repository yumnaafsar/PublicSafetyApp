import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/dim.dart';
import 'dialogue_screen.dart';



class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  // Uint8List decodeImageString(String imageString) {
  //   final decodedBytes = base64Decode(imageString);
  //   return decodedBytes;
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   Color.fromARGB(255, 17, 131, 26),
      appBar: AppBar(
        backgroundColor:           Color.fromARGB(255, 17, 131, 26),
        title: Text("Crime Alerts"),
        centerTitle: true,
      ), body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>> //it has list of documents
      (
        stream: FirebaseFirestore.instance.collection("CrimeAlerts").snapshots(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.data==null || snapshot.hasError){
            return const Center(child:Text("data not available"));
          }
          //data can be null.

          return ListView.builder(

              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index) {
                DocumentSnapshot doc1= snapshot.data!.docs[index];

                Map<String,dynamic> data = doc1.data() as Map<String,dynamic>;

             // imageBytes=decodeImageString(data['image']);

                return 
                  InkWell(
                    onTap:  () {
                      print(data);
                      showDialog(
                        context: context,
                        builder: (context)=>DialogScreenCrime(

                          reporter: data['reporter'],
                          City: data['city'],
                          details: data['description'],
                          District: data['district'],
                          title: data['title'],
                          CompleteLocation: data['LocationComp'],
                          Time: data['time'],
                          Date: data['date'],
                          image:data['image'] ,



                        ),);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),




                      margin: EdgeInsets.all(10),
                      // color: Color.fromARGB(255,14, 114, 22),
                      color: Colors.white,
                      child: SizedBox(
                        width: Dim.width400,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(Dim.height10),
                          // leading: Icon(Icons.add_alert,
                          // color: Colors.white,),
                        //     Image.memory(Uint8List bytes) {
                        // return Image.memory(
                        // bytes,
                        // fit: BoxFit.cover, // Choose the desired fit mode for the image
                        // );
                        // }
                          leading:      SizedBox(
                              width:Dim.height100,
                              height: Dim.height100,

                              child: Image.network(data['image'])),
                          title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(data['title'],

                              style: TextStyle(
                                  fontSize: Dim.width15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: Dim.width2

                                 ),),
                            SizedBox(
                              height: Dim.height10,
                            ),
                            Text("Reporter By:",
                              style: TextStyle(
                                  fontSize: Dim.height12,

                                  color: Colors.grey),),

                            Text(data['reporter'],

                              style: TextStyle(
                                  fontSize: Dim.height12,

                                  ),),
                            Text("Location:",
                              style: TextStyle(
                              fontSize: Dim.height12,

                              color: Colors.grey),),
                            Text(data['city']+" , "+"Pakistan",

                                style: TextStyle(
                                fontSize: Dim.height12,

                                ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Icon(Icons.date_range_outlined),

                                Text(data['date'].toString().substring(0,10),
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                    fontSize: Dim.height10,))
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Icon(Icons.timelapse),

                                Text(data['time'].toString().substring(10,15),
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: Dim.height10,
                                ),)
                              ],
                            ),


                            // Image.file(data['image']),


                            // const Divider(
                            //   height: 20,
                            //   thickness: 5,
                            // )
                          ],
                ),
                          trailing: SizedBox(
                            width: Dim.height70,
                            child: Text(
                              'Click for More Details'
                                  ,style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                              fontSize: Dim.height12,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          )
                        ),
                      ),
                    ),
                  );
              }
          );
        }
    ),
    );
  }
}

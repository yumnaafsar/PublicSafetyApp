import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:public_safety_app/widgets/camera.dart';

import '../widgets/custom_bar.dart';
import '../widgets/date_picker.dart';
import '../widgets/desc_textfeild.dart';
import '../widgets/time_picker.dart';

class HarasmentReport extends StatefulWidget {
  const HarasmentReport({Key? key}) : super(key: key);

  @override
  State<HarasmentReport> createState() => _HarasmentReportState();
}

class _HarasmentReportState extends State<HarasmentReport> {
  final _formKey = GlobalKey<FormState>();

  String? _time;
  String? _location;
  String? _description;

  TextEditingController cityController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  TextEditingController cameraController=TextEditingController();
  TextEditingController descController=TextEditingController();

    void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validate form fields

      // Access values entered by the user
      final city = cityController.text;
      final location = locationController.text;
      final date = dateController.text;
      final time = timeController.text;
      final description = descController.text;
      


      // Store the data in Firebase Firestore
      FirebaseFirestore.instance.collection("harassmentReports").add({
        "city": city,
        "location": location,
        "date": dateController.text.toString(),
        "time": timeController.text.toString(),
        "description": description,
        "imageUrl":imageUrl,
      }).then((value) {
        // Data successfully stored
        print("Data stored in Firestore");
        // Reset form fields
        cityController.clear();
        locationController.clear();
        dateController.clear();
        timeController.clear();
        descController.clear();
      }).catchError((error) {
        // Error occurred while storing data
        print("Error storing data: $error");
      });
    }
  }

  String? imageUrl; // Added imageUrl variable

  void handleImageUrl(String url) {
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              customBar(title:'Report Harassement'),
              SizedBox(
                height: 10,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      SizedBox(height: 10,),
                      textFeild('City', 'Please Enter City', cityController),
                      SizedBox(height: 5,),
                      textFeild('Location', 'Please Enter Location', locationController),
                      SizedBox( height: 10,),
                      Row(
                        children: [
                          DatePicker(controller: dateController),
                          TimePicker(controller: timeController),
                        ],
                      ),
                      SizedBox(height: 10,),
                      BigTextFeild(controller:descController),

                      SizedBox(height: 10,),

                     CameraService(
                     imgDir: 'harasmentImages',
                onImageUrlReceived: handleImageUrl,
              ),

                      SizedBox(height: 25,),

                      GestureDetector(
                        onTap: (){
                          submitForm();
                        },
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                             color: Colors.black,
                              borderRadius: BorderRadius.circular(35.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 103, 138, 106),
                                    blurRadius: 5.0,
                                    offset: Offset(0, 5)),
                                BoxShadow(
                                    color: Color.fromARGB(255, 69, 158, 76),
                                    blurRadius: 5.0,
                                    offset: Offset(-5, 5))
                              ],
                            ),
                          child: Center(child: Text('Submit',style: TextStyle(color: Colors.white, fontSize:25, fontWeight: FontWeight.bold ),)),
                        ),
                      )
                      
                    ],
                  ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textFeild(String _labelText, String _hintText, _controller,) {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              _labelText,
              style: TextStyle(
                  color:  Color.fromARGB(255, 14, 114, 22),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 14, 114, 22),
                blurRadius: 5.0,
                offset: Offset(0, 5)),
            BoxShadow(
                color: Color.fromARGB(255, 14, 114, 22),
                blurRadius: 5.0,
                offset: Offset(-5, 5))
          ],
        ),

        child: TextFormField(
          controller: _controller,
           validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a $_hintText';
                    }
                    return null;
                  },
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500, color:Color.fromARGB(255, 61, 180, 71), fontSize: 17),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ),
    ],
  );
}


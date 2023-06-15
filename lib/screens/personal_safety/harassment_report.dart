import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:public_safety_app/utils/dimension.dart';
import 'package:public_safety_app/widgets/camera.dart';

import '../../widgets/custom_bar.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/desc_textfeild.dart';
import '../../widgets/time_picker.dart';

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
                height: Dimensions.height10,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      // SizedBox(height: Dimensions.height10,),
                      textFeild('City', 'Please Enter City', cityController),
                      SizedBox(height: Dimensions.height5,),
                      textFeild('Location', 'Please Enter Location', locationController),
                      SizedBox( height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DatePicker(controller: dateController),
                          TimePicker(controller: timeController),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Padding(
                        padding: const EdgeInsets.only(left:8, right: 8),
                        child: BigTextFeild(controller:descController),
                      ),

                      SizedBox(height: Dimensions.height5,),

                     CameraService(
                     imgDir: 'harasmentImages',
                onImageUrlReceived: handleImageUrl,
              ),

                      SizedBox(height:Dimensions.height15,),

                      GestureDetector(
                        onTap: (){
                          submitForm();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.height15),
                          child: Container(
                            height: Dimensions.height50,
                            width: Dimensions.width250,
                            decoration: BoxDecoration(
                               color: Colors.black,
                                borderRadius: BorderRadius.circular(Dimensions.radius35),
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
                            child: Center(child: Text('Submit',style: TextStyle(color: Colors.white, fontSize:Dimensions.font25, fontWeight: FontWeight.bold ),)),
                          ),
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
            padding: EdgeInsets.only(left: Dimensions.width20),
            child: Text(
              _labelText,
              style: TextStyle(
                  color:  Color.fromARGB(255, 14, 114, 22),
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, bottom: Dimensions.height15, top: Dimensions.height5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius35),
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
          style: TextStyle(fontSize: Dimensions.font20),
          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500, color:Color.fromARGB(255, 61, 180, 71), fontSize: Dimensions.font17),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal:  Dimensions.width16),
          ),
        ),
      ),
    ],
  );
}


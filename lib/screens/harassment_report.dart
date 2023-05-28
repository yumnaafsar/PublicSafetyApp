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
  const HarasmentReport({super.key});

  @override
  State<HarasmentReport> createState() => _HarasmentReportState();
}

class _HarasmentReportState extends State<HarasmentReport> {
  final _formKey = GlobalKey<FormState>();

  String? _time;
  String? _location;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              customBar(),
              SizedBox(
                height: 10,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      SizedBox(height: 10,),
                      textFeild('City', 'Please Enter City'),
                      SizedBox(height: 5,),
                      textFeild('Location', 'Please Enter Location'),
                      SizedBox( height: 10,),
                      Row(
                        children: [
                          DatePicker(),
                          TimePicker(),
                        ],
                      ),
                      SizedBox(height: 10,),
                      BigTextFeild(),

                      SizedBox(height: 10,),

                      CameraService(),

                      SizedBox(height: 25,),

                      Container(
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

Widget textFeild(String _labelText, String _hintText) {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              _labelText,
              style: TextStyle(
                  color: Colors.black,
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
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Color.fromARGB(255, 104, 99, 99), fontSize: 17),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ),
    ],
  );
}

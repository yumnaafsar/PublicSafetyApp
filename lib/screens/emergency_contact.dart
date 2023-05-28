import 'package:flutter/material.dart';
import 'package:public_safety_app/widgets/custom_bar.dart';

import '../widgets/app_bar.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({super.key});

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            customBar(),
            SizedBox(height: 15,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Text('To keep yourself safer always be one touch away from your trusted ones', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                      )),
                  ),
                  SizedBox(height: 20,),
                  textFeild('Contact 1', 'Enter number'),
                  SizedBox(height: 5,),
                  textFeild('Contact 2', 'Enter number'),
                  SizedBox(height: 5,),
                  textFeild('Contact 3', 'Enter number'),
                  SizedBox(height: 10,),
      
                  
                ],
              )
            ),
          ],
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
          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ),
    ],
  );
}

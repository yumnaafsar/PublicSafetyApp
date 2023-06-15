import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:public_safety_app/screens/login_page.dart';
import 'package:public_safety_app/screens/personal_safety/personal_safety.dart';
import 'package:public_safety_app/utils/dimension.dart';
import 'package:public_safety_app/widgets/camera.dart';
import '../widgets/custom_bar.dart';
import '../widgets/date_picker.dart';

class InformationDetail extends StatefulWidget {
  const InformationDetail({Key? key}) : super(key: key);

  @override
  State<InformationDetail> createState() => _InformationDetailState();
}

class _InformationDetailState extends State<InformationDetail> {
   final _formKey = GlobalKey<FormState>();
   TextEditingController nameController=TextEditingController();
   TextEditingController emailController=TextEditingController();
   TextEditingController  cnicController=TextEditingController();
   TextEditingController dateController=TextEditingController();
   TextEditingController cityController=TextEditingController();
   TextEditingController districtController=TextEditingController();

   late User? currentUser;
   

   void submitForm(){
    if (_formKey.currentState!.validate()) {
      
      final name= nameController.text;
      final email= emailController.text;
      final cnic= cnicController.text;
      final date = dateController.text;
      final city=cityController.text;
      final district=districtController.text;

      FirebaseFirestore.instance.collection('UserInformation').doc(currentUser!.uid).set({
        "name":name,
        "email":email,
        "cnic":cnic,
        "date": date.toString(),
        "city":city,
        "district":district,
        "imageUrl":imageUrl,
      }).then((value) => {
        print('User Information stored'),
        nameController.clear(),
        emailController.clear(),
        cnicController.clear(),
        dateController.clear(),
        cityController.clear(),
        districtController.clear(),

          Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginPage()))
        
      }).catchError((e){
          print('Error storing data $e');
      });


    }
   }

  void handleImageUrl(String url) {
    setState(() {
      imageUrl = url;
    });
  }
 String? imageUrl; // Added imageUrl variable
  

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            customBar(title: 'Personal Information',),
            SizedBox(height: Dimensions.height10,),
            Form(
              key:_formKey,
              child: Column(
              children: [
                textFeild('Name', 'Enter your full name', nameController),
                textFeild('Email', 'Enter your email', emailController),
                textFeild('CNIC NO', 'Enter your cnic number', cnicController),
                // DatePicker(controller: dateController),
                textFeild('City', 'Enter city where you live' , cityController),
                textFeild('District', 'Enter your district', districtController),
      
                SizedBox(height: Dimensions.height15,),
                Text('Please provide your photo ',
                  textAlign: TextAlign.start,
                  style:TextStyle(
                      color:  Color.fromARGB(255, 14, 114, 22),
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold,
                      ),
                            ),
                SizedBox(height: Dimensions.height10,),
                CameraService(
                  imgDir:'UserImages',
                  onImageUrlReceived: handleImageUrl),
      
                SizedBox(height: Dimensions.height25,),
                GestureDetector(
                          onTap: (){
                            submitForm();
                          },
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
                        )
              ],
            ))
          ],
        ),
      ),
    ));
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
                fontWeight: FontWeight.w500, color:Color.fromARGB(255, 61, 180, 71), fontSize: Dimensions.font15),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width16),
          ),
        ),
      ),
    ],
  );
}


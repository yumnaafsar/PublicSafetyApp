import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:public_safety_app/utils/dimension.dart';


class BigTextFeild extends StatefulWidget {

  final TextEditingController controller;
  
  BigTextFeild({
    required this.controller,
    super.key});

  @override
  State<BigTextFeild> createState() => _BigTextFeildState();
}

class _BigTextFeildState extends State<BigTextFeild> {

   TextEditingController descController=TextEditingController();


  @override
  void initState() {
    descController= widget.controller; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:EdgeInsets.only(left: Dimensions.width20),
                child: Text(
                  'Detail',
                  style: TextStyle(
                      color: Color.fromARGB(255, 14, 114, 22),
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Container(
              width: Dimensions.width400,
              height: Dimensions.width150,
          
              margin: EdgeInsets.only(bottom: Dimensions.height15, top: Dimensions.height5),
          
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
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
              padding: EdgeInsets.all(Dimensions.height10),
              child: TextField(
                controller: descController,
                maxLines: null, // Allow multiple lines of text
                decoration: InputDecoration(
                  hintText: "Enter details",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 61, 180, 71),
                      fontSize: Dimensions.font15),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

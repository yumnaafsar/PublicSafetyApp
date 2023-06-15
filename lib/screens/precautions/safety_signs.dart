import 'package:flutter/material.dart';
import 'package:public_safety_app/utils/dimension.dart';
import 'package:public_safety_app/widgets/custom_bar.dart';

class SafetySigns extends StatefulWidget {
  const SafetySigns({super.key});

  @override
  State<SafetySigns> createState() => _SafetySignsState();
}

class _SafetySignsState extends State<SafetySigns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customBar(title: 'Safety Signs'),
          SizedBox(height: Dimensions.height20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(''),
                ),
              SizedBox(width: Dimensions.width10,),
              Container(
                child: Image.asset(''),
                ),

            ],
          )
        ],
      ),
    );
  }
}
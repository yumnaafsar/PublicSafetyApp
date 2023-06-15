import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:public_safety_app/screens/health_safety/diseases/vitaminTips.dart';

import 'blood.dart';


class Vitamin extends StatefulWidget {
  const Vitamin({super.key});

  @override
  State<Vitamin> createState() => _VitaminState();
}

class _VitaminState extends State<Vitamin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vitamin D Deficiency Symptoms"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body:Column(children: [
        Drop(ques: 'Do you get fatigued easily?'),
        Drop(ques: 'Do you have pain in bones?',),
        Drop(ques: 'Do you feel depressed/sad?',),
        Drop(ques: 'Are you experiencing hair loss?',),
        Drop(ques: 'Do you have muscle weakness?',),
        showDi(r:"Probably, you have a Vitamin D Deficiency",ontap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>VitaminTips()));}),
     ],),
    );
  }
}
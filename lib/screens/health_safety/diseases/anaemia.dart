import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'anaemiaTips.dart';
import 'blood.dart';


class Anaemia extends StatefulWidget {
  const Anaemia({super.key});

  @override
  State<Anaemia> createState() => _AnaemiaState();
}

class _AnaemiaState extends State<Anaemia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Anaemia Symptoms"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body:Column(children: [
        Drop(ques: 'Do you often feel dizzy or light headache?'),
        Drop(ques: 'Do you have cold hands/feet?',),
        Drop(ques: 'Do you have pale yellow skin?',),
        Drop(ques: 'Do you have palpitations?',),
        Drop(ques: 'Are you experiencing pale nails?',),
        showDi(r:"Probably, you have low number of red blood cells and haemoglobin level.",ontap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>AnaemiaTips()));}),
     ],),
    );
  }
}
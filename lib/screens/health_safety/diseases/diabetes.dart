import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'blood.dart';
import 'diabetesTips.dart';


class Diabetes extends StatefulWidget {
  const Diabetes({super.key});

  @override
  State<Diabetes> createState() => _DiabetesState();
}

class _DiabetesState extends State<Diabetes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diabetes Symptoms"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body:Column(children: [
        Drop(ques: 'Do you often feel thirsty?'),
        Drop(ques: 'Do you have dry skin?',),
        Drop(ques: 'Do you feel tired easily?',),
        Drop(ques: 'Do you have tingling in hands or feet?',),
        Drop(ques: 'Do you have problem in digestion?',),
        showDi(r:"Probably, you have a Diabetes",ontap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>DiabetesTips()));}),
     ],),
    );
  }
}
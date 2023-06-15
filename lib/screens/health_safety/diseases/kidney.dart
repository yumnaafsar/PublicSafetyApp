import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'blood.dart';
import 'kidneyTips.dart';


class Kidney extends StatefulWidget {
  const Kidney({super.key});

  @override
  State<Kidney> createState() => _KidneyState();
}

class _KidneyState extends State<Kidney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kidney/Uric Acid Symptoms"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body:Column(children: [
        Drop(ques: 'Do you have swollen ankles,feet?'),
        Drop(ques: 'Do you feel tired easily?',),
        Drop(ques: 'Do you have difficulty in sleeping?',),
        Drop(ques: 'Do you have itchy skin?',),
        Drop(ques: 'Do you have some pain in kidney side?',),
        showDi(r:"Probably, you have a Kidney Problem, like Uric Acid",ontap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>KidneyTips()));}),
     ],),
    );
  }
}
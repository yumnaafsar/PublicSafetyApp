import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'blood.dart';
import 'heartTips.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cardiac problems Symptoms"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body:Column(children: [
        Drop(ques: 'Do you often feel streesed easily?'),
        Drop(ques: 'Do you feel high palpitations?',),
        Drop(ques: 'Do you have problem in taking breathe?',),
        Drop(ques: 'Do you feel some pain around chest/or left arm?',),
        Drop(ques: 'Do you have high cholestrol?',),
        showDi(r:"Probably, you have clotting in heart arteries",ontap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>HeartTips()));}),
     ],),
    );
  }
}
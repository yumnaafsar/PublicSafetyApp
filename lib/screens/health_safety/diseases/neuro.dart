import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'blood.dart';
import 'neuroTips.dart';


class Neuro extends StatefulWidget {
  const Neuro({super.key});

  @override
  State<Neuro> createState() => _NeuroState();
}

class _NeuroState extends State<Neuro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neuro Symptoms"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body:Column(children: [
        Drop(ques: 'Do you feel difficulty in processing information?'),
        Drop(ques: 'Do you have headache often',),
        Drop(ques: 'Do you feel difficulty in understanding concepts',),
        Drop(ques: 'Do you experience sudden memory loss?',),
        Drop(ques: 'Do you have problem in hearing/vision?',),
        showDi(r:"Probably, you have a Neuro problem",ontap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>NeuroTips()));}),
     ],),
    );
  }
}
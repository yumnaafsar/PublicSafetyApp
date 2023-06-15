import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'blood.dart';
import 'liverTips.dart';


class Liver extends StatefulWidget {
  const Liver({super.key});

  @override
  State<Liver> createState() => _LiverState();
}

class _LiverState extends State<Liver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liver Diseases Symptoms"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body:Column(children: [
        Drop(ques: 'Do you have abdominal pain?'),
        Drop(ques: 'Do you have skin/eyes that appear yellow?',),
        Drop(ques: 'Do you feel nausea often?',),
        Drop(ques: 'Do you experience abdominal pain and swelling?',),
        Drop(ques: 'Are you experiencing Loss of appetite?',),
        showDi(r:"Probably, you have  jaundice or some liver infection.",ontap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>LiverTips()));}),
     ],),
    );
  }
}
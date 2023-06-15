import 'package:flutter/material.dart';

import 'bloodTips.dart';



class NeuroTips extends StatelessWidget {
  const NeuroTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Neurological Problems Tips"),backgroundColor: Colors.green,),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
           
            children: [
              Tips("Relaxation Techniques for Brain", " When a person suffers from any kind of neurological disorder, it is very important for them to relax their brain regularly Very common neurological diseases like anxiety, depression, and multiple sclerosis are some of the disorders which can be cured with relaxation techniques"),
              SizedBox(height: 12,),
             Tips("Maintaining a Balanced Diet","A person suffering from any kind of neurological disorder needs to maintain a healthy diet to see a significant change in his/her health. Doctors prescribe foods that are rich in Vitamin C, E, B, and B6"),
              SizedBox(height: 12,),
             
             Tips("Do regular exercise", "egular exercise is absolutely essential for staying healthy and happy for a long period of time. Just like your body, your brain also needs its daily dose of exercise."),
              SizedBox(height: 12,),
             
             Tips("Reduce Stress", "Donot take too much stress and burden. Try to make your brain calm.")
             
             
            ],
          ),
        ),
      ),
    );;
  }
}
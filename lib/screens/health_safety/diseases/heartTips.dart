import 'package:flutter/material.dart';

import '../../../utils/dim.dart';
import 'bloodTips.dart';



class HeartTips extends StatelessWidget {
  const HeartTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tips for controlling Cardio problems"),backgroundColor: Colors.green,),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(Dim.height5, Dim.height10, Dim.height5, Dim.height5),
          child: Column(
           
            children: [
              Tips("Don't smoke or use tobacco", "Cigarette smoke reduces the oxygen in the blood, which increases blood pressure and heart rate because the heart has to work harder to supply enough oxygen to the body and brain."),
              SizedBox(height: 12,),
             Tips("Get moving: Aim for at least 30 to 60 minutes of activity daily","Regular, daily physical activity can lower the risk of heart disease. Physical activity helps control your weight. Do 30 minutes walk regularly."),
              SizedBox(height: 12,),
             
             Tips("Get good quality sleep", "People who don't get enough sleep have a higher risk of high blood pressure, heart attack,and depression.Most adults need at least eight hours of sleep each night. Make sleep a priority in your life.."),
              SizedBox(height: 12,),      
             Tips("Do not overuse pain killers", "A healthy diet can help protect the heart, improve blood pressure and cholesterol.Limit intake of the following: Salt, Oil, Processed carbohydrates.")
             
             
            ],
          ),
        ),
      ),
    );;
  }
}
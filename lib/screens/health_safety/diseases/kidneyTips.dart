import 'package:flutter/material.dart';

import 'bloodTips.dart';



class KidneyTips extends StatelessWidget {
  const KidneyTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tips for controlling Kidney problems"),backgroundColor: Colors.green,),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
           
            children: [
            
              Tips("Manage diabetes & high blood pressure", "If you have diabetes, high blood pressure, or heart disease, the best way to protect your kidneys from damage is to keep blood glucose numbers close to your goal"),
              SizedBox(height: 12,),
             Tips("Make healthy food choices","Choose foods that are healthy for your heart and your entire body: fresh fruits, and low-fat or fat-free dairy products.\nDo not eat pulses, tomatoes and heavy meat."),
              SizedBox(height: 12,),
             
             Tips("Drink 1-1.5 liters Water", "Drinking water is very important to prevent kidney diseases.Kidney stones and UTIs are two common medical conditions that can hurt the kidneys, and for which good hydration is essential."),
              SizedBox(height: 12,),      
             Tips("Do not overuse pain killers", "Using too much pain medicines called NSAIDs may cause kidney disease.Long-term use of NSAIDs, reduces the blood flow to the kidney which causes harm to kidney tissue")
             
             
            ],
          ),
        ),
      ),
    );;
  }
}
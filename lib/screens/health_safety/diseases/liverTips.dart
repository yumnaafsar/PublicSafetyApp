import 'package:flutter/material.dart';

import 'bloodTips.dart';



class LiverTips extends StatelessWidget {
  const LiverTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tips for controlling Liver diseases"),backgroundColor: Colors.green,),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
           
            children: [
        
              Tips("Drink 1-1.5 liters Water", "Drinking water is very important to prevent kidney diseases.Kidney stones and UTIs are two common medical conditions that can hurt the kidneys, and for which good hydration is essential."),
              SizedBox(height: 12,),
             Tips("Be careful with traditional medicine and remedies","Over-supplementation of traditional medicine may cause liver inflammation and can lead to irreversible liver damage or even failure"),
              SizedBox(height: 12,),
             
             Tips("Cut down smoking ", "Some studies link cigarette smoking with the development of liver cancer. Smoking can also enhance the toxic effects that some medications (such as paracetamol) have on the liver."),
              SizedBox(height: 12,),      
             Tips("Get vaccinated", "Get vaccinated against hepatitis A and B, both viral liver infections. Hepatitis A is contracted from contaminated food and water.Hepatitis B can be contracted through contaminated blood and needles")
             
             
            ],
          ),
        ),
      ),
    );;
  }
}
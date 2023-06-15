import 'package:flutter/material.dart';

import 'bloodTips.dart';



class DiabetesTips extends StatelessWidget {
  const DiabetesTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Blood Pressure Control Tips"),backgroundColor: Colors.green,),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
           
            children: [
              Tips("Lost Extra Weight", "Losing weight reduces the risk of diabetes. People in one large study reduced their risk of developing diabetes by almost 60% after losing approximately 7% of their body weight with changes in exercise and diet."),
              SizedBox(height: 12,),
             Tips(" Eat healthy plant foods","Fiber-rich foods promote weight loss and lower the risk of diabetes. Eat a variety of healthy, fiber-rich foods such as Fruits, such as tomatoes and nostelgic vegetables"),
              SizedBox(height: 12,),
             
             Tips("Be more pysically active", "Physical activity boosts your sensitivity to insulin — which helps keep your blood sugar within a normal range"),
              SizedBox(height: 12,),
             
             Tips("Reduce Stress", "Stress can raise your blood sugar and make you less sensitive to insulin.")
             
             
            ],
          ),
        ),
      ),
    );;
  }
}
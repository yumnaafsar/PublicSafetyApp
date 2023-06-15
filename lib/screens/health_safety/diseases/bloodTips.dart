import 'package:flutter/material.dart';

import '../../../utils/dim.dart';


class BloodTips extends StatelessWidget {
  const BloodTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Blood Pressure Control Tips"),backgroundColor: Colors.green,),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
           
            children: [          
              Tips("Exercise Regularly", "Regular physical activity can lower high blood pressure by about 5 to 8 mm Hg.For those who have hypertension, regular physical activity can bring blood pressure down to safer levels."),
              SizedBox(height: Dim.font12,),
             Tips("Reduce salt (sodium) in your diet","Even a small reduction of sodium in the diet can improve heart health and reduce high blood pressure by about 5 to 6 mm Hg"),
             SizedBox(height: Dim.font12,),            
             Tips("Quit Smoking", "Smoking increases blood pressure. Stopping smoking helps lower blood pressure."),
            SizedBox(height: Dim.font12,), 
             Tips("Lose Extra Pounds", "Blood pressure often increases as weight increases.In general: \nMen are at risk if their waist measurement is greater than 40 inches\nWomen are at risk if their waist measurement is greater than 35 inches")
             
             
            ],
          ),
        ),
      ),
    );
  }
}

Widget Tips(String lead,String sub)
{

    return Card(
              shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(255, 94, 97, 96),
                
              ),
              borderRadius: BorderRadius.circular(10.0), 
            ),
              child:  ListTile(
                leading: Icon(Icons.tips_and_updates,color:Colors.green,size:Dim.font40 ),
            title: Text(lead,style: TextStyle(fontSize: Dim.font17,color: Colors.green,fontWeight: FontWeight.bold),),
            subtitle: Text(sub,style: TextStyle(fontSize: Dim.font16,)),
            ),
            );
}
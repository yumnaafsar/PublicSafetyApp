import 'package:flutter/material.dart';

import 'bloodTips.dart';



class VitaminTips extends StatelessWidget {
  const VitaminTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tips to control Vitamin D Deficiency"),backgroundColor: Colors.green,),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
           
            children: [
              Tips("Consume fatty fish and seafood", "In fact, a 3.5-ounce (100-gram) serving of canned salmon can provide up to 386 IU of vitamin D — about 50% of the RDI "),
              SizedBox(height: 12,),
             Tips("Take supplements","Taking a vitamin D supplement may be the best way to ensure adequate intake.Vitamin D exists in two forms — D2  and D3 . Typically, D2 comes from plants and D3 from animals"),
              SizedBox(height: 12,),
             
             Tips("Drink milk regularly", "Milk is a naturally good source of many nutrients, including calcium, phosphorous, and riboflavin.1 cup of fortified cow’s milk contains 115 IU of vitamin D per cup (237 mL), or about 15% of the DV ( "),
              SizedBox(height: 12,),      
             Tips("Exposure to natural sunlight", "Sunlight is important for boosting vitamin D.A person should spend a short time outdoors each day without sunscreen and with their forearms, hands, or lower legs exposed to the sun.")
             
             
            ],
          ),
        ),
      ),
    );;
  }
}
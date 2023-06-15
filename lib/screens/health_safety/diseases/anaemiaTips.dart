import 'package:flutter/material.dart';

import 'bloodTips.dart';



class AnaemiaTips extends StatelessWidget {
  const AnaemiaTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tips for controlling Anaemia"),backgroundColor: Colors.green,),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
           
            children: [
         
              Tips("Choose iron-rich foods", "Foods rich in iron include: Seafood,beans,vegetables,apples,beetroot,spinach,fish,red meat and dried fruit, such as raisins and apricots"),
              SizedBox(height: 12,),
             Tips("Treatment ","If you have aplastic anemia, you might need medication, blood transfusions (in which you get blood from another person), or a bone marrow transplant (in which you get a donor’s stem cells)"),
              SizedBox(height: 12,),
             
             Tips("Choose foods containing vitamin C to enhance iron absorption", "You can enhance your body's absorption of iron by drinking citrus juice or eating other foods rich in vitamin C like grapefruit."),
              SizedBox(height: 12,),      
             Tips("Do not drink too much tea", "Avoid drinking tea at the same time as iron-rich foods or iron supplements, as tea reduces iron absorption. Tea can be consumed 2 hours after taking iron supplements.")
             
             
            ],
          ),
        ),
      ),
    );;
  }
}
import 'package:flutter/material.dart';
import 'package:public_safety_app/utils/dimension.dart';

import '../../widgets/custom_bar.dart';


class PrecautionsAndTips extends StatefulWidget {
  const PrecautionsAndTips({super.key});

  @override
  State<PrecautionsAndTips> createState() => _PrecautionsAndTipsState();
}

class _PrecautionsAndTipsState extends State<PrecautionsAndTips> {
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            customBar(title: 'Precautions & Tips'),

            SizedBox(height: Dimensions.height30,),

            heading('PRECAUTIONS'),
            SizedBox(height: Dimensions.height15,),
            card('Stay Alert and Aware', 'Be mindful of your surroundings at all times. Avoid distractions such as excessive use of smartphones or wearing headphones that can hinder your awareness.'),
  
            card('Walk with Confidence', 'Maintain a confident posture and walk with purpose. This can deter potential attackers and make you less vulnerable.'),

            card('Avoid Isolated Areas', 'Stay away from isolated areas, alleys, or shortcuts that are not well-traveled. Stick to main routes and well-populated areas, even if it takes a bit longer..'),

            card('Secure Your Belongings', 'Keep your personal belongings, such as bags, purses, or smartphones, secure and within sight to prevent theft.'),

            SizedBox(height: Dimensions.height40,),

            heading('SAFETY TIPS'),
            SizedBox(height: Dimensions.height15,),

            card('Pepper Spray', 'Make sure to carry a pepper spray with your self incase someone try to harras you'),

            card('Emergency Kit', 'Keep an emergency kit with essential supplies, including food, water, medications, a flashlight, batteries, and a first aid kit.'),

            card('Defense Technique', 'Familiarize yourself with self-defense techniques and consider taking self-defense classes.')

          ],
        ),
      ),
    );
  }
}

Widget card(String heading, String desc){
  return Padding(
    padding:EdgeInsets.all(Dimensions.height10),
    child: Card(
    shadowColor: const Color.fromARGB(255, 58, 209, 63),
    elevation: 8, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.radius20), 
    ),
    color: Color.fromARGB(255, 14, 114, 22),
    child: ListTile(
      leading: Image.asset('assets/videos/secure.gif', height: Dimensions.height80,width: Dimensions.width80,), //
      title: Padding(
        padding:EdgeInsets.only(bottom:Dimensions.height10, top: Dimensions.height5),
        child: Text(heading, style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font25,
                )),
      ), // 
      subtitle: Padding(
        padding: EdgeInsets.only(bottom:Dimensions.height10, top:2),
        child: Text(desc,
        // textAlign: TextAlign.justify,
        style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.font17
                )),
      ), 
      // trailing: Icon(Icons.arrow_forward, color: Colors.white,), 
      onTap: () {
       
      },
    ),
  ),
  );
}

Widget heading(String heading){
  return Padding(padding: EdgeInsets.only(left:Dimensions.width15, right: Dimensions.width15),
  child: Text(
    heading, style: TextStyle(
      color: Colors.black,
      fontSize: Dimensions.font35,
      fontWeight: FontWeight.bold
    ),
  ),
  );
}




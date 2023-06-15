import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:public_safety_app/utils/dimension.dart';

import '../../utils/dim.dart';
import 'diseases/anaemia.dart';
import 'diseases/blood.dart';
import 'diseases/diabetes.dart';
import 'diseases/heart.dart';
import 'diseases/kidney.dart';
import 'diseases/liver.dart';
import 'diseases/neuro.dart';
import 'diseases/vitamin.dart';

class Diseases extends StatelessWidget {
  const Diseases({super.key});

  directcall()async{
    await FlutterPhoneDirectCaller.callNumber("033340317184");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitor your health"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5,10,5,5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          DiseaseOpt(onPress: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Blood()));}, title: "Blood \nPressure", ic: Icons.live_help),
          SizedBox(width:Dim.height5),
          DiseaseOpt(onPress: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Diabetes()));}, title: "Check \nDiabetes", ic: Icons.mediation),
        
          ],),
          SizedBox(height: Dim.height15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             
             
          DiseaseOpt(onPress: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Neuro()));}, title: " Neuro\n Problems", ic: Icons.diversity_2_sharp),
                    SizedBox(width:Dim.height5),

          DiseaseOpt(onPress: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Heart()));}, title: " Cardio\n Problems", ic: Icons.heat_pump_rounded)
       
            ],
          ),
           SizedBox(height: Dim.height15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             
          DiseaseOpt(onPress: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Anaemia()));}, title: "Anaemia\nProblems", ic: Icons.bloodtype),
                   SizedBox(width:Dim.height5),

          DiseaseOpt(onPress: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Liver()));}, title: "Liver\nProblems", ic: Icons.health_and_safety_sharp)
       
            ],
          ),
           SizedBox(height: Dim.height15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             
          DiseaseOpt(onPress: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Kidney()));}, title: "Kidney\nProblems", ic: Icons.incomplete_circle_outlined),
                  SizedBox(width:Dim.height5),

          DiseaseOpt(onPress: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Vitamin()));}, title: "Vitamin D\nDeficiency", ic: Icons.hdr_strong)
       
            ],
          ),
           SizedBox(height:Dim.height10),

          ElevatedButton(onPressed: (){directcall();}, child: Text("Call to Medical Dept"),style: ElevatedButton.styleFrom(primary: Colors.green),)
            ],),
      ),
    );
  }
}

class DiseaseOpt extends StatelessWidget {

    final VoidCallback onPress;
    final String title;
    final IconData ic;

  const DiseaseOpt({
    Key? key,
    required this.onPress,
    required this.title,
    required this.ic,

  }) : super(key: key);
    
      @override
      Widget build(BuildContext context) {
        return InkWell(
          onTap:onPress,
          child: ( Container(  
           height: Dim.height120,
            width: Dimensions.height160,
             decoration: BoxDecoration(
             color: Color.fromARGB(255, 44, 41, 41),
             borderRadius: BorderRadius.circular(16),
         
           ), 
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            Icon(ic,color:Colors.white),
            SizedBox(width:Dim.width10),
            Text(title,style: TextStyle(color:Colors.white,fontSize: Dim.font17,),)
           ] ),   
           
              )
              ),
        );
      }
    }
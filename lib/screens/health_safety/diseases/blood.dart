import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../utils/dim.dart';
import 'bloodTips.dart';


class Blood extends StatefulWidget {
  const Blood({super.key});

  @override
  State<Blood> createState() => _BloodState();
}

class _BloodState extends State<Blood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Pressure Symptoms"),
        backgroundColor: Color.fromARGB(255, 51, 126, 54),
      ),
      body:Column(children: [
        Drop(ques: 'Do you feel streesed easily?'),
        Drop(ques: 'Do you often have headaches & blurred vission?',),
        Drop(ques: 'Do you feel shortness of breathe when climb stairs?',),
        Drop(ques: 'Do you feel chest pains when exercise?',),
        Drop(ques: 'Do you have body pains often?',),
        showDi(r:"Probably, you have a blood pressure issue",ontap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>BloodTips()));}),
            ],),
    );
  }
}

class Drop extends StatefulWidget {
  final String ques;

   Drop({super.key, required this.ques, });

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {
 final TextEditingController c=TextEditingController();
   List dropDown=[
    {"title":"Yes","value":"1"},
    {"title":"No","value":"2"},
  ];
 
  List result=[];
  List f=[];
  String s="";
  String val="";
  @override
  Widget build(BuildContext context) {

    return Padding(
        padding:EdgeInsets.fromLTRB(Dim.height15,Dim.height15,Dim.height15,Dim.height5),
        child: Column(
          children: [
             Text(widget.ques,style: TextStyle(fontSize: 17),),
              SizedBox(height: Dim.height5,),
            InputDecorator(        
              
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                contentPadding: EdgeInsets.all(Dim.height10),
              ),
             
              child: DropdownButtonHideUnderline(
              
                
                child: DropdownButton<String>(
                  
                  value: val,
                  isDense: true,
                  isExpanded: true,
                  menuMaxHeight: 300,
                  items: [ DropdownMenuItem(value: "", child: Text("Y/N",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15),)),...dropDown.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(child: 
                    Text(e['title']),value: e['value']);
                   
                  }).toList(),], onChanged: (newvalue){                
                      setState(() {
                        val = newvalue!;    
                      });
                  }
                 
                  ),
              ),
            ),
             
          ],       
        ),
      );
  }
}

class showDi extends StatelessWidget {   
  final String r;
  final VoidCallback ontap;

    const showDi({super.key, 
    required this.r,
    required this.ontap,
    });
 

   @override
   
  Widget build(BuildContext context) {
  return ElevatedButton(
          onPressed: () {
           
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                elevation: 50,
                title:Text("Disease Diagnosed"),
                content: Column(
                  children: [
                    Text(r),
                    SizedBox(height:Dim.height10),
                    Text("Click the below button to get related tips and information about your diagnosed problem. Follow these and make your health better!"),
                    SizedBox(height:Dim.height15),
                    
                    ElevatedButton(onPressed: ontap,
                    child: Text("SEE TIPS"),style:ElevatedButton.styleFrom(primary: Colors.green))
                  ]
                )
              );
            }
            );
          },child: Text("Submit"),style: ElevatedButton.styleFrom(primary: Colors.green),
  );
  }
}




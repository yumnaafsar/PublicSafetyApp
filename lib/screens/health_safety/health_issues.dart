import 'package:flutter/material.dart';
import 'package:public_safety_app/utils/dimension.dart';

import '../../widgets/custom_bar.dart';

class HealthIssues extends StatefulWidget {
  const HealthIssues({super.key});

  @override
  State<HealthIssues> createState() => _HealthIssuesState();
}

class _HealthIssuesState extends State<HealthIssues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            customBar(title: 'Health Issues'),
            SizedBox(height:Dimensions.height50,),
            GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Heart Attack','assets/images/health_issues/heart-attack.jpg','assets/images/precaution/heart_attack.png', ),
              );
              
              },
              child: Disease('Heart Attack','assets/images/logo/heart_attack.png','A heart attack occurs when the flow of blood to the heart is severely reduced or blocked. The blockage is usually due to a buildup of fat, cholesterol and other substances in the heart (coronary) arteries.',)
              ),
      
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Covid', 'assets/images/health_issues/covid.png','assets/images/precaution/covid.jpg', ),
              );
              
              },
              child: Disease('Covid','assets/images/logo/covid.png','Coronavirus disease (COVID-19) is an infectious disease caused by the SARS-CoV-2 virus.The virus can spread from an infected person’s mouth or nose in small liquid particles when they cough, sneeze, speak, sing or breathe',)),
      
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Chest Pain', 'assets/images/health_issues/chest-pain.jpg','assets/images/precaution/heart_attack.png', ),
              );
              
              },
              child: Disease('Chest Pain','assets/images/logo/chest-pain.jpg','Chest pain appears in many forms, ranging from a sharp stab to a dull ache. Sometimes chest pain feels crushing or burning. In certain cases, the pain travels up the neck and into the jaw and then spreads to the back or down one or both arms.',)),
      
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Fatigue', 'assets/images/health_issues/chronic-fatigue.jpg','assets/images/precaution/covid.jpg', ),
              );
              
              },
              child: Disease('Fatigue','assets/images/logo/fatigue.png','Fatigue is a feeling of constant tiredness or weakness and can be physical, mental or a combination of both. It can affect anyone, and most adults will experience fatigue at some point in their life.',)),
      
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Cold & Flu', 'assets/images/health_issues/cold_flu.jpg','assets/images/precaution/cold_flu.png', ),
              );
              
              },
              child: Disease('Cold & Flu','assets/images/logo/cold-flu.png','The common cold is an infection of your nose, sinuses, throat and windpipe. Colds spread easily, especially within homes, classrooms and workplaces. Flu symptoms are usually more severe than cold symptoms and come on quickly. ',)),
      
      
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Panic Attack', 'assets/images/health_issues/panic-attacks.jpg','assets/images/precaution/panic-attack.jpg', ),
              );
              
              },
              child: Disease('Panic Attack','assets/images/logo/panic_attack.jpg','A panic attack is a feeling of sudden and intense anxiety. A panic attack causes sudden, temporary feelings of fear and strong physical reactions in response to ordinary, nonthreatening situations.Panic attacks can also have physical symptoms, including: shaking. feeling disorientated. nausea.',)),
      
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Cold Sweats', 'assets/images/health_issues/cold-sweats.jpg','assets/images/precaution/panic-attack.jpg', ),
              );
              
              },
              child: Disease('Cold Sweats','assets/images/logo/cold-sweats.jpg','A cold sweat is a sign of sudden, significant stress, which could be physical or psychological in origin, or a combination of the two..Cold sweats happen if you become chilly while sweating. Your skin may become pale, moist, and clammy.',)),
      
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Heat Stroke', 'assets/images/health_issues/heat_stroke.jpg','assets/images/precaution/heat_stroke.jpg', ),
              );
              
              },
              child: Disease('Heat Stroke','assets/images/logo/heat_stroke.jpeg','Heat stroke is the most serious heat-related illness. It occurs when the body can no longer control its temperature: the body temperature rises rapidly, the sweating mechanism fails, and the body is unable to cool down',)),
      
              SizedBox(height: Dimensions.height30,),
      
              GestureDetector(
              onTap: (){
                 showDialog(
                context: context,
                builder: (BuildContext context) =>  PopUp('Hypertension', 'assets/images/health_issues/hypertension.png','assets/images/precaution/hypertension.jpg', ),
              );
              
              },
              child: Disease('Hypertension','assets/images/logo/hypertension.jpeg','High blood pressure, also called hypertension, is blood pressure that is higher than normal.High blood pressure is a common condition that affects the body arteries. Normal blood pressure should be 120/80 mm Hg or lower',)),
          ],
        ),
      ),
    );
  }
}

Widget Disease(String disease, String img, String desc) {
  return Padding(
    padding:  EdgeInsets.all(Dimensions.height10),
    child: Card(
      
      shadowColor: const Color.fromARGB(255, 14, 114, 22),
      elevation: 10,
      shape: RoundedRectangleBorder(
         side: BorderSide(color: Color.fromARGB(255, 14, 114, 22) , width: Dimensions.height5),
        borderRadius: BorderRadius.circular(Dimensions.radius30),
      ),
      child: Column(
        children: [
          SizedBox(height: Dimensions.height5,),
          Container(
            width: double.infinity,
            height: Dimensions.height150, 
            child: Image.asset(
              img,
            ),
          ),
          ListTile(
            title: Padding(
              padding: EdgeInsets.only(bottom:Dimensions.height10, top: Dimensions.height5),
              child: Text(
                disease,
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 128, 15),
                  fontWeight: FontWeight.bold,
                  fontSize:Dimensions.font25,
                ),
              ),
            ),
            subtitle: Padding(
              padding:EdgeInsets.only(bottom: Dimensions.height10, top: Dimensions.height5),
              child: Text(
                desc,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.font20,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


Widget PopUp(String disease, String symptoms_img,  String precation_img,){
  return  AlertDialog(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color.fromARGB(255, 14, 114, 22) , width: Dimensions.height5),
		borderRadius: BorderRadius.circular(Dimensions.radius30),
	),
  shadowColor: Color.fromARGB(255, 14, 114, 22),

    title: Container(
      height: Dimensions.height90,
      decoration: BoxDecoration(color: Color.fromARGB(255, 14, 114, 22, ),
      borderRadius: BorderRadius.circular(30),),
      child: Center(child: Text(disease, style: TextStyle(
        color: Colors.white,
        fontSize: Dimensions.font45,
        fontWeight: FontWeight.bold
      ),),),
    ),
    content: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimensions.height10,),
          Center(child: Text('Symptoms', style: TextStyle(
      color: Colors.black,
      fontSize: Dimensions.font35,
      fontWeight: FontWeight.bold
    ),
  ),),
          SizedBox(height: Dimensions.height15,),
          Image.asset(symptoms_img),
          SizedBox(height: Dimensions.height30,),
          Center(child: Text('Precaution', style: TextStyle(
      color: Colors.black,
      fontSize: Dimensions.font35,
      fontWeight: FontWeight.bold
    ),),),
          SizedBox(height: Dimensions.height5,),
          Image.asset(precation_img,)
        ],
      ),
    ),
  );
}
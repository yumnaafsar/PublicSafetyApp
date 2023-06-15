import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:public_safety_app/screens/crime_alert/map_screen.dart';
import 'package:public_safety_app/screens/missing_persons/showmissing.dart';
import 'package:public_safety_app/widgets/app_bar.dart';


import 'package:shake/shake.dart';
import '../../utils/dim.dart';
import '../../utils/dimension.dart';
import 'newform.dart';

class MissingPerson extends StatefulWidget {
    const MissingPerson({super.key});

  @override
  State<MissingPerson> createState() => _MissingPersonState();
}

class _MissingPersonState extends State<MissingPerson> {
  directcall()async{
    await FlutterPhoneDirectCaller.callNumber("03340317184");
  }
 dynamic data;
  late User? currentUser;


  Future<dynamic> getData() async {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("UserInformation")
          .doc(currentUser!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          data = snapshot.data();
        });
      }
    }
  }

  void initState(){
    getData();
  super.initState();
  ShakeDetector.autoStart(
      onPhoneShake: () async {
         await directcall();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Called to medical dept'),
          ),
        );
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  
}
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
          child: Column(
            children: [
              customizedAppBar(),
        
              SizedBox(height: Dimensions.height30,),

              Text('Missing Persons', style: TextStyle(
                  color:  Color.fromARGB(255, 14, 114, 22),
                  fontSize: Dimensions.font45,
                  fontWeight: FontWeight.bold),),

               SizedBox(height: Dimensions.height30,),

        
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         
                         GestureDetector(
                          onTap: ()=>{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Reort2()))
                          },
                          child: optionContainer('Report Missing Person')),

                          GestureDetector(
                          onTap: ()=>{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Baskets()))
                          },
                          child: optionContainer('Details of Missing Person')),
                      ],
                    ),
                    SizedBox(height: Dimensions.height30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [ 
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
                          },
                          child: optionContainer('View Missing Areas')),
                
                      ],
                    )
                  ],
                ),
              ),
        
              SizedBox(height: Dimensions.height50,),
            ],
          ),
            ),
        ),
      ),
        
      );
    }


  

  
}

Widget optionContainer(String text){
    return  Container(
                        height: Dimensions.height150,
                        width: Dimensions.width170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 14, 114, 22),
                                blurRadius: 5.0,
                                offset: Offset(0,5)
                            ),
                            BoxShadow(
                              color: Color.fromARGB(255, 14, 114, 22),
                                blurRadius: 5.0,
                                offset: Offset(-5,5)
                            
                            )
                          ],
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height15),
                          child: Center(
                            child: Animate(
                              effects: [
                         FadeEffect(),
                         SlideEffect()
                        ],
                              child: Text(text, style: TextStyle(color: Colors.white, fontSize: Dimensions.font20),)) //font 24
                          ),
                        ),
                      );

  }


  

// SingleChildScrollView(
//           child: Column(
//             children: [
//               customizedAppBar(),
            
//             Padding(
//             padding: EdgeInsets.fromLTRB(Dim.font30,Dim.font30,Dim.m22,0),
              
              
//             child: Column(    
//               children: [
//                 ShowOpt(title:'Report a Missing Person',ic:Icons.report_gmailerrorred,onPress: (){print(Dim.screenWidtht); Navigator.push(context,MaterialPageRoute(builder: (context)=>Reort2()));},),  
//                 SizedBox(height: Dim.height20,),       
//                 ShowOpt(title:'Details/Information of All \n Missing Persons',ic:Icons.details_rounded,onPress: (){ Navigator.push(context,MaterialPageRoute(builder: (context)=>Baskets()));},),
//                SizedBox(height: Dim.height20,),
//                ShowOpt(title:'Area wise Information of \n   Missing Person',ic:Icons.map,onPress: (){ Navigator.push(context,MaterialPageRoute(builder: (context)=>Baskets()));},),
//                SizedBox(height: Dim.height20,),
//               //  ShowOpt(title:'Check your diseasase',ic:Icons.medical_information,onPress: (){ Navigator.push(context,MaterialPageRoute(builder: (context)=>Disease()));},),
              
//               ],
//             ),
//            )
//             ],
//           ),
//         ),

class ShowOpt extends StatelessWidget {

    final VoidCallback onPress;
    final String title;
    final IconData ic;

  const ShowOpt({
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
           height: Dim.height100,
            width: Dim.width265,
             decoration: BoxDecoration(
             color: Color.fromARGB(255, 44, 41, 41),
             borderRadius: BorderRadius.circular(16),
             boxShadow: [
               BoxShadow(
               color: Color.fromARGB(100, 51, 209, 48), spreadRadius: 1,blurRadius: 4,offset:Offset (4,3),
             ),
            
             ]
           ), 
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            Icon(ic,color:Colors.white),
            SizedBox(width:Dim.width10),
            Text(title,style: TextStyle(color:Colors.white,fontSize: Dim.font16,),)
           ] ),   
           
              )
              ),
        );
      }
    }

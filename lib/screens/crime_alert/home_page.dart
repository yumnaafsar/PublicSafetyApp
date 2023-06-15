import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:public_safety_app/screens/crime_alert/report_crime.dart';
import 'package:public_safety_app/widgets/app_bar.dart';


import '../../utils/dimension.dart';
import 'alerttry.dart';
import 'map_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  

  @override
  
  Widget build(BuildContext context) {

    return Scaffold(
      // drawer: Drawer(
      //   backgroundColor: Colors.black,
      //   child: ListView(
      //     children: [
      //       UserAccountsDrawerHeader(
      //           decoration: BoxDecoration(
      //               color: Colors.green
      //           ),
      //           currentAccountPicture: Image.asset("Images/use1.webp"),
      //           accountName: Text("Marium"),
      //           accountEmail: Text("marium@gmail.com")),

      //       ListTile(

      //         leading: Icon(Icons.person,
      //           color: Colors.white,),
      //         title:Text('Username',
      //           style: TextStyle(
      //               color: Colors.white
      //           ),),
      //         subtitle:Text("Marium",
      //           style: TextStyle(
      //               color: Colors.white
      //           ),),
      //         trailing:Icon(Icons.edit
      //           ,color: Colors.white,),
      //         onTap: (){

      //         },
      //       ),
      //       ListTile(

      //         leading: Icon(Icons.key,
      //           color: Colors.white,),
      //         title:Text('Password',
      //           style: TextStyle(
      //               color: Colors.white
      //           ),),
      //         subtitle:Text('************',
      //           style: TextStyle(
      //               color: Colors.white
      //           ),),
      //         trailing:Icon(Icons.edit,
      //           color: Colors.white,),
      //         onTap: (){

      //         },
      //       ),
      //       SizedBox(
      //         height: Dim.height200,
      //       ),
      //       TextButton(onPressed: (){
      //         // Navigator.push(
      //         //     context,
      //         //     MaterialPageRoute(builder: (context) =>LoginPage()));
      //       }, child: Text('Logout',
      //         style: TextStyle(
      //             color: Colors.white
      //         ),)) ,
      //       TextButton(onPressed: (){}, child: Text('Settings',
      //         style: TextStyle(
      //             color: Colors.white
      //         ),))
      //     ],
      //   ),

      // ),
      body: 
      SafeArea(
        child: SingleChildScrollView(
          child: Container(
          child: Column(
            children: [
              customizedAppBar(),
        
               SizedBox(height: Dimensions.height30,),

              Text('Crime Reporting', style: TextStyle(
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>Alerts()))
                          },
                          child: optionContainer('Crime Alerts')),
                         GestureDetector(
                          onTap: ()=>{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()))
                          },
                          child: optionContainer('View Crime Areas'))
                      ],
                    ),
                    SizedBox(height: Dimensions.height30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [ 
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CrimeReport()));
                          },
                          child: optionContainer('Report Crime')),
                       
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







// Column(
      //   children: [
      //     customizedAppBar(),
      //     Expanded(
      //       child: GridView(gridDelegate:
      //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
      //           childAspectRatio: 1 / .95,
      //           crossAxisSpacing: 5,
      //           mainAxisSpacing: 5),
      //         children: [
      //           Padding(
      //             padding:  EdgeInsets.all(Dim.width19),
      //             child: GestureDetector(
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => const Alerts()));
      //               },
      //               child: Container(
      //                 margin: EdgeInsets.all(Dim.height5),

      //                 decoration: BoxDecoration(
      //                   color: Colors.black,
      //                   borderRadius: BorderRadius.circular(Dim.width19),
      //                   border: Border.all(width: Dim.width5,
      //                     color: Colors.lightGreen,

      //                   ),
      //                 ),
      //                 child: Center(child: Text('Crime Alerts',
      //                   style: TextStyle(
      //                     fontFamily: "Times New Roman",
      //                     color: Colors.white,
      //                     fontSize: Dim.height12,
      //                     fontWeight: FontWeight.bold,

      //                   ),
      //                 )),
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding:  EdgeInsets.all(Dim.width19),
      //             child: GestureDetector(
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) =>  MapScreen()));
      //               },
      //               child: Container(
      //                 margin: EdgeInsets.all(Dim.height5),

      //                 decoration: BoxDecoration(
      //                   color: Colors.black,
      //                   borderRadius: BorderRadius.circular(Dim.width19),
      //                   border: Border.all(width: Dim.width5,
      //                     color: Colors.lightGreen,
      //                   ),
      //                 ),
      //                 child: Center(child: Padding(
      //                   padding:  EdgeInsets.all(Dim.font12),
      //                   child: Text('View Crime Areas',
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(

      //                       color: Colors.white,
      //                       fontSize: Dim.height12,
      //                       fontWeight: FontWeight.bold,
      //                       fontFamily: "Times New Roman",
      //                     ),),
      //                 )),
      //               ),
      //             ),
      //           ),
      //           Center(
      //             child: Padding(
      //               padding: EdgeInsets.all(Dim.width19),
      //               child: GestureDetector(
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => CrimeReport()));
      //                 },
      //                 child: Container(
      //                   margin: EdgeInsets.all(Dim.height5),

      //                   decoration: BoxDecoration(
      //                     color: Colors.black,
      //                     borderRadius: BorderRadius.circular(Dim.width19),
      //                     border: Border.all(width: Dim.width5,
      //                       color: Colors.lightGreen,
      //                     ),
      //                   ),
      //                   child: Center(child: Text('Report Crime',
      //                     style: TextStyle(
      //                         fontFamily: "Times New Roman",
      //                         color: Colors.white,
      //                         fontSize: Dim.height12,
      //                         fontWeight: FontWeight.bold
      //                     ),)),
      //                 ),
      //               ),
      //             ),
      //           ),

      //         ],

      //       ),
      //     )
      //   ],
      // ),
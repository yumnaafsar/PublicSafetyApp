import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:public_safety_app/screens/personal_safety.dart';
import 'package:public_safety_app/screens/register.dart';
import 'package:public_safety_app/utils/dimension.dart';

import '../widgets/custom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

   void login() async
    {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db=FirebaseFirestore.instance;

      final String email=emailController.text;
      final String password=passwordController.text;

      try {
      final UserCredential user= await auth.signInWithEmailAndPassword(email: email, password: password);
      final DocumentSnapshot snapshot= await db.collection("users").doc(user.user?.uid).get();

      final data= snapshot.data();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => personalSaftey()));
      Navigator.of(context).pushNamed('/frontPage',arguments: data);

      } catch (e) {
        print("error");
        showDialog(context: context, builder:(BuildContext context){
          return AlertDialog(content: Text(e.toString()),);
        });
        print(e);
      }
     
    }

  // @override
  //   void dispose()
  //   {
  //     emailController.dispose();
  //     passwordController.dispose();
  //     super.dispose();
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            
             image: DecorationImage(image: AssetImage('assets/images/security_bg.jpg',
             ),
              fit: BoxFit.cover,
             ),
            
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // customBar(),
              Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font50, color: Colors.white),),
              SizedBox(height: Dimensions.height50,),
              textFeild('Email', 'Enter email', emailController,'Email can not be empty'),
              textFeild('Password', 'Enter password atleast 6 digits',passwordController, 'Paswword can not be empty'),

              SizedBox(height:Dimensions.height30,),


            GestureDetector(
              onTap: login
              // (){
              //   FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                
              // }
              ,
                child: Container(
                          height: Dimensions.height50,
                          width: Dimensions.width250,
                          decoration: BoxDecoration(
                             color: Colors.black,
                              borderRadius: BorderRadius.circular(Dimensions.radius35),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 103, 138, 106),
                                    blurRadius: 5.0,
                                    offset: Offset(0, 5)),
                                BoxShadow(
                                    color: Color.fromARGB(255, 69, 158, 76),
                                    blurRadius: 5.0,
                                    offset: Offset(-5, 5))
                              ],
                            ),
                          child: Center(child: Text('Login',style: TextStyle(color: Colors.white, fontSize:Dimensions.font25, fontWeight: FontWeight.bold ),)),
                        ),
              ),

              SizedBox(height: Dimensions.height10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(color: Colors.white,fontSize: Dimensions.font15, fontWeight: FontWeight.w800),),
                  SizedBox(width: Dimensions.width20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: Text('SignUp',style: TextStyle(color: Colors.white,fontSize: Dimensions.font15, fontWeight: FontWeight.w800),)),
                ],
              ),
              

            ],
            
          ),
        )),
    );
  }
}


Widget textFeild(String _labelText, String _hintText, _controller, String message) {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left:Dimensions.width20),
            child: Text(
              _labelText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, bottom: Dimensions.height15, top: Dimensions.height15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius35),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 17, 131, 26),
                blurRadius: 5.0,
                offset: Offset(0, 5)),
            BoxShadow(
                color: Color.fromARGB(255, 14, 114, 22),
                blurRadius: 5.0,
                offset: Offset(-5, 5))
          ],
        ),
        child: TextFormField(
          controller: _controller,
          style: TextStyle(fontSize: Dimensions.font20, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width16),
          ),
          validator: (value){
                            if (value! .isEmpty){
                              return message;
                            }else
                               return null;
                          },
        ),
      ),
    ],
  );
}

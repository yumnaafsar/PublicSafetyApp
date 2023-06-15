import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:public_safety_app/utils/dimension.dart';
// import 'package:public_safety_app/screens/personal_safety.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {

  
TextEditingController nameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();

void register() async
    {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db=FirebaseFirestore.instance;

      final String username=nameController.text;
      final String email=emailController.text;
      final String password=passwordController.text;

      try {
        final UserCredential user= await auth.createUserWithEmailAndPassword(email: email, password: password);
        final QuerySnapshot snapshot = await db.collection("RegisteredUsers").get();
        final int userCount = snapshot.docs.length;

        final customId = 'User${userCount + 1}';
        await db.collection("RegisteredUsers").doc(customId).set({
           "email": email,
           "username": username,
           "password": password
        }
        );
        print("user is registered");
        Navigator.of(context).pushNamed('/userInfo',);
      } catch (e) {
        print("error");
      }
     
    }



  @override
    void dispose()
    {
      emailController.dispose();
      nameController.dispose();
      passwordController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        

          child: Container(
            width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
      
            decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/security_bg.jpg'),
        fit: BoxFit.fill,
      ),
    ),
      
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
      
                Text('Register', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font50, color: Colors.white),),
                SizedBox(height: Dimensions.height30,),
                textFeild('Username', 'Enter username',nameController),
                textFeild('Email', '', emailController),
                textFeild('Password', '', passwordController),
      
                SizedBox(height: Dimensions.height65,),
      
                GestureDetector(
                  onTap: register,
                  // (){
                  //   FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                  //    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  // },
                  child: Container(
                            height: Dimensions.height50,
                            width: Dimensions.width250,
                            decoration: BoxDecoration(
                               color: Colors.black,
                                borderRadius: BorderRadius.circular(35.0),
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
                            child: Center(child: Text('Register',style: TextStyle(color: Colors.white, fontSize:Dimensions.font25, fontWeight: FontWeight.bold ),)),
                          ),
                ),
                 SizedBox(height: Dimensions.height10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: Colors.white,fontSize: Dimensions.font15, fontWeight: FontWeight.w800),),
                    SizedBox(width: Dimensions.width20,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: Dimensions.font15, fontWeight: FontWeight.w800),)),
                  ],
                ),
      
      
              ],
              
            ),
          ),
      ),
    );
  }
}

Widget textFeild(String _labelText, String _hintText, _controller) {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: Dimensions.width20),
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
        ),
      ),
    ],
  );
}

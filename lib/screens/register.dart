import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:public_safety_app/screens/personal_safety.dart';

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
        await db.collection("RegisteredUsers").doc(user.user?.uid).set({
           "email": email,
           "username": username,
           "password": password
        }
        );
        print("user is registered");
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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

              Text('Register', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),),
              SizedBox(height: 30,),
              textFeild('Username', 'Enter username',nameController),
              textFeild('Email', '', emailController),
              textFeild('Password', '', passwordController),

              SizedBox(height: 65,),

              GestureDetector(
                onTap: register,
                // (){
                //   FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                //    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                // },
                child: Container(
                          height: 50,
                          width: 250,
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
                          child: Center(child: Text('Register',style: TextStyle(color: Colors.white, fontSize:25, fontWeight: FontWeight.bold ),)),
                        ),
              )


            ],
            
          ),
        )),
    );
  }
}

Widget textFeild(String _labelText, String _hintText, _controller) {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              _labelText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.0),
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
          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ),
    ],
  );
}

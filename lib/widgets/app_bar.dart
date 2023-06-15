import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:public_safety_app/utils/dimension.dart';
import 'package:cached_network_image/cached_network_image.dart';


class customizedAppBar extends StatefulWidget {
  const customizedAppBar({
    super.key});

  @override
  State<customizedAppBar> createState() => _customizedAppBarState();
}

class _customizedAppBarState extends State<customizedAppBar> {

  dynamic data;
  late User? currentUser;
  String name='';
  String city='';
  String image='';
  

Future<void> getData() async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("UserInformation")
        .doc(currentUser.uid)
        .get();

    if (snapshot.exists) {
      setState(() {
      name = snapshot.get('name') as String? ?? '';
      city = snapshot.get('city') as String? ?? '';
      image = snapshot.get('imageUrl') as String? ?? '';
      });
    }
  }
}


 @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      getData();
    }
  }


  @override
  Widget build(BuildContext context) {
    return CustomPaint(

        painter: AppbarPainter(),
        size: Size(Dimensions.width400, Dimensions.height210),
        child: _appBarContent(),
      );
  }

  Widget _appBarContent(){
  return Container(
    height: Dimensions.height210,
    width: Dimensions.width450,
    // margin: EdgeInsets.symmetric(vertical: Dimensions.width40),
    margin: EdgeInsets.only(bottom: Dimensions.height20, top: Dimensions.height20),
    child: Column(
      children: [
        _header(),
        SizedBox(height: Dimensions.height10,),
        _userInfo(),
        // SizedBox(height: 10,),
        _menuOptions()
      ],
    ),
  );
 }

 Widget _header(){
  return Padding(
    padding: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5, top: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_rounded, color: Colors.white, size: Dimensions.icon30,)),
        Icon(Icons.menu, color: Colors.white, size: 30,)
      ],
    ),
  );
 }

 Widget _userInfo(){
  return Padding(
    padding: EdgeInsets.only(left:Dimensions.height10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userAvatar(),
        SizedBox(width: Dimensions.width20,),
        Expanded(
          flex: 1,
          child:Column(
            children: [
              _userPersonalInfo(),
              SizedBox(height: Dimensions.height25,),
            ],
          )
          ),
      ],
    ),
  );
 }

 Widget _userAvatar(){
  return CircleAvatar(
    radius: Dimensions.radius35,
    backgroundImage: NetworkImage(image != null ? image : ''),
  );
 }

 Widget _userPersonalInfo() {
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.width5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                   name != null ? name : '',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font28,
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: Dimensions.height10, ),
                    Row(
                      children:[
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: Dimensions.icon15,
                        ),
                        SizedBox(width: Dimensions.width5, ),
                        Row(
                          children: [
                            Text(
                              city != null ? city : '',
                              style: TextStyle(
                                fontSize: Dimensions.font15, //13
                                letterSpacing: 2,
                                color: Colors.white
                              ),
                            ),
                            SizedBox(width: 2,),
                            Text(
                              ', Pakistan',
                              style: TextStyle(
                                fontSize: Dimensions.font15, //13
                                letterSpacing: 2,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
              ],
            ),
          ),
         
        ],
      ),
    );
  }


}

Widget _menuOptions(){
  return Expanded(child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _menuButton('Personal Saftey'),
            _menuButton('Crime Report'),
            _menuButton('Missing Person')

          ],
        ),
      ],
    )
    );
}

Widget _menuButton(String text){
  return Padding(
    padding: EdgeInsets.all(0), //8
    child: Container(
                height: Dimensions.height30,
                width: Dimensions.width130,
                child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top:Dimensions.height5, bottom: Dimensions.height5),//4
                      child: Text(text, style: TextStyle(
                          color: Color.fromARGB(255, 14, 114, 22),
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font9,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                  ),
              ),
  );
}

class AppbarPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size){

    var rect= Offset.zero & size;
    Paint paint= Paint();
    Path path= Path();

    paint.shader= const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors:[
        Colors.black,
        Color.fromARGB(100, 51, 209, 48)
      ]
       ).createShader(rect);

    path.lineTo(0, size.height- size.height/8);
    path.conicTo(size.width/1.2,size.height, size.width, size.height- size.height/8, Dimensions.height25);
    path.lineTo(size.width, 0);
    canvas.drawShadow(path, Colors.black, 6, false);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate){
    
    return true;
  }
}
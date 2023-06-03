import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class customizedAppBar extends StatefulWidget {
  const customizedAppBar({
    super.key});

  @override
  State<customizedAppBar> createState() => _customizedAppBarState();
}

class _customizedAppBarState extends State<customizedAppBar> {

  @override
  Widget build(BuildContext context) {
    return CustomPaint(

        painter: AppbarPainter(),
        size: const Size(400, 210),
        child: _appBarContent(),
      );
  }

  Widget _appBarContent(){
  return Container(
    height: 190,
    width: 400,
    margin: EdgeInsets.symmetric(vertical: 40),
    child: Column(
      children: [
        _header(),
        SizedBox(height: 20,),
        _userInfo(),
        // SizedBox(height: 10,),
        _menuOptions()
      ],
    ),
  );
 }

 Widget _header(){
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30,)),
        Icon(Icons.menu, color: Colors.white, size: 30,)
      ],
    ),
  );
 }

 Widget _userInfo(){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _userAvatar(),
      SizedBox(width: 20,),
      Expanded(
        flex: 1,
        child:Column(
          children: [
            _userPersonalInfo(),
            SizedBox(height: 25,),
          ],
        )
        ),
    ],
  );
 }

 Widget _userAvatar(){
  return CircleAvatar(
    radius: 35,
    backgroundImage: AssetImage('assets/images/avatar.jpg'),
  );
 }

 Widget _userPersonalInfo() {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Yumna',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 10, ),
                    Row(
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 5, ),
                        Text(
                          'Karachi Pakistan',
                          style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 2,
                            color: Colors.white
                          ),
                        ),
                      ],
                    )
              ],
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     height: 30,
          //     child: const Center(
          //         child: Text(
          //           'Location',
          //           style: TextStyle(
          //             color: Color.fromARGB(255, 14, 114, 22),
          //             fontWeight: FontWeight.w500,
          //             fontSize: 16
          //           ),
          //         ),
          //       ),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //   ),
          // )
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
    padding: const EdgeInsets.all(8.0),
    child: Container(
                height: 25,
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(text, style: TextStyle(
                          color: Color.fromARGB(255, 14, 114, 22),
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
    path.conicTo(size.width/1.2,size.height, size.width, size.height- size.height/8, 25);
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
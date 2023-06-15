
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:public_safety_app/utils/dimension.dart';
import 'package:firebase_auth/firebase_auth.dart';

class customBar extends StatefulWidget {
  final title;
  const customBar({
    required this.title,
    super.key});

  @override
  State<customBar> createState() => _customBarState();
}

class _customBarState extends State<customBar> {


  @override
  Widget build(BuildContext context) {
    return CustomPaint(

        painter: AppbarPainter(),
        size: Size(Dimensions.width450, Dimensions.height210),
        child: _appBarContent(),
      );
  }


  Widget _appBarContent(){
  return Container(
    height: Dimensions.height60,
    width: Dimensions.width450,
    // margin: EdgeInsets.symmetric(vertical: Dimensions.height40),
    margin: EdgeInsets.only(top: Dimensions.height50, bottom: Dimensions.height20),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_rounded, color: Colors.white, size: Dimensions.icon30,)),
        Text(widget.title,style: TextStyle(color: Colors.white,fontSize: Dimensions.font25, fontWeight: FontWeight.w600),),
        Icon(Icons.menu, color: Colors.white, size: Dimensions.icon30,)
      ],
      ),
    )
  );
 }

 

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
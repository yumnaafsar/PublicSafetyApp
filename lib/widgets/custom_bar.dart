import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class customBar extends StatefulWidget {
  const customBar({super.key});

  @override
  State<customBar> createState() => _customBarState();
}

class _customBarState extends State<customBar> {
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
    height: 30,
    width: 400,
    margin: EdgeInsets.symmetric(vertical: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30,)),
      Text('Report Harassement',style: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.w600),),
      Icon(Icons.menu, color: Colors.white, size: 30,)
    ],
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
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class CameraService extends StatefulWidget {
  const CameraService({super.key});

  @override
  State<CameraService> createState() => _CameraServiceState();
}

class _CameraServiceState extends State<CameraService> {
  File? file;

  Future<void> getImage(bool isCamera) async{

    XFile? image;
    ImagePicker picker =ImagePicker();

    if(isCamera){
      image=await picker.pickImage(source: ImageSource.camera, maxHeight: 5000,maxWidth: 5000,imageQuality: 100, );
    }
    else{
      image=await picker.pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      file = File(image.path);
      // Now you can use the `file` variable, which is of type `File`.
    }
    setState(() {
      file!=image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5),
          height: 60,
          width: 175,
          decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(35.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 14, 114, 22),
                blurRadius: 5.0,
                offset: Offset(0, 5)),
            BoxShadow(
                color: Color.fromARGB(255, 14, 114, 22),
                blurRadius: 5.0,
                offset: Offset(-5, 5))
          ],
        ),
          child: ElevatedButton(onPressed: (){
            getImage(true);
            print('clicked');
          }, 
          child: Row(
            children: [
              Text('capture img', style: TextStyle(fontSize: 21),),
              SizedBox(width: 5,),
              Icon(Icons.camera_alt),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 14, 114, 22),
            elevation: 20,
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35), 
                  ), 
            shadowColor: Colors.black
            
          ),
          ),
        ),

        SizedBox(height: 10,),

        Container(
          height: 60,
          width: 170,
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 14, 114, 22),
                blurRadius: 5.0,
                offset: Offset(0, 5)),
            BoxShadow(
                color: Color.fromARGB(255, 14, 114, 22),
                blurRadius: 5.0,
                offset: Offset(-5, 5))
          ],
        ),
          child: ElevatedButton(onPressed: (){
            getImage(false);
          }, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('upload',style: TextStyle(fontSize: 21),),
              SizedBox(width: 5,),
              Icon(Icons.file_copy_outlined, size: 25,),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 14, 114, 22),
            elevation: 20,
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35), 
                  ), 
            shadowColor: Colors.black
            
          ),
          ),
        ),

        Container(
          child:
          file == null
                    ? Text('')
                    : Container(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Image.file(file!, height: 500, width: 500)),
                  ),
                ),
          
        ),
      ],
    );
  }
}
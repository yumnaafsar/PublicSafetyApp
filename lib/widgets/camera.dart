import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CameraService extends StatefulWidget {
  final void Function(String imageUrl) onImageUrlReceived;
  final imgDir;

  const CameraService({
    required this.imgDir,
    required this.onImageUrlReceived, Key? key})
      : super(key: key);

  @override
  State<CameraService> createState() => _CameraServiceState();
}

class _CameraServiceState extends State<CameraService> {
  String imageUrl = '';

  Future<void> _captureImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file =
        await imagePicker.pickImage(source: ImageSource.camera);
    print('${file?.path}');

    if (file == null) return;

    String uniqueFileName =
        DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages =
        referenceRoot.child(widget.imgDir);
    Reference referenceImageToUpload =
        referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      widget.onImageUrlReceived(imageUrl); // Call the callback function
    } catch (error) {
      // Handle error
    }
  }

Future<void> _UploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');

    if (file == null) return;

    String uniqueFileName =
        DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages =
        referenceRoot.child(widget.imgDir);
    Reference referenceImageToUpload =
        referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      widget.onImageUrlReceived(imageUrl); // Call the callback function
    } catch (error) {
      // Handle error
    }
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
          child: ElevatedButton(
          onPressed: _captureImage,
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
          child: ElevatedButton(onPressed: _UploadImage,
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

      ],
    );
  }
}



import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:public_safety_app/utils/dimension.dart';

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
          margin: EdgeInsets.only(left: Dimensions.width5),
          height: Dimensions.height60,
          width: Dimensions.width180,
          decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius35),
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
              Text('capture img', style: TextStyle(fontSize: Dimensions.font15),),
              SizedBox(width: Dimensions.width5,),
              Icon(Icons.camera_alt, size: Dimensions.icon30,),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 14, 114, 22),
            elevation: 20,
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius35), 
                  ), 
            shadowColor: Colors.black
            
          ),
          ),
        ),

        SizedBox(height: Dimensions.height10,),

        Container(
          height: Dimensions.height60,
          width: Dimensions.width170,
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius35),
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
              Text('upload',style: TextStyle(fontSize: Dimensions.font15),),
              SizedBox(width: Dimensions.width20,),
              Icon(Icons.file_copy_outlined, size: Dimensions.icon30,),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 14, 114, 22),
            elevation: 20,
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius35), 
                  ), 
            shadowColor: Colors.black
            
          ),
          ),
        ),

      ],
    );
  }
}



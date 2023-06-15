import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:public_safety_app/screens/missing_persons/showmissing.dart';
import 'package:public_safety_app/widgets/custom_bar.dart';

import '../../utils/dim.dart';
class Reort2 extends StatefulWidget {
  const Reort2({super.key});

  @override
  State<Reort2> createState() => _Reort2State();
}

class _Reort2State extends State<Reort2> {
  String gender = "Male";
  DateTime date=DateTime(2023,05,13);
  TimeOfDay time=TimeOfDay(hour: 10, minute: 30);
  File? _image;
  String imageurl='';
   TextEditingController _fullname=TextEditingController();
  TextEditingController _nic=TextEditingController();
  TextEditingController _age=TextEditingController();
  TextEditingController _religion=TextEditingController();
  TextEditingController _identity=TextEditingController();
  TextEditingController _height=TextEditingController();
  TextEditingController _dresscolour=TextEditingController();
  TextEditingController _resid=TextEditingController();
  TextEditingController _location=TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController keys = TextEditingController();
  
  Future getImage () async{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null){
      return;
    }
    final imageTemporary = File(image.path);
    setState(() {
      this._image=imageTemporary;
    });
  }

  Future _selectDate(BuildContext context) async {
      DateTime? newDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(1970), lastDate: DateTime(2025)); 
      if (newDate==null){
        return;
      }
      setState(() {
        date=newDate;         
     }
    );
                  
  }

   Future _selectTime(BuildContext context) async {
    TimeOfDay?newTime=await showTimePicker(context: context, initialTime: time,); 
                if (newTime==null){
                  return;
                }
                setState(() {
                  time=newTime;
             
                }
                );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
      SingleChildScrollView(
      child: Column(
     
        children: [
          customBar(title: 'Report Missing Person'),
          SizedBox(height:Dim.height5),
          MytextFeild("Full Name", "Enter Full Name ",_fullname),
          MytextFeild("NIC", "Enter CNIC number",_nic),
           Row(children: [
                  SizedBox(width: Dim.width15,),
                  Text("Gender",style: TextStyle(color: Colors.green,fontSize: Dim.font15,fontWeight:FontWeight.bold),),
                  SizedBox(width: Dim.width15,),
                  Radio(
                  value: "Male" ,
                  activeColor: Colors.green, groupValue: gender, onChanged: (value) { setState(() {
                    gender=value.toString();
                  });},
                ),
                SizedBox(width: Dim.width2,),
                Text("Male",style: TextStyle(color: Colors.grey,fontSize: Dim.font15),),
                SizedBox(width: Dim.width19,),
                
                Radio(
                  value: "Female" ,
                  
                  activeColor: Colors.green, groupValue: gender, onChanged: (value) { setState(() {
                    gender=value.toString();
                  });
                  },
                ),
                SizedBox(width: Dim.width2,),
                Text("Female",style: TextStyle(color: Colors.grey,fontSize: Dim.font15),),
                
                ],),
                
                MytextFeild("Age", "Enter the age ",_age),
          SizedBox(height: Dim.height5,),

                MytextFeild("Height", "Enter approx height ",_height),
          SizedBox(height: Dim.height5,),
                
                MytextFeild("Religion", "Enter religion/belief",_religion),
          SizedBox(height: Dim.height5,),
          MytextFeild("Specific Identity", "Enter any specific mark ",_identity),
          SizedBox(height: Dim.height5,),
              MytextFeild("Residence", "Enter permanent address",_resid),
          SizedBox(height: Dim.height5,),
          //MytextFeild("Last Seen Location", "Enter last seen location",_location),
          //SizedBox(height: Dim.height5,),
           MytextFeild("Dress worn", "Enter type & color of dress",_dresscolour),
          SizedBox(height: Dim.height5,),
           SizedBox(height: Dim.height5,),     
          MytextFeild("Unique Key", "Enter any unique code",keys),
          SizedBox(height: Dim.height5,),
           MytextFeild("Reporter Contact", "Enter relative/reporter cellnumber",number),
          SizedBox(height: Dim.height5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Select Lost Date",style: TextStyle(color:Colors.green,fontSize: Dim.font13),),
              GestureDetector(
            onTap:()=> _selectDate(context),
            child: Container(
              width: Dim.width140,
              height: Dim.height40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color:Colors.white,boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 69, 158, 76),
                              blurRadius: 2.0,
                             offset: Offset(0, 5)
                             ),
                          BoxShadow(
                              color: Color.fromARGB(255, 69, 158, 76),
                              blurRadius: 2.0,
                             offset: Offset(-5, 5)
                             )
                        ], ),
              child: Row(
            children:[
              SizedBox(width:Dim.width5),
              Icon(Icons.calendar_today_rounded,color: Colors.green,),
              Text(date != null?' ${date.day}/${date.month}/${date.year}':"dd-mm-yy",style: TextStyle(color:Colors.green,fontSize: Dim.font13),),
          
            ]
            
          
              ),
          
            ),
          ),
                
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Select Lost Time",style: TextStyle(color:Colors.green,fontSize: Dim.font13),),
              GestureDetector(
            onTap:()=> _selectTime(context),
            child: Container(
              width: Dim.width140,
              height: Dim.height40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color:Colors.white,boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 69, 158, 76),
                              blurRadius: 2.0,
                              offset: Offset(0, 5)
                             ),
                          BoxShadow(
                              color: Color.fromARGB(255, 69, 158, 76),
                              blurRadius: 2.0,
                              offset: Offset(-5, 5)
                             )
                        ], ),
              child: Row(
            children:[
              SizedBox(width:Dim.width5),
              Icon(Icons.timer,color:Colors.green),
              Text(time != null?' ${time.hour.toString()}:${time.minute.toString()}pm':"hh:mm",style: TextStyle(color:const Color.fromARGB(255, 25, 172, 30),fontSize: Dim.font13),),
          
            ]
            
          
              ),
          
            ),
          ),
            ],)
          ],),

          SizedBox(height: Dim.height15,),
          Text("Select Picture",style: TextStyle(color:const Color.fromARGB(255, 30, 160, 35),fontSize: Dim.font16, fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton.icon(onPressed: () async{
              ImagePicker imagePicker=ImagePicker();
    XFile? files=await imagePicker.pickImage(source: ImageSource.gallery);
    print('${files?.path}');
    
    if(files==null){
      return;
    }
      String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot=FirebaseStorage.instance.ref();
      Reference referenceDirImages=referenceRoot.child('images');
      Reference referenceImagetoUpload=referenceDirImages.child(uniqueFileName);
      await referenceImagetoUpload.putFile(File(files.path));
      imageurl = await referenceImagetoUpload.getDownloadURL();
          }, icon: Icon(Icons.image), label: Text("Gallery"),style: ElevatedButton.styleFrom(primary: Colors.green)),
         
            ElevatedButton.icon(onPressed:() async{
              ImagePicker imagePicker=ImagePicker();
    XFile? files=await imagePicker.pickImage(source: ImageSource.camera);
    print('${files?.path}');
    
    if(files==null){
      return;
    }
      String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot=FirebaseStorage.instance.ref();
      Reference referenceDirImages=referenceRoot.child('images');
      Reference referenceImagetoUpload=referenceDirImages.child(uniqueFileName);
      await referenceImagetoUpload.putFile(File(files.path));
      imageurl = await referenceImagetoUpload.getDownloadURL();
          }, icon: Icon(Icons.camera), label: Text("Capture"),style: ElevatedButton.styleFrom(primary: Colors.green)),
          ],),
          SizedBox(height: Dim.height15,),
         
          ElevatedButton(onPressed: () async {
                

                if(imageurl.isEmpty){

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Plz upload an image")));
                  return;
                }
                
                Map <String,String> dataToSave ={
                  'name':_fullname.text,
                  'nic':_nic.text,
                  'age':_age.text,
                  'religion':_religion.text,
                  'identity':_identity.text,
                  'height':_height.text,
                  'residence':_resid.text,
                  'dress':_dresscolour.text,
                  'gender':gender,
                  'location':_location.text,
                   'cellnumber':number.text.toString(),
                   'lostdate':('${date.day}/${date.month}/${date.year}'),
                   'losttime':('${time.hour}:${time.minute}'),
                   'image':imageurl,
                   'ukey':keys.text,
                };
              

                FirebaseFirestore.instance.collection('Missingpersons').add(dataToSave);
                
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Baskets()));
          }, child: Text("Post",style:TextStyle(fontSize: Dim.font19)),style: ElevatedButton.styleFrom(primary: Colors.black,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),elevation: 10, shadowColor: Color.fromARGB(255, 69, 158, 76),padding: EdgeInsets.only(left:Dim.font30,right:Dim.font30,top:Dim.height10,bottom:Dim.height10)),),

                  SizedBox(height: Dim.height10,)

          

         
          
        ],
        ),
        ),
    );
  }
}

Widget MytextFeild(String _labelText, String _hintText, TextEditingController c) {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: Dim.height20),
            child: Text(
              _labelText,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: Dim.font15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(left: Dim.height15, right: Dim.height15, bottom: Dim.height15, top: Dim.height5),
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
        child: TextFormField(
          controller: c,
          style: TextStyle(fontSize: Dim.font19),
          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Color.fromARGB(255, 42, 187, 29), fontSize: Dim.font15),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: Dim.font16),
          ),
        ),
      ),
    ],
  );
}




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:public_safety_app/screens/crime_alert/models/alert_model.dart';

import '../../utils/dim.dart';
import 'crime_help.dart';



const List<String> list = <String>['Karachi', 'Lahore', 'Faisalabad', 'Rawalpindi'];
const List<String> list1 = <String>['Karachi East', 'Kasur', 'Sheikhupura', 'Nankana Sahib'];
class CrimeReport extends StatefulWidget  {

  @override
  State<CrimeReport> createState() => _CrimeReportState();
}

class _CrimeReportState extends State<CrimeReport> {
  @override

  DateTime date1=DateTime.now();
  void _showDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025)).then((value){
      setState(() {
        date1=value!;
      });
    });
  }
  final _formKey = GlobalKey<FormState>();
    final controller1=TextEditingController();
    final controller2=TextEditingController();
    final controller3=TextEditingController();
    final controller4=TextEditingController();
    final controller5=TextEditingController();

    //camera code
  File? file;
  String imageUrl='';
  Future  getImage(bool isCamera) async{

    XFile? image;
    ImagePicker picker =ImagePicker();

    if(isCamera){
      image=await picker.pickImage(source: ImageSource.camera,
        maxHeight: 10000,maxWidth: 10000,imageQuality: 100, );
    }
    else{
      image=await picker.pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      file = File(image.path);
      // Now you can use the `file` variable, which is of type `File`.
      file!=image;
    }
    setState(() {

    });
    //new code


  }


  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;



    TimeOfDay _time =TimeOfDay(hour: 8, minute:30);
    void _showTimePicker(){
      showTimePicker(
          context: context, initialTime: TimeOfDay.now()).then((value){
        setState(() {
          _time=value!;
        });
      });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 131, 26),

      title: Text("Crime Report"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              textField('Title', 'Enter Title of Report',controller1
              ),
              textField('Reporter Name', 'Enter Reporter Name ',controller2
              ),

              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: Dim.width15),
                    child: Text(
                      "Select City",style: TextStyle(
                        color: Colors.black,
                        fontSize: Dim.height15,
                        fontWeight: FontWeight.bold
                    ),
                    ),)
                ],
              ),
              Container(
                width: Dim.width400,
                padding: EdgeInsets.only(left: Dim.height20),
                margin: EdgeInsets.only(left: Dim.width15,right:  Dim.width15,bottom:  Dim.width15,top:  Dim.width15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dim.height30),
                    boxShadow: [
                      BoxShadow(
                        color:           Color.fromARGB(255, 17, 131, 26),
                        blurRadius: 5,
                        offset: Offset(0,5),),
                      BoxShadow(
                        color:           Color.fromARGB(255, 17, 131, 26),
                        blurRadius: 5,
                        offset: Offset(-5,5),),

                    ]
                ),

                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),

                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),

                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: Dim.width15),
                    child: Text(
                      "Select District",style: TextStyle(
                        color: Colors.black,
                        fontSize: Dim.height15,
                        fontWeight: FontWeight.bold
                    ),
                    ),)
                ],
              ),
              Container(
                width: Dim.width400,
                padding: EdgeInsets.only(left: Dim.width19),
                margin: EdgeInsets.only(left: Dim.width15,
                    right: Dim.width15,bottom: Dim.width15,top: Dim.width5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dim.height30),
                    boxShadow: [
                      BoxShadow(
                        color:           Color.fromARGB(255, 17, 131, 26),
                        blurRadius: 5,
                        offset: Offset(0,5),),
                      BoxShadow(
                        color:           Color.fromARGB(255, 17, 131, 26),
                        blurRadius: 5,
                        offset: Offset(-5,5),),

                    ]
                ),

                child: DropdownButton<String>(
                  value: dropdownValue1,
                  icon: const Icon(Icons.arrow_downward),
                  // elevation: 16,

                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue1 = value!;
                    });
                  },
                  items: list1.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),


              textField("Enter full location details", "Enter Crime Location", controller5),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: Dim.width19),
                    child: Text(
                      "Select Time",style: TextStyle(
                        color: Colors.black,
                        fontSize: Dim.height15,
                        fontWeight: FontWeight.bold
                    ),
                    ),)
                ],
              ),
              Container(
                width: 400,
                padding: EdgeInsets.only(left: Dim.width19),
                margin: EdgeInsets.only(left: Dim.width15,
                    right: Dim.width15,bottom: Dim.width15,top: Dim.width5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dim.height30),
                    boxShadow: [
                      BoxShadow(
                        color:                   Color.fromARGB(255, 17, 131, 26),

                blurRadius: 5,
                        offset: Offset(0,5),),
                      BoxShadow(
                        color:                Color.fromARGB(255, 17, 131, 26),

          blurRadius: 5,
                        offset: Offset(-5,5),),

                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_time.format(context).toString()),
                    IconButton(
                      onPressed: (){
                    _showTimePicker();
                      },
                      icon: Icon(Icons.timelapse),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,

                      ),
                    ),

                  ],
                ),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: Dim.width19),
                    child: Text(
                      "Select Date",style: TextStyle(
                        color: Colors.black,
                        fontSize: Dim.height15,
                        fontWeight: FontWeight.bold
                    ),
                    ),)
                ],
              ),
      Container(
          width: Dim.width400,
          padding: EdgeInsets.only(left: Dim.height10),
          margin: EdgeInsets.only(left: Dim.width15,right: Dim.width15,
              bottom: Dim.width15,top: Dim.width5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dim.height30),
              boxShadow: [
                BoxShadow(
                  color:                   Color.fromARGB(255, 17, 131, 26),

          blurRadius: 5,
                  offset: Offset(0,5),),
                BoxShadow(
                  color:                  Color.fromARGB(255, 17, 131, 26),

          blurRadius: 5,
                  offset: Offset(-5,5),),

              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date1.day.toString()
                  +" / "+date1.month.toString()+" / "+date1.year.toString()),
              IconButton(
                onPressed: (){
                  _showDatePicker();
                },
                icon: Icon(Icons.date_range_sharp),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,

                ),
              ),

            ],
          ),
      ),
              // _image==null? Container(): Image.file(File(_image),height: 300,width: 300,),


              textField("Description", "Enter Crime Description", controller3),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(20),

                  child: ElevatedButton.icon(onPressed: () async{
                    getImage(false);

                  },
                      icon: Icon(Icons.camera_enhance_sharp),
                    label: Text('Upload Picture'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:              Color.fromARGB(255, 17, 131, 26),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dim.height20)
                      )
                  ),),
                  ),
                  Padding(padding: EdgeInsets.all(Dim.height15),

                  child: ElevatedButton.icon(onPressed: () async{
                    getImage(true);

                  },
                      icon: Icon(Icons.camera_alt_outlined), label: Text('Capture Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 17, 131, 26),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dim.height20)
                      )


                  ),),
                  ),
                ],
              ),
              file == null
                  ? Text('')
                  : Center(
                    child: Container(
               width: Dim.height450,
                height: Dim.height200,
                child: Padding(
                    padding:  EdgeInsets.all(Dim.height15),
                    child: Center(child: Image.file(file!, height: Dim.width290,
                        width: Dim.height450)),
                ),
              ),
                  ),
              Padding(padding: EdgeInsets.all(Dim.width19),
              child: Center(
                child: ElevatedButton(

                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print("form submitted.");
                    }
                    else
                      {
                        return;
                      }

                    if(file!=null) {
                      String uniqueImgFileName = DateTime
                          .now()
                          .millisecondsSinceEpoch
                          .toString();

                      //Get a reference to firebase storage root
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages = referenceRoot.child(
                          'images');

                      //Create a reference for the image to be stored
                      Reference referenceImageToUpload = referenceDirImages.child(
                          uniqueImgFileName);


                      //Store the Image in Firebase Storage
                      await referenceImageToUpload.putFile(file!);
                      //Get the download url
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    }
                  if(imageUrl.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Plz upload an image")));
                    return;
                  }

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                  CrimeHelp(

                    title:controller1.text ,
                    reporter: controller2.text,
                    Description: controller3.text,
                    city: dropdownValue,
                    district: dropdownValue1,
                    time1:_time ,
                    date2:date1 ,
                    image1: file!,
                    CompleteLocation: controller5.text,
                  ), ));
                    sendDatatoFirebase();

                  },
                  child: Text('Submit Report'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 17, 131, 26),

                    fixedSize: Size(Dim.width180, Dim.height40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dim.width19)
                    )
                  ),

                ),
              ),),


            ],
          ),
        ),
      ),
    );
  }
    Future<void>  sendDatatoFirebase() async{

      Alerts alert1=Alerts( title:controller1.text ,
        reporter: controller2.text,
        description: controller3.text,
        city: dropdownValue,
        district: dropdownValue1,
        time:_time.toString(),
        date: date1.toString(),
        LocationComp: controller5.text,
        image: imageUrl,

        );

      var ID1= FirebaseFirestore.instance.collection('CrimeAlerts').doc();
      // final int userCount=ID1.length;
      await ID1.set(alert1.toJson()).then((value) => {
        controller1.clear(),
        controller2.clear(),
        controller3.clear(),
        controller5.clear(),
        file==null,
        dropdownValue1=="Karachi East",
   dropdownValue=="Karachi",
        _time==_time,
        date1==date1



      }) ;
      // ID1.collection("Size").doc().set(size1.toJson());

    }
}
Widget textField(String label_Text,String hint_Text,TextEditingController controller1){
  return Column(
    children: [
      Row(
        children: [
          Padding(padding: EdgeInsets.only(left: Dim.width19),
          child: Text(
            label_Text,style: TextStyle(
            color: Colors.black,
            fontSize: Dim.height15,
            fontWeight: FontWeight.bold
          ),
          ),)
        ],
      ),
      Container(
        margin: EdgeInsets.only(left: Dim.width15,
            right: Dim.width15,bottom: Dim.width15,top: Dim.width5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dim.height30),
          boxShadow: [
            BoxShadow(
              color:           Color.fromARGB(255, 17, 131, 26),
              blurRadius: 5,
              offset: Offset(0,5),),
            BoxShadow(
              color:           Color.fromARGB(255, 17, 131, 26),
              blurRadius: 5,
              offset: Offset(-5,5),),

          ]
        ),
        child: TextFormField(
          controller: controller1,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter a $hint_Text';
            }
            return null;
          },
          style: TextStyle(fontSize: Dim.height15),
          decoration: InputDecoration(
            // labelText: label_Text,
  //           labelStyle: TextStyle(
  //           fontWeight: FontWeight.w500,
  // color: Color.fromARGB(255, 104, 99,99),
  // ),
            hintText: hint_Text,
            hintStyle: TextStyle(
              // fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 104, 99,99),
              fontSize: 15
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: Dim.width15)
          ),
        ),


      )
    ],
  );
}

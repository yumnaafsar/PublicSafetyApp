import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';


import 'package:url_launcher/url_launcher.dart';

import '../../utils/dim.dart';
import 'modeltwo.dart';

class Baskets extends StatefulWidget {
  
  const Baskets({super.key});

  @override
  State<Baskets> createState() => _BasketsState();
}

class _BasketsState extends State<Baskets> {
 
  List<Item> basketItem=[];
  @override
  void initState(){
    fetchRecords();
    super.initState();
  }


  fetchRecords() async{
    var records = await FirebaseFirestore.instance.collection('Missingpersons').get();
     mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String,dynamic>> records){
    var _list = records.docs.map((e) => Item(id:e.id,ukey:e['ukey'],age:e['age'],cellnumber:e['cellnumber'],name:e['name'],nic:e['nic'],residence:e['residence'],gender:e['gender'],identity:e['identity'],image:e['image'],lostdate:e['lostdate'],losttime:e['losttime'],dress:e['dress'],height:e['height'],religion:e['religion'])).toList();
 
   setState(() {
    basketItem=_list;
  
    print("List of Missing person pressed");
    
   
   });
  }
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar: AppBar(
        title: Text("Details of Missing Person"),
        backgroundColor: Colors.green,
      ),
      body:ListView.builder(
        itemCount: basketItem.length,      
        itemBuilder: ((context, index){
          Future<void> _dialCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: basketItem[index].cellnumber,
    );
    await launch(launchUri.toString());
  }

          return Padding(
            padding: EdgeInsets.fromLTRB(Dim.m9,Dim.m3,Dim.m9,Dim.m3),
            child: Card(
              margin: EdgeInsets.fromLTRB(Dim.m6,Dim.m12,Dim.m3,Dim.m10),         
              shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(255, 32, 61, 48),
                
              ),
              borderRadius: BorderRadius.circular(22.0), 
            ),
              
             // color: Colors.green[200],
              child: Row(
            
                children: [
                Expanded(
                flex:2,child: Container( width:Dim.width180,height:Dim.height175, child:Padding(padding:EdgeInsets.all(Dim.m12),child: Image.network('${basketItem[index].image}')))),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      SizedBox(height: Dim.height8,),
                  Text("Name:  "+basketItem[index].name,style:TextStyle(fontSize: Dim.font13)),
                  Text("NIC:  "+basketItem[index].nic,style:TextStyle(fontSize: Dim.font13)),
                  Text("Gender:  "+basketItem[index].gender,style:TextStyle(fontSize: Dim.font13)),
                  Text("Lost Date:  "+basketItem[index].lostdate,style:TextStyle(fontSize: Dim.font13)),
                   
                 
                  SizedBox(height:Dim.height5),
                    ElevatedButton(               
                            child: const Text('If found, Please call',style: TextStyle(color:Colors.black,),),
                            onPressed: () => _dialCall(),
                            style:ElevatedButton.styleFrom(primary: Color.fromARGB(255, 107, 221, 111)
                          ),),
          
                  Row(
                      children: [
                  ShowDet(FName: basketItem[index].name, Nic: basketItem[index].nic, Gender: basketItem[index].gender, Age: basketItem[index].age, Height: basketItem[index].height, Religion: basketItem[index].religion, Identity: basketItem[index].identity, Residence: basketItem[index].residence, Dress: basketItem[index].dress, LostDt: basketItem[index].lostdate, LostTime: basketItem[index].losttime, Imgurl: basketItem[index].image,Cellnumber: basketItem[index].cellnumber ,),             
          
                         MyBtn(DelId:basketItem[index].id,chKey:basketItem[index].ukey),
                  UpdateDoc(dpid: basketItem[index].id,ChKey:basketItem[index].ukey ,),   
                      ],
                  ),
                          //SizedBox(width: 7,),
                     
                   
                        
                            ],
                  ),
                )
          
                ],
              ),
              
                
            ),
          );
          

          
        } )),
    );
  

   
}
}
class MyBtn extends StatelessWidget {
   final String DelId;
   final String chKey;

  const MyBtn({
    required this.DelId,
    required this.chKey,
  });

  @override
  Widget build(BuildContext context) {
    var getkeycontroller=TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirm Remove Post?'),
                  shadowColor: Color.fromARGB(255, 56, 212, 77),      
                 // content: Text('$DelId $chKey'),
                  content: Column(
                    children: [
                       SizedBox(
            width:Dim.width140,
          child: TextFormField(   
            decoration: InputDecoration(
              focusColor: Colors.green,
              hintText: "Enter unique key",
              fillColor: Colors.green,
              
            ),     
              controller: getkeycontroller,          
            ),
        ),
        SizedBox(height: 20,),
                      ElevatedButton(onPressed: () async{
                        if(getkeycontroller.text==chKey)   {
                  await FirebaseFirestore.instance.collection('Missingpersons').doc(DelId).delete() ;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post deleted!")));
                }  
               else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Unique Key")));
                } 
                      }, child: Text("Delete"),style: ElevatedButton.styleFrom(primary: Colors.green),)
                           
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Ok'),
                      onPressed: ()  {
                         Navigator.of(context).pop();
                      },
                    ),
                  ],
                   
                );
              },
            );
          },
           icon:Icon(Icons.delete, color: Colors.green,),
        style: ElevatedButton.styleFrom(primary: Colors.green),),
      ],
    );
  }
}

class ShowDet extends StatelessWidget {
   final String FName;
   final String Nic;
   final String Gender;
   final String Age;
   final String Height;
   final String Religion;
   final String Identity;
   final String Residence;
  // final String LastSeen;
   final String Dress;
   final String LostDt;
   final String LostTime;
   final String Imgurl;
   final String Cellnumber;

  const ShowDet({
    required this.FName,
    required this.Nic,
    required this.Gender,
    required this.Age,
    required this.Height,
    required this.Religion,
    required this.Identity,
    required this.Residence,
   // required this.LastSeen,
    required this.Dress,
    required this.LostDt,
    required this.LostTime,
    required this.Imgurl,
    required this.Cellnumber,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(        
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Complete Details of \n     $FName'),
              shadowColor: Color.fromARGB(255, 56, 212, 77),      
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.calendar_month),
                    Text(LostDt,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.height10)),
                    SizedBox(width: Dim.width15,),
                      Icon(Icons.access_time_sharp),
                    Text(LostTime,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.height10)),              
                  ],),
                  SizedBox(height: 15,),
                  Center(child:CircleAvatar( radius: 70,backgroundImage:NetworkImage(Imgurl),backgroundColor: Colors.transparent,)),
                  SizedBox(height: 10,),
            Text("NIC:  "+Nic,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15)),
            Text("Age:  "+Age,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15)),
            Text("Gender:  "+Gender,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15)),
            Text("Height:  "+Height,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15)),
            Text("Religion:  "+Religion,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15)),
            Text("Identity: "+Identity,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15)),
            Text("Dress worn: "+Dress,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15)),
            Text("Residence: "+Residence,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font15)),
           // Text("Last seen at: "+LastSeen,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font17)),
            SizedBox(height: 5,),
            Text("Reporter No: ",style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font16)),
            Row(children: [
              Icon(Icons.phone,color:Colors.green),
            Text(" "+Cellnumber,style:TextStyle(fontWeight: FontWeight.bold,fontSize: Dim.font16,color:Colors.green)),
            ],),     
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: ()  {
                     Navigator.of(context).pop();
                  },
                ),
              ],
               
            );
          },
        );
      },
       child:Text("Details",style: TextStyle(color:Color.fromARGB(255, 19, 43, 20),fontSize: Dim.font12),),
    style: ElevatedButton.styleFrom(primary: Colors.white),);
  }
}

class UpdateDoc extends StatelessWidget {
   final String dpid;
   final String ChKey;
    const UpdateDoc({
    required this.dpid,
    required this.ChKey,
    });
   @override
   
  Widget build(BuildContext context) {
    var getkeycontroller=TextEditingController();

  return IconButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                title:Text("Update Record?"),
                content: Column(
                  children: [
                
                    SizedBox(width:Dim.width140,
                      child: TextFormField(
                        decoration:InputDecoration(
                          hintText:"Enter unique key",
                        ),
                         controller: getkeycontroller,     
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: () async{
                        if(getkeycontroller.text==ChKey)   {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>OpenUpdate(Upid: dpid)));                 
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Correct Unique key")));
                }  
               else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Can't update! Wrong Unique Key")));
                } 
                      }, child: Text("Go to Update"),style: ElevatedButton.styleFrom(primary: Colors.green),)
                           

                  ],
                ),
              );

            });
            
        print("Update Icon clicked");
          },icon: Icon(Icons.edit, color: Colors.green,)
          );
    
  }
}

class OpenUpdate extends StatelessWidget {
  
  //const OpenUpdate({super.key});
  final String Upid;
    const OpenUpdate({
    required this.Upid,
    });

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _nicController = TextEditingController();
    TextEditingController _ageController = TextEditingController();
    TextEditingController _religionController = TextEditingController();
    TextEditingController _heightController = TextEditingController();
    TextEditingController _dressController = TextEditingController();
    TextEditingController _residenceController = TextEditingController();
    TextEditingController _locationController = TextEditingController();
    TextEditingController _cellnumberController = TextEditingController();
    TextEditingController _identityController = TextEditingController();
    void _updateFields(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Missingpersons')
          .doc(documentId)
          .update({
        'name': _nameController.text,
        'age': _ageController.text,
        'nic': _nicController.text,
        'religion': _religionController.text,
        'height': _heightController.text,
        'identity': _identityController.text,
        'dress': _dressController.text,
        'residence': _residenceController.text,
        //'location': _locationController.text,
        'cellnumber': _cellnumberController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Record updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update fields')),
      );
    }
  }
    return Scaffold(
      appBar: AppBar(
        title:Text("Update the Record"),
        backgroundColor: Colors.green,
      ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                         .collection('Missingpersons')
                          .doc(Upid)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> documentData = snapshot.data.data();
              
                          // Set initial values for text form fields
                          _nameController.text = documentData['name'];
                          _nicController.text = documentData['nic'];
                          _ageController.text = documentData['age'];
                          _religionController.text = documentData['religion'];
                          _heightController.text = documentData['height'];
                          _identityController.text = documentData['identity'];
                          _dressController.text = documentData['dress'];
                          _cellnumberController.text = documentData['cellnumber'];
                          _residenceController.text = documentData['residence'];
                         // _locationController.text = documentData['location'];
                           return SingleChildScrollView(
                 child: Padding(
                  padding: EdgeInsets.all(Dim.m16),
                  child: Column(
                    children: [
                       TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
                      TextFormField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
              
                      TextFormField(
                        controller: _nicController,
                        decoration: InputDecoration(
                          labelText: 'CNIC',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
              
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
              
                      TextFormField(
                        controller: _religionController,
                        decoration: InputDecoration(
                          labelText: 'Religion',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
              
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
              
                      TextFormField(
                        controller: _heightController,
                        decoration: InputDecoration(
                          labelText: 'Height',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
              
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
              
                      TextFormField(
                        controller: _identityController,
                        decoration: InputDecoration(
                          labelText: 'Identity',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
              
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
              
                      TextFormField(
                        controller: _dressController,
                        decoration: InputDecoration(
                          labelText: 'Dress worn',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
              
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
              
                      TextFormField(
                        controller: _residenceController,
                        decoration: InputDecoration(
                          labelText: 'Residence',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
              
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
              
                      //TextFormField(
                      //  controller: _locationController,
                      //  decoration: InputDecoration(
                      //    labelText: 'Location',
                      //    labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
              
                      //  ),
                      //),
                    //  SizedBox(height: Dim.height5,),
              
                      TextFormField(
                        controller: _cellnumberController,
                        decoration: InputDecoration(
                          labelText: 'Reporter Cell Number',
                          labelStyle: TextStyle(color: Colors.green,fontSize: Dim.font19),
                        ),
                      ),
                      SizedBox(height: Dim.height5,),
                      SizedBox(height:Dim.height15),
                      ElevatedButton(
                        onPressed: () => _updateFields(Upid),
                        child: Text('Update'),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ],
                           
                  ),
                 ),
                           );
                        }
                        else {
                          return CircularProgressIndicator();
                        }
                      }
                           
                          ),
                  ],
                ),
              )
              
            );
  }
}
         // showDialog(
          //context: context,
          //builder: (BuildContext context) {
        //    return AlertDialog(
        //      title: Text('Update dialogue'),

        //      shadowColor: Color.fromARGB(255, 56, 212, 77),      
        //      content: Column(
        //        crossAxisAlignment: CrossAxisAlignment.start,
        //        children: [
        //          StreamBuilder(
        //stream: FirebaseFirestore.instance
        //    .collection('Missingpersons')
        //    .doc(Upid)
        //    .snapshots(),
        //builder: (BuildContext context, AsyncSnapshot snapshot) {
        //  if (snapshot.hasData) {
        //    Map<String, dynamic> documentData = snapshot.data.data();

        //    // Set initial values for text form fields
        //    _nameController.text = documentData['name'];
        //    _nicController.text = documentData['nic'];
        //    _ageController.text = documentData['age'];
        //    _religionController.text = documentData['religion'];
        //     return Padding(
        //      padding: EdgeInsets.all(16.0),
        //      child: Column(
        //        children: [
        //           TextFormField(
        //            controller: _nameController,
        //            decoration: InputDecoration(
        //              labelText: 'name 1',
        //            ),
        //          ),
        //          TextFormField(
        //            controller: _ageController,
        //            decoration: InputDecoration(
        //              labelText: 'age 2',
        //            ),
        //          ),
        //          //TextFormField(
        //          //  controller: _nicController,
        //          //  decoration: InputDecoration(
        //          //    labelText: 'nic 3',
        //          //  ),
        //          //),
        //          SizedBox(height: 16.0),
        //          ElevatedButton(
        //            onPressed: () => _updateFields(Upid),
        //            child: Text('Update'),
        //          ),
        //        ],

        //      ),
        //     );
        //  }
        //  else {
        //    return CircularProgressIndicator();
        //  }
        //}
        //          )
        //        ],
        //      ),
        //    );
         
          



//    return Row(
//      children:[
//          IconButton(onPressed: (){
//            print("I am clicke");
//         StreamBuilder(
//        stream: FirebaseFirestore.instance
//            .collection('Missingpersons')
//            .doc(Upid)
//            .snapshots(),
//        builder: (BuildContext context, AsyncSnapshot snapshot) {
//          if (snapshot.hasData) {
//            Map<String, dynamic> documentData = snapshot.data.data();

//            // Set initial values for text form fields
//            _nameController.text = documentData['name'];
//            _nicController.text = documentData['nic'];
//            _ageController.text = documentData['age'];
//            _religionController.text = documentData['religion'];
//        return Scaffold(
//           appBar: AppBar(
//        title: Text('Update Fields'),
//      ),
//            body:Padding(

//              padding: EdgeInsets.all(16.0),
//              child: Column(
//                children: [
//                  TextFormField(
//                    controller: _nameController,
//                    decoration: InputDecoration(
//                      labelText: 'name 1',
//                    ),
//                  ),
//                  TextFormField(
//                    controller: _ageController,
//                    decoration: InputDecoration(
//                      labelText: 'age 2',
//                    ),
//                  ),
//                  TextFormField(
//                    controller: _nicController,
//                    decoration: InputDecoration(
//                      labelText: 'nic 3',
//                    ),
//                  ),TextFormField(
//                    controller: _religionController,
//                    decoration: InputDecoration(
//                      labelText: 'religion 4',
//                    ),
//                  ),
//                  SizedBox(height: 16.0),
//                  ElevatedButton(
//                    onPressed: () => _updateFields(Upid),
//                    child: Text('Update'),
//                  ),
//                ],
//              ),
//            )
//            );
//          } else {
//            return CircularProgressIndicator();
//          }
//        },
//      );
 
//        },icon: Icon(Icons.edit),)
//      ],
      
//    );
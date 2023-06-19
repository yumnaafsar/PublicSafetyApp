import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_safety_app/utils/dimension.dart';
import 'package:public_safety_app/widgets/custom_bar.dart';
import 'package:shake/shake.dart';

import '../../widgets/app_bar.dart';

import 'live_loc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_sms/background_sms.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController contact1Controller = TextEditingController();
  TextEditingController contact2Controller = TextEditingController();
  TextEditingController contact3Controller = TextEditingController();

  late User? currentUser;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final contact1 = contact1Controller.text;
      final contact2 = contact2Controller.text;
      final contact3 = contact3Controller.text;

      FirebaseFirestore.instance
          .collection("EmergencyContacts")
          .doc(currentUser!.uid) // Use the user's ID as the document ID
          .set({
        "contact1": contact1Controller.text.toString(),
        "contact2": contact2Controller.text.toString(),
        "contact3": contact3Controller.text.toString(),
      }).then((value) {
        // Data successfully stored
        print("Contacts stored in Firestore");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contacts saved successfully!')),
        );
        // Reset form fields
        contact1Controller.clear();
        contact2Controller.clear();
        contact3Controller.clear();
      }).catchError((error) {
        // Error occurred while storing data
        print("Error storing data: $error");
      });
    }
  }

  dynamic data;

  Future<dynamic> getData() async {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("EmergencyContacts")
          .doc(currentUser!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          data = snapshot.data();
        });
      }
    }
  }

  Position? _currentPosition;
  String? _currentAddress;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services'),
      ));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.'),
      ));
      return false;
    }
    return true;
  }

  Future<void> _getPermission() async {
    await Permission.sms.request();
  }

  Future<bool> _isPermissionGranted() async {
    return await Permission.sms.status.isGranted;
  }

  Future<void> _getCurrentLocation() async {
    if (await _handleLocationPermission()) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      await _getAddressFromLatLon();
    }
  }

  Future<void> _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(_currentPosition!.latitude,
              _currentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _sendSms(String phoneNumber, String message,
      {int? simSlot}) async {
    if (phoneNumber.isNotEmpty && message.isNotEmpty) {
      SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber,
        message: message,
        simSlot: 1,
      );
      if (result == SmsStatus.sent) {
        print("Sent");
        Fluttertoast.showToast(msg: "SMS sent");
      } else {
        Fluttertoast.showToast(msg: "Failed to send SMS");
      }
    } else {
      Fluttertoast.showToast(msg: "Invalid phone number or message");
    }
  }

  Future<void> getAndSendSMS() async {
    // Get permission to send SMS
    bool permissionGranted = await _isPermissionGranted();
    if (!permissionGranted) {
      await _getPermission();
      permissionGranted = await _isPermissionGranted();
      if (!permissionGranted) {
        Fluttertoast.showToast(msg: "Permission denied for sending SMS");
        return;
      }
    }

    // Get current location
    await _getCurrentLocation();

    // Check if location is available
    if (_currentPosition == null || _currentAddress == null) {
      Fluttertoast.showToast(msg: "Failed to retrieve location");
      return;
    }

    // Get emergency contacts
    getData().then((value) {
      if (data != null) {
        String contact1 = data['contact1'];
        String contact2 = data['contact2'];
        String contact3 = data['contact3'];

        // Send SMS to emergency contacts
        String message =
            "Emergency! I need help! My location is: \n\n$_currentAddress";
        _sendSms(contact1, message);
        _sendSms(contact2, message);
        _sendSms(contact3, message);
      } else {
        Fluttertoast.showToast(msg: "Emergency contacts not found");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      getAndSendSMS();
      // getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customBar(title: 'Emergency Contacts'),
              SizedBox(height: Dimensions.height15,),
              Center(
                child: Text(
                  'Add Emergency Contacts',
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    textFeild('Contact 1', '+92XXXXXXXXXX', contact1Controller),
                   
                    SizedBox(height: Dimensions.height15),
                    textFeild('Contact 2', '+92XXXXXXXXXX', contact2Controller),
                    
                    SizedBox(height: Dimensions.height15),
                    textFeild('Contact 3', '+92XXXXXXXXXX', contact3Controller),
                   
                    Button('Save', submitForm)

                   
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height30),
               SizedBox(child: Divider(height: 5,color:Colors.black,),),
               SizedBox(height: 10,),
              Center(
                child: Text(
                  'Send Emergency Message',
                  style: TextStyle(
                    fontSize: Dimensions.font25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height15),
             
              Center(child: Button('Send SOS Message', getAndSendSMS)),

              SizedBox(height: Dimensions.height20,),

              Container(
                child: Column(
                  children: [
                    
                  ],
                ),
              )

               
            ],
          ),
        ),
      ),
    );
  }
}


Widget textFeild(String _labelText, String _hintText, _controller) {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: Dimensions.width20),
            child: Text(
              _labelText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, bottom: Dimensions.height15, top: Dimensions.height5),
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
        child: TextFormField(
          controller: _controller,
          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a contact number';
                        }
                        return null;
                      },
          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500, color:Color.fromARGB(255, 61, 180, 71), fontSize: Dimensions.font15),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width16),
          ),
        ),
      ),
    ],
  );
}

Widget Button(String text,VoidCallback function){
  return GestureDetector(
                        onTap: function,
                        child: Container(
                          height: Dimensions.height50,
                          width: Dimensions.width250,
                          decoration: BoxDecoration(
                             color: Colors.black,
                              borderRadius: BorderRadius.circular(35.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 103, 138, 106),
                                    blurRadius: 5.0,
                                    offset: Offset(0, 5)),
                                BoxShadow(
                                    color: Color.fromARGB(255, 69, 158, 76),
                                    blurRadius: 5.0,
                                    offset: Offset(-5, 5))
                              ],
                            ),
                          child: Center(child: Text(text,style: TextStyle(color: Colors.white, fontSize:Dimensions.font15, fontWeight: FontWeight.bold ),)),
                        ),
                      );
}

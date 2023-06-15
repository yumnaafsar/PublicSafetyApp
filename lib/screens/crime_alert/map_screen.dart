import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import 'models/address_model.dart';



//showing markers from firebase
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  // List<Marker> _markers = <Marker>[];
  Set<Marker> _markers = {};

  int num=1;

  @override
  void initState() {
    super.initState();
    _fetchMarkers();

  }


  void _fetchMarkers() async {

    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
    List<Address> addresses = [];
    List<String> title=[];
    if (await Permission.location.isGranted) {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('CrimeAlerts').get();


    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      String address = document['LocationComp'];
      String title1= document['title'];


      try {
        List<Location> locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {

          addresses.add(
            Address(
              latitude: locations.first.latitude,
              longitude: locations.first.longitude,

            ),


          );
          title.add(title1);
          print(address);
        }
      } catch (e) {
        print('Error geocoding address: $address');
      }
    }

    setState(() {
      _markers.addAll(addresses.map((address) {
        num=num+1;
        return Marker(
          markerId: MarkerId(num.toString()),
          position: LatLng(address.latitude, address.longitude),
            infoWindow: InfoWindow(title: "Recent Crimes")
        );
      }).toList());
      print(_markers);
    });
  }

  else {
  // Handle case when location permission is not granted
  print('Location permission not granted');
  }
}
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(24.904957,67.121816),
  //   zoom: 14.4746,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Markers Show Crime Areas'),
        centerTitle: true,

      ),
    body: GoogleMap(
    onMapCreated: (controller) {
    _mapController = controller;
    },
    initialCameraPosition: CameraPosition(
    target: LatLng(24.904957,67.121816), // Initial map center
    zoom: 12,
      // Initial zoom level
    ),
    markers: _markers

    ),

    );
  }
}

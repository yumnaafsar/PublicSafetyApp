import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;

class LiveLocation extends StatefulWidget {
  const LiveLocation({super.key});

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {

    final Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.427961333580664, -122.085749655962),
    zoom:14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Location Sharing'),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        compassEnabled: false,
        myLocationButtonEnabled: true,
        //markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class LiveLocationScreen extends StatefulWidget {
//   @override
//   _LiveLocationScreenState createState() => _LiveLocationScreenState();
// }

// class _LiveLocationScreenState extends State<LiveLocationScreen> {
//   GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
//   Stream<Position>? _positionStream;

//   @override
//   void initState() {
//     super.initState();
//     _startTracking();
//   }

//   void _startTracking() {
//     final locationOptions = LocationOptions(
//       accuracy: LocationAccuracy.best,
//       distanceFilter: 10, // Update every 10 meters
//     );

//     _positionStream = _geolocatorPlatform.getPositionStream(locationOptions);
//   }

//   @override
//   void dispose() {
//     _positionStream?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Live Location'),
//       ),
//       body: StreamBuilder<Position>(
//         stream: _positionStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final position = snapshot.data!;
//             return Center(
//               child: Text(
//                 'Lat: ${position.latitude}, Long: ${position.longitude}',
//                 style: TextStyle(fontSize: 24),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 style: TextStyle(fontSize: 24),
//               ),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';


class LiveLocation extends StatefulWidget {
  const LiveLocation({super.key});

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customizedAppBar(),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class BusStationCard extends StatelessWidget {
  final Function? onMapFunction;

  const BusStationCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
         
         InkWell(
          onTap: () {
              onMapFunction!('Bus stations near me');
            },
           child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius35),
             boxShadow: [
               BoxShadow(
                 color: Color.fromARGB(255, 14, 114, 22),
                 blurRadius: 5.0,
                 offset: Offset(0, 5),
               ),
               BoxShadow(
                 color: Color.fromARGB(255, 14, 114, 22),
                 blurRadius: 5.0,
                 offset: Offset(0, -5),
               ),
               BoxShadow(
                 color: Color.fromARGB(255, 14, 114, 22),
                 blurRadius: 5.0,
                 offset: Offset(5, 0),
               ),
               BoxShadow(
                 color: Color.fromARGB(255, 14, 114, 22),
                 blurRadius: 5.0,
                 offset: Offset(-5, 0),
               ),
             ],
                 ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo/bus-stop.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
         ),
       
          SizedBox(height: 5,),
          Text(
            'Bus Stations',
              style: TextStyle(
                  color:  Color.fromARGB(255, 14, 114, 22),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
        ],
      );
  }
}

import 'package:flutter/material.dart';
import 'package:public_safety_app/utils/dimension.dart';

class PoliceStationCard extends StatelessWidget {
  final Function? onMapFunction;
  const PoliceStationCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!('Police stations near me');
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                height: 150,
                width: 150,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo/police-badge.png',
                   fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
         Text(
            'Police Station',
              style: TextStyle(
                  color:  Color.fromARGB(255, 14, 114, 22),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
        ],
      );
  }
}

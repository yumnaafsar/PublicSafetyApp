import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_safety_app/widgets/custom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../live_safe/BusStationCard.dart';
import '../../live_safe/HospitalCard.dart';
import '../../live_safe/PharmacyCard.dart';
import '../../live_safe/PoliceStationCard.dart';
import '../../utils/dimension.dart';


class NearMe extends StatefulWidget {
  const NearMe({super.key});

  @override
  State<NearMe> createState() => _NearMeState();
}

class _NearMeState extends State<NearMe> {

  static Future<void> openMap(String location)async{
    String googleUrl='https://www.google.com/maps/search/$location';
    final Uri _url=Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
      
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'something went wrong! call emergency number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customBar(title: 'Find Near Me'),
            SizedBox(height: 100,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PoliceStationCard(onMapFunction: openMap,),
                SizedBox(width: Dimensions.width30,),
              HospitalCard(onMapFunction: openMap,),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PharmacyCard(onMapFunction: openMap,),
                   SizedBox(width: Dimensions.width30,),
              BusStationCard(onMapFunction: openMap,)
              ],
            )
          ],
        )
        ),
    );

  }
}

// Container(
//           height: 90,
//           width: MediaQuery.of(context).size.width,
//           child: ListView(
//             physics: BouncingScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             children: [
//               SizedBox(height: 80,),
//               PoliceStationCard(onMapFunction: openMap,),
//               HospitalCard(onMapFunction: openMap,),
//               PharmacyCard(onMapFunction: openMap,),
//               BusStationCard(onMapFunction: openMap,)
//             ],
//           ),
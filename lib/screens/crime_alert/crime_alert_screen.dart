import 'package:flutter/material.dart';


class CrimeAlert extends StatefulWidget {
  const CrimeAlert({Key? key}) : super(key: key);

  @override
  State<CrimeAlert> createState() => _CrimeAlertState();
}

class _CrimeAlertState extends State<CrimeAlert> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('alerts'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: 3,
                  itemBuilder: (context,index){
          return Card(
            elevation: 2,
            shape: Border.all(color: Colors.blue,width: 2),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.add_alert_outlined),
                    Text("Today 2 person killed near landhi"),
                    Icon(Icons.read_more)
                  ],
                ),
              ));
          })
          )
        ],
      )
    );
  }


}

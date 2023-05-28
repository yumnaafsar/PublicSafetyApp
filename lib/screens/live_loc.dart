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
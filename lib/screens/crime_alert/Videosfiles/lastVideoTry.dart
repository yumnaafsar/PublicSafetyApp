import 'package:flutter/material.dart';

import '../../../utils/dim.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';




class YoutubePlayerExa extends StatefulWidget {
  const YoutubePlayerExa({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerExa> createState() => _YoutubePlayerExaState();
}

class _YoutubePlayerExaState extends State<YoutubePlayerExa> {
  List<Map<String, dynamic>> videos = [
    {
      //choking
      'url': 'https://www.youtube.com/watch?v=_elh3Bl6hu0&list=WL&index=24',
      'description': 'Health Safety Videos : First Aid in case of Choking',
    },
    {
      //asthma
      'url': 'https://www.youtube.com/watch?v=ozyruyITxKg&list=WL&index=22&t=54s',
      'description': 'Health Safety Videos : Asthma Awareness',
    },
    {
      //blood pressure
      'url': 'https://www.youtube.com/watch?v=sOwBDmu1Y0c&list=WL&index=21',
      'description': 'Health Safety Videos : Blood Pressure | Heart disease risk factors',
    },
    {
      //cpr
      'url': 'https://www.youtube.com/watch?v=ozzZVQQTvo4&list=WL&index=23',
      'description': 'Health Safety Videos : Simple steps to save a life - Animated Explanation Video',
    },
    {
      //cardiac arrest
      'url': 'https://www.youtube.com/watch?v=gJDSQDwa8zo&list=WL&index=25',
      'description': 'Health Safety Videos : How to Recognize Sudden Cardiac Arrest',
    },
    // Add more videos with their descriptions
  ];

  List<YoutubePlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();

    for (var video in videos) {
      final videoID = YoutubePlayer.convertUrlToId(video['url']);
      final controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
      _controllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.health_and_safety_outlined),
        backgroundColor: Color.fromARGB(255, 17, 131, 26),
        title: const Text("Health Safety Videos"),
        centerTitle: true,
      ),
      body: Column(

        children: [
          SizedBox(
            width: Dim.width400,
            height: Dim.height100,
            child: Padding(
              padding:  EdgeInsets.all(Dim.height8),
              child: Text(
                'Note : This section presents some videos on health safety and awareness of health issues that can be resolved if treated and  identified earlier.'
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                final video = videos[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(Dim.height20),
                      child: Text(
                        video['description'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dim.width15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _controllers[index].play();
                      },
                      child: YoutubePlayer(
                        controller: _controllers[index],
                        showVideoProgressIndicator: true,
                        onReady: () => debugPrint('Ready'),
                        bottomActions: [
                          CurrentPosition(),
                          ProgressBar(
                            isExpanded: true,
                            colors: ProgressBarColors(
                              playedColor: Colors.amber,
                              handleColor: Colors.amberAccent,
                            ),
                          ),
                          PlaybackSpeedButton(),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.green,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

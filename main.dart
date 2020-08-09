import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(VideoApp());


class VideoApp extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<VideoApp> {

  bool isPlayPressed = false;


  VideoPlayerController _controller;
  AudioPlayer advancedPlayer;
  AudioCache audioCache;



  @override
  void initState() {
    super.initState();

    advancedPlayer= AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    _controller = VideoPlayerController.network("https://cdn.videvo.net/videvo_files/video/premium/video0040/small_watermarked/tower_bridge_blue01_preview.webm");
   

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();//.then((_) => setState(() {}));
  }


  @override
  void dispose() {         // to dispose controller and free up space
    _controller.dispose();
    super.dispose();
  }

  Widget position()
  {
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.end ,
      children: <Widget>[
        AspectRatio(
      aspectRatio: 16/9,
        child: VideoPlayer(_controller),
      )

    ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("  Audio  Video  Player  "),
          backgroundColor: Colors.blue,),

        body: Column(
          
          children: <Widget>[
             Container(
                margin: EdgeInsets.all(10),
                width: 400,
                height: 400,
                child: Card(
                  color: Colors.blue,
                  elevation: 5,

                child: Stack(
                    children: <Widget>[
                     Container(
                        child:Image.network('https://image.shutterstock.com/image-illustration/3d-illustration-musical-notes-signs-600w-761313844.jpg'),
                      ),
                    
                        
                      Container(
                            alignment: Alignment.bottomCenter,

                         child: IconButton (

                         icon: (isPlayPressed == true)
                                  ? Icon(
                                      Icons.pause_circle_filled,
                                      color: Colors.black,
                                      size: 40,
                                    )
                                  : Icon(
                                      Icons.play_circle_filled,
                                      color: Colors.black,
                                      size: 40,
                                    ),

                          onPressed: () {
                                setState(() {
                                  isPlayPressed =
                                      isPlayPressed == false ? true : false;
                                  if (isPlayPressed == true) {
                                    print("Playing audio");
                                    audioCache.play('sg.wav');
                                  } else {
                                    print("Paused audio");
                                    advancedPlayer.pause();
                                  }
                                });
                              },
                          ),
                       ),
                      
                    ]
                  )



                ),
              ),
               _controller.value.initialized
                    ? position()
                    : Container(),
        ]
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying)
                {
                  _controller.pause();
                } 
                else 
                {
                  // If the video is paused, play it.
                  _controller.play();
                }
               
              });
            },
            child:  Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
            
          ),
        ),
      
    );
  }
}


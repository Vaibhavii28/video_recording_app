import 'dart:async';

import 'package:blackcoffer_submission/Screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constants.dart';

void main() => runApp( VideoPlayerApp(VideoObject(title: 'title', category: '', description:' description', location:' location', userid: 'userid', videourl: 'videourl')));

class VideoPlayerApp extends StatelessWidget {
  VideoObject vidobj;
  VideoPlayerApp(this.vidobj);
  static const id='videoplayer';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: VideoPlayerScreen(vidobj),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {

  VideoObject vidobj;
  VideoPlayerScreen(this.vidobj);
  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      widget.vidobj.videourl,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return kBumbleYellow;
      }
      return Colors.white;
    }
    return Scaffold(

      appBar: AppBar(
        backgroundColor: kBumbleYellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                icon: Text(
                  'Flying',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      overflow: TextOverflow.visible),
                )),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          ],
        ),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.68,
              child: Stack(
                children: [FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: 0.75,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith(getColor)),
                      onPressed: () {
                      // Wrap the play or pause in a call to `setState`. This ensures the
                      // correct icon is shown.
                      setState(() {
                        // If the video is playing, pause it.
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          // If the video is paused, play it.
                          _controller.play();
                        }
                      });
                    }, child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black,
                    ), ),
                  )
              ]
              ),
            ),
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

      const SizedBox(height: 15),

      Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height*0.07,
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      decoration: BoxDecoration(
          boxShadow: [kBoxShadow],
          color: kLightColor,
          borderRadius: BorderRadius.circular(14.0)),
      child: Center(
        child: Text(
            widget.vidobj.title,
          style: TextStyle(fontSize: 30),
        ),
      ),
      ),
      SizedBox(height: 24,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.favorite_border, color: Colors.red, size: 50,),
          Icon(Icons.thumb_down, color: Colors.black,size: 50,),
          Icon(Icons.share, color: Colors.black, size: 50,)
        ],
      ),
      SizedBox(height: 45),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '#views',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '#days',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                widget.vidobj.category,
                style: TextStyle(fontSize: 20),
              ),
            ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Username',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Name',
                  style: TextStyle(fontSize: 20),
                ),

              ],
            ),


      const SizedBox(height: 24),
      Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height*0.07,
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        decoration: BoxDecoration(
            boxShadow: [kBoxShadow],

            color: kLightColor,
            borderRadius: BorderRadius.circular(14.0)),
        child: Center(
          child: Text(
              'Comments', style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      const SizedBox(height: 24),

      GestureDetector(
        onTap: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ExplorePage()));
        },
        child: Container(
          padding:
          EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: kBumbleYellow,
              borderRadius: BorderRadius.circular(14.0)),
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height * 0.07,
          child: Align(
              alignment: Alignment.center,
              child: Text(
                'Back to explore',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )),
        ),
      )
      ],
      )
    ]),
    ),
    )    ;

  }
}
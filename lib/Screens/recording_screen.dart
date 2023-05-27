import 'package:blackcoffer_submission/Model/media_source.dart';
import 'package:blackcoffer_submission/Screens/post_details.dart';
import 'package:blackcoffer_submission/Screens/source_page.dart';
import 'package:blackcoffer_submission/Services/location.dart';
import 'package:blackcoffer_submission/Widget/video_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key? key}) : super(key: key);
  static const id = 'recordingscreen';

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return kBumbleYellow;
    }
    return kBumbleYellow;
  }
  File? fileMedia;
  late MediaSource source;
  Location location=Location();
  // void initState() {
  //   // TODO: implement initState
  //   location.getLocationCity();
  // }
  void getLocationData() async {
    //var weatherData = await Location().getLocationCity();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PostDetails(
        fileMedia!, );
    }));
  }

  @override
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   title: Text(MyApp.title),
        // ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: fileMedia == null
                      ? Icon(Icons.photo, size: 120)
                      : VideoWidget(fileMedia!),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 12),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith(getColor)),
                    child: Text('Start recording'),
                    onPressed: () async{
                      capture(MediaSource.video);

                    }),
              ],
            ),
          ),
        ),
      );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      fileMedia = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
}

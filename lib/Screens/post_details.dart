import 'package:blackcoffer_submission/Screens/source_page.dart';
import 'package:blackcoffer_submission/Screens/success_screen.dart';
import 'package:blackcoffer_submission/Services/firebase.dart';
import 'package:blackcoffer_submission/Services/location.dart';
import 'package:blackcoffer_submission/Widget/utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../Widget/video_widget.dart';
import '../constants.dart';
import 'package:blackcoffer_submission/Model/media_source.dart';

class PostDetails extends StatefulWidget {
  final File file;

  PostDetails(this.file) {}
  static const id = 'post_details_screen';

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  File? fileMedia;
  String title = "";
  String description = "";
  String category = "";
  String cityName = '';
  Location location = Location();

  @override
  void cityy() async {
    var city = await location.getLocationCity();
    setState(() {
      cityName = city;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    cityy();
  }

  @override
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: widget.file == null
                      ? Icon(Icons.photo, size: 120)
                      : VideoWidget(widget.file),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: kLightColor,
                      borderRadius: BorderRadius.circular(14.0)),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Title', border: InputBorder.none),
                    maxLines: 1,
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: kLightColor,
                      borderRadius: BorderRadius.circular(14.0)),
                  child: Text(cityName),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: kLightColor,
                      borderRadius: BorderRadius.circular(14.0)),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Write a caption', border: InputBorder.none),
                    maxLines: 8,
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: kLightColor,
                      borderRadius: BorderRadius.circular(14.0)),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Category', border: InputBorder.none),
                    maxLines: 1,
                    onChanged: (value) {
                      category = value;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    try {
                       await AuthService().uploadVideoToFirebase(
                          context,
                          widget.file,
                          title,
                          description,
                          category,
                          cityName);

                      Navigator.push(context, MaterialPageRoute(builder: (context){return SuccessScreen();}));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: kBumbleYellow,
                        borderRadius: BorderRadius.circular(14.0)),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Post',
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future capture(MediaSource source) async {
    setState(() {
      source = MediaSource.video;
      // this.fileMedia = null;
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

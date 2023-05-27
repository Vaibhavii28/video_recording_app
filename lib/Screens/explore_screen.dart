import 'package:blackcoffer_submission/Screens/viewing_screen.dart';
import 'package:blackcoffer_submission/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'recording_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);
  static const id = 'explorescreen';

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedindex = 0;
  final screens = [
    Page1(),
    RecordingPage(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: kBumbleYellow,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _selectedindex = index;
            print(_selectedindex);
          });
        },
        items: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          Icon(
            Icons.library_books,
            color: Colors.white,
          ),
        ],
      ),
      body: screens[_selectedindex],
      // Navigator(
      //   onGenerateRoute: (page) {
      //     Widget page= Page1();
      //     if (_selectedindex==0) page= Page1();
      //     else if(_selectedindex==1) page=Page2();
      //     return MaterialPageRoute(builder: (_) => page);
      //   }  ,
      // )
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                          boxShadow: [kBoxShadow],
                          color: kLightColor,
                          borderRadius: BorderRadius.circular(14.0)),
                      child: TextField(
                        cursorColor: kDarkcolor,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: kDarkcolor,
                              size: 34.0,
                            ),
                            hintText: "Search for a video",
                            hintStyle:
                                TextStyle(color: kDarkcolor, fontSize: 20.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    decoration: BoxDecoration(
                        boxShadow: [kBoxShadow],
                        color: kLightColor,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Icon(
                      Icons.filter_alt_rounded,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              VideoStream()
            ],
          ),
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  VideoObject vidobj;

  VideoCard({required this.vidobj});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerApp(vidobj)));
      },
      child: Container(
        height: 130.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 40.0),
        decoration: BoxDecoration(
          color: kLightColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [kBoxShadow]
        ),
        child: Row(

          children: [
            Container(
              height: 180.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),


                ),

                color: kBackgroundColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                child: Image.asset(
                  'assets/images/login_image.png',
                  height: 180.0,
                  width: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [Text(vidobj.title, style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,), Text(vidobj.location, style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,)],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Username", style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,),

                        Text(vidobj.category, style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,)
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Views", style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,),
                        Text("days", style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VideoStream extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final videos = snapshot.data!.docs;
          List<VideoCard> videobubbles = [];

          for (var video in videos) {
            VideoObject videoobject = VideoObject(
                title: video.get("title"),
                category: video.get("category"),
                description: video.get("description"),
                location: video.get("location"),
                userid: video.get("userid"), videourl: video.get("Video"));
            videobubbles.add(VideoCard(vidobj: videoobject));
          }

          return Container(
            height: MediaQuery.of(context).size.height / 1.3,
            child: ListView.builder(
                shrinkWrap: true,
                reverse: false,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                itemCount: videobubbles.length,
                itemBuilder: (BuildContext context, int index) {
                  return videobubbles[index];
                }),
          );
        });
  }
}

class VideoObject {
  String title;
  String category;
  String description;
  String location;
  String userid;
  String videourl;

  VideoObject({
    required this.title,
    required this.category,
    required this.description,
    required this.location,
    required this.userid,
    required this.videourl
  });
}

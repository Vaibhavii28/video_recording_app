
import 'package:blackcoffer_submission/Screens/explore_screen.dart';
import 'package:blackcoffer_submission/Screens/login_screen.dart';
import 'package:blackcoffer_submission/Screens/otp_screen.dart';
import 'package:blackcoffer_submission/Screens/post_details.dart';
import 'package:blackcoffer_submission/Screens/success_screen.dart';
import 'package:blackcoffer_submission/Screens/viewing_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute:FirebaseAuth.instance.currentUser==null? LoginPage.id: ExplorePage.id,
    routes: {
      LoginPage.id: (context) => LoginPage(),
      OtpPage.id : (context) => OtpPage(""),
      ExplorePage.id: (context)=> ExplorePage(),
      SuccessScreen.id: (context)=> SuccessScreen(),
      //ViewingScreen.id: (context)=> ViewingScreen(VideoObject(title: '', category: '', description: '', location: '', userid: '', videourl: '', )),
      VideoPlayerApp.id:(context) => VideoPlayerApp(VideoObject(title: 'title', category: 'category', description: 'description', location: 'location', userid: 'userid', videourl: 'videourl')),
    },
  ));
}

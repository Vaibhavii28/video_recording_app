import 'package:blackcoffer_submission/Screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';
class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  static const id='success_screen';
  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBumbleYellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){}, icon: Text('Flying', style: TextStyle(fontSize: 20, color: Colors.white, overflow: TextOverflow.visible), )),

            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),

          ],
        ),


      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(

            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.1,
            child: Center(
              child: Text(
                'Posted Succesfully!',
                    style: TextStyle(color: Color(0xff8b5cdd), fontSize: 30.0),
              ),
            ),
          ),
          Center(
            child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_xwmj0hsk.json'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ExplorePage.id);
            },
            child: Container(
              padding:
              EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
              decoration: BoxDecoration(
                  color: Color(0xff8b5cdd),
                  borderRadius: BorderRadius.circular(14.0)),

              height: MediaQuery.of(context).size.height*0.1,
              width: MediaQuery.of(context).size.width*0.7,
              child: Center(
                child: Text(
                  'Return to explore page', style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

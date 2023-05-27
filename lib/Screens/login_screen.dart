import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blackcoffer_submission/Screens/otp_screen.dart';
import 'package:blackcoffer_submission/constants.dart';
import 'package:blackcoffer_submission/toast.dart';


class LoginPage extends StatelessWidget {

  LoginPage({Key? key}) : super(key: key);
  static const id = 'loginpage';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(
        elevation: 0, backgroundColor: kBumbleYellow, leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: MediaQuery.of(context).size.height / 3,

            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/login_image.png'))),
            ),

            Text("Enter your number", style: GoogleFonts.sourceSansPro(
                textStyle: TextStyle(
                    fontSize: 35, fontWeight: FontWeight.bold)),)
            ,

            SizedBox(height: 20,),
            Row(children: [
              Flexible(child: TextField(
                controller: TextEditingController()
                  ..text = "+91",
                cursorColor: kBumbleYellow,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                decoration: kTextFieldInputDecoration,

                onChanged: (value) {

                },
              ), flex: 1,),
              SizedBox(width: 5,),
              Flexible(child:
              TextField(
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                cursorColor: kBumbleYellow,

                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                decoration: kTextFieldInputDecoration,
                onChanged: (value) {
                  phoneNumber = "+91"+ value;
                },
              ), flex: 5,)
            ],),

            SizedBox(height: 100.0,),
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //mainAxisSize: MainAxisSize.max,
              children: [

                GestureDetector(
                  onTap: () {
                    if(phoneNumber.length==13)
                      Navigator.push(context, MaterialPageRoute(builder: (context){return OtpPage( phoneNumber);}));
                    else{
                      FlutterToastService().showToast("Please check your number");
                      print("invalid phone number");
                    }
                  },
                  child: Container(padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded, color: Colors.black,
                        size: 40,)

                  ),
                )
              ],
            )
          ],),
      ),
    );
  }
}
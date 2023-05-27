import 'dart:async';

import 'package:blackcoffer_submission/Screens/explore_screen.dart';
import 'package:blackcoffer_submission/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:blackcoffer_submission/Screens/login_screen.dart';
import 'package:blackcoffer_submission/Services/firebase.dart';


class OtpPage extends StatefulWidget {
  static const String id = 'otp_screen';
  static String verify = "";

  OtpPage(this.phoneNumber);

  String? phoneNumber;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int start=30;
  String enteredOtp = "";
  bool codeSent = false;
  bool wait=false;
  late String verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult, context);
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {};
    final PhoneCodeSent smsSent = (String verId, int? forceResend) {
      setState(() {
        print("hello");

        this.codeSent = true;
      });

      this.verificationId = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    await auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  @override


  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if(start==0) {
      setState(() {
        timer.cancel();
        wait= true;
      });
      }
      else
        {
          setState(() {
            start--;
          });
        }
    });
  }
  void initState() {
    verifyPhone(widget.phoneNumber);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: TextStyle(
    //       fontSize: 20,
    //       color: Color.fromRGBO(30, 60, 87, 1),
    //       fontWeight: FontWeight.w600),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    // );
    //
    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
    //   borderRadius: BorderRadius.circular(8),
    // );
    //
    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
            height: 58.0,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0)),
            ),
            child: Text(
              "Back",
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "Verify Code",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                MediaQuery.of(context).size.height / 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 70.0, top: 100.0, bottom: 100.0, right: 70.0),
                    child: Image.asset(
                      'assets/images/login_image.png',
                      width: MediaQuery.of(context).size.width / 1.7,
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 0.5),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          // Pinput(
                          //   length: 6,
                          //   showCursor: true,
                          //   onChanged: (value) {
                          //     enteredOtp = value;
                          //   },
                          // ),
                          OTPTextField(
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          outlineBorderRadius: 15,
                          style: TextStyle(fontSize: 17),
                          otpFieldStyle: OtpFieldStyle(
                            backgroundColor: Colors.white,
                            borderColor: Color(0xff6C63FF),
                          ),
                          onChanged: (pin) {
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            enteredOtp= pin;
                          },
                      ),


                        ],
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  wait?
                   GestureDetector(
                    onTap: () {
                      verifyPhone(widget.phoneNumber);
                    },
                    child: Container(
                       child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Resend OTP", style: TextStyle(fontSize: 16, color: kBumbleYellow, fontWeight: FontWeight.bold,decoration: TextDecoration.underline )),


                            ]
                        ),

                        )
                    ),
                  ):
                  Container(
                      child: RichText(text: TextSpan(
                          children: [
                            TextSpan(text: "Resend OTP in ", style: TextStyle(fontSize: 16, color: Colors.grey)),
                            TextSpan(text: "00:$start ", style: TextStyle(fontSize: 16, color: Colors.red)),
                            TextSpan(text: "sec ", style: TextStyle(fontSize: 16, color: Colors.red)),


                          ]
                      ),

                      )
                  ),

                  SizedBox(
                    height: 30,
                  ),

                     GestureDetector(
                      onTap: () async {
                        if (enteredOtp.length == 6) {
                          if (codeSent) {
                            try {
                              await AuthService().signInWithOTP(
                                  enteredOtp, verificationId, context);
                              Navigator.pushNamed(context, ExplorePage.id);
                            }
                            catch(e) {
                              print(e);
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: Center(
                          child: Text(
                            "Verify phone number",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                  SizedBox(
                    height: 70,
                  ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginPage.id, (route) => false);
                        },
                        child: Text(
                          "Edit phone number",
                          style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                          ),
                        )),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:blackcoffer_submission/Screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';
class AuthService{

  var auth = FirebaseAuth.instance;
  var firestore= FirebaseFirestore.instance;


  signIn(AuthCredential authCredential,context)async{
    try{
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      Navigator.pushNamed(context, OtpPage.id);
      // Navigator.pushNamed(context, Interstitial.id);
    }
    catch(e){
      //   Fluttertoast.showToast(
      //       msg: "$e",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
    }

  }
  signInWithOTP(smsCode, verId,BuildContext context) {
    try{
      AuthCredential authCreds = PhoneAuthProvider.credential(
          verificationId: verId, smsCode: smsCode);
      signIn(authCreds,context);}
    catch(e){
      print(e);
    }
  }
  // private void resendVerificationCode(String phoneNumber,
  //     PhoneAuthProvider.ForceResendingToken token) {
  //   PhoneAuthProvider.getInstance().verifyPhoneNumber(
  //       phoneNumber,        // Phone number to verify
  //       60,                 // Timeout duration
  //       TimeUnit.SECONDS,   // Unit of timeout
  //       this,               // Activity (for callback binding)
  //       mCallbacks,         // OnVerificationStateChangedCallbacks
  //       token);             // ForceResendingToken from callbacks
  // }

  Future uploadVideoToFirebase (BuildContext context,File imageFile, String title, String description, String category, String location) async {
    String fileName = imageFile.path;
    var auth = FirebaseAuth.instance;
    String userid= auth.currentUser!.uid;
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    //String postId= const Uuid().v1();
    // if(isPost) {
    //   String id= Uuid().v1();
    //   firebaseStorageRef= firebaseStorageRef.child(id);
    // }
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) async{

          await firestore.collection('posts').doc().set({'Video': value, 'title': title, 'description': description, 'category': category , 'location' : location, 'userid': userid});

      });
    });

  }
  // uploadDetails( ) async{
  //   try {
  //     await firestore
  //         .collection('posts')
  //         .doc().set({});
  //   }
  //   catch (e) {
  //     print(e);
  //   }
  // }
  uploadLocation(String location) async{
    try{
      await firestore
          .collection('posts')
          .doc(auth.currentUser?.uid)
          .set({'location': location});
    }
    catch(e)
    {
      print(e);
    }
  }
  // uploadDescription(String description) async{
  //   try{
  //     await firestore
  //         .collection('posts')
  //         .doc(auth.currentUser?.uid)
  //         .set({'description': description});
  //   }
  //   catch(e){
  //     print(e);
  //   }
  // }
  // uploadCategory(String category)async {
  //   try {
  //     await firestore
  //         .collection('posts')
  //         .doc(auth.currentUser?.uid)
  //         .set({'category': category});
  //   }
  //   catch (e) {
  //     print(e);
  //   }
  // }


}
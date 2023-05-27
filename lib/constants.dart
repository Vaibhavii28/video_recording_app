import 'package:flutter/material.dart';
const kBumbleYellow = Color(0xff8b5cdd);
const kWhite=Colors.white;
const kBackgroundColor= Color(0xFFF4F59);
const kOrangeColor= Color(0xFFF15C1A);
const kBluecolor= Color(0xFF7C84EC);
const kLightColor= Colors.white;
const kDarkcolor= Colors.black;
const kBoxShadow= BoxShadow(
    color: Color.fromRGBO(143, 148, 251, 0.5),
    blurRadius: 20.0,
    offset: Offset(0, 10));
InputDecoration kTextFieldInputDecoration=const InputDecoration(
  filled: true,
  fillColor: Color(0xffFFFFFF),

  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
  border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10))),
  hintText: 'Phone number',
  hintStyle: TextStyle(color: Colors.grey,fontSize: 18),

);
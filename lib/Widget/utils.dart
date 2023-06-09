import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
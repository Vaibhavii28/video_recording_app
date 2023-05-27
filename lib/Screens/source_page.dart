import 'package:blackcoffer_submission/constants.dart';
import 'package:flutter/material.dart';

import '../Widget/camera_button.dart';
import '../Widget/gallery_button.dart';

class SourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBumbleYellow,
        title: Text('Select Source'),
      ),
      body: ListView(
        children: [
          CameraButtonWidget(),
          GalleryButtonWidget(),
        ],
      ),
    );
  }
}
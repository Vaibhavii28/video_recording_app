import 'dart:io';

import 'package:blackcoffer_submission/Screens/post_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/media_source.dart';
import 'list_tile.dart';

class CameraButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListTileWidget(
    text: 'From Camera',
    icon: Icons.camera_alt,
    onClicked: () => pickCameraMedia(context),
  );

  Future pickCameraMedia(BuildContext context) async {
    final Object? source = ModalRoute.of(context)?.settings.arguments;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.camera);
    final file = File(media!.path);
    print(media!.path);

    Navigator.push(context, MaterialPageRoute(builder: (context) =>PostDetails(file)));
  }
}
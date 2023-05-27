import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/media_source.dart';
import '../Screens/post_details.dart';
import 'list_tile.dart';

class GalleryButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListTileWidget(
    text: 'From Gallery',
    icon: Icons.photo,
    onClicked: () => pickGalleryMedia(context),
  );

  Future pickGalleryMedia(BuildContext context) async {
    final Object? source = ModalRoute.of(context)?.settings.arguments;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.gallery);
    final file = File(media!.path);

    Navigator.push(context, MaterialPageRoute(builder: (context) =>PostDetails(file)));

  }
}
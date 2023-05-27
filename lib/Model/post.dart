import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String postUrl;

  const Post(
      {required this.description,
        required this.uid,
        required this.postId,
        required this.postUrl,
      });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot["description"],
        uid: snapshot["uid"],
        postId: snapshot["postId"],
        postUrl: snapshot['postUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    "description": description,
    "uid": uid,
    "postId": postId,
    'postUrl': postUrl,
  };
}
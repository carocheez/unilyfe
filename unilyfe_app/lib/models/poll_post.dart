import 'package:flutter/material.dart';

class PollPost {
  int postType;
  String title;
  DateTime time;
  String text;
  String postChannel;
  String uid;
  int likes;
  bool liked;
  PollPost(this.title, this.time, this.text,  this.postChannel, this.uid,this.likes, this.liked);

  Map<String, dynamic> toJson() => {
        'postType': 0,
        'title': title,
        'time': time,
        'text': text,
        'postChannel': postChannel,
        'uid': uid,
        'likes': likes,
        'liked': liked
      };
}
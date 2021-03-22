import 'package:flutter/material.dart';

class PollPost {
  String postid;
  int postType;
  String title;
  DateTime time;
  String text;
  String postChannel;
  String uid;
  int likes;
  bool liked;
  Map<String, dynamic> map_liked;
  PollPost(this.postid,this.title, this.time, this.text,  this.postChannel, this.uid,this.likes, this.liked, this.map_liked);

  Map<String, dynamic> toJson() => {
        'postType': 0,
        'title': title,
        'time': time,
        'text': text,
        'postChannel': postChannel,
        'uid': uid,
        'likes': likes,
        'liked': liked,
        'postid': postid,
        'map_liked':map_liked
      };
}

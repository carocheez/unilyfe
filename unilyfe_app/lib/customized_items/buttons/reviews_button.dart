import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:unilyfe_app/page/create_posts/locations_list.dart';

class ReviewsButton extends StatelessWidget {
  const ReviewsButton({
    this.newPost,
  });
  final Post newPost;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: ElevatedButton(
          onPressed: () {
             Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationList(post: newPost, )),
                );
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            //onPrimary: Colors.white,
            onPrimary: Color(0xFFF46C6B),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
          ),
          child: Text(
            'Create a Review',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}

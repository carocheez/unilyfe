import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

int selection = 0;

class NewPostBudgetView extends StatelessWidget {
  NewPostBudgetView({Key key, @required this.post}) : super(key: key);
  final db = FirebaseFirestore.instance;

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'REVIEW POST DETAILS',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('\nTitle: ${post.title}'),
            SizedBox(height: 5),
            Text('\nText: ${post.text}'),
            SizedBox(height: 30),
            MyAppOne(),
            ElevatedButton(
              onPressed: () async {
                // save data to firebase
                //print("FINAL SELECTION ${selection}");
                if (selection == 0) {
                  post.postChannel = 'FOOD';
                } else if (selection == 1) {
                  post.postChannel = 'STUDY';
                } else {
                  //print(selection);
                  post.postChannel = 'SOCIAL';
                }
                final uid = await Provider.of(context).auth.getCurrentUID();
                post.uid = uid;
                var doc = db.collection('posts').doc();
                post.postid = doc.id;
                // DocumentReference doc2 =
                //     await db.collection("posts").add(post.toJson());
                //print("DOCUMENT: " + doc.id);
                //print("DOC2: " + doc2.id);
                await db.collection('posts').doc(doc.id).set(post.toJson());

                //DocumentReference channel;
                if (selection == 0) {
                  //await db.collection("food_posts").add(post.toJson());
                  await db
                      .collection('food_posts')
                      .doc(doc.id)
                      .set(post.toJson());
                } else if (selection == 1) {
                  //await db.collection("study_posts").add(post.toJson());
                  await db
                      .collection('study_posts')
                      .doc(doc.id)
                      .set(post.toJson());
                } else {
                  //await db.collection("social_posts").add(post.toJson());
                  await db
                      .collection('social_posts')
                      .doc(doc.id)
                      .set(post.toJson());
                }

                await db
                    .collection('userData')
                    .doc(uid)
                    .collection('posts')
                    .doc(doc.id)
                    .set(post.toJson());

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('SUBMIT'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppOne extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppOne> {
  List<bool> isSelected;

  @override
  void initState() {
    // this is for 3 buttons, add "false" same as the number of buttons here
    isSelected = [true, false, false];
    selection = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        // logic for button selection below
        onPressed: (int index) {
          setState(() {
            for (var i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
              if (isSelected[i] == true) {
                selection = i;
                print('INDEX: $i');
              }
            }
          });
        },
        isSelected: isSelected,
        children: <Widget>[
          // first toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'FOOD',
            ),
          ),
          // second toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'STUDY',
            ),
          ),
          // third toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SOCIAL',
            ),
          ),
        ],
      ),
    );
  }
}

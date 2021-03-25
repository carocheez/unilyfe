import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/lets_go_button.dart';
import 'package:unilyfe_app/customized_items/buttons/logout_button.dart';
import 'package:unilyfe_app/models/User.dart';
import 'package:unilyfe_app/page/create_page.dart';
import 'package:unilyfe_app/page/home_page.dart';
import 'package:unilyfe_app/page/tabs/tabs_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String year = 'freshman';

class EnterInfoPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => EnterInfoPage(),
      );

  @override
  _EnterInfoPageState createState() => _EnterInfoPageState();
}

class _EnterInfoPageState extends State<EnterInfoPage> {
  User user = User('', '', '', '', [], []);
  String _currentUsername = '';
  //String _currentYear = "";
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _covidController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Column(
          children: <Widget>[
            pad,
            Text(
              'Tell Us About Yourself',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
            pad,
            _changeInfo('username...', _usernameController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('display name...', _displayNameController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('bio...', _bioController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('profile pic...', _profilePictureController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('do you have covid-19?', _covidController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('where did you last go?', _locationController),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'I am a...  ',
                style: TextStyle(color: Colors.grey, fontSize: 24),
              ),
              _MyYearDropDownWidget(),
            ]),
            pad,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFF56D6B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () async {
                    print("user.username: " + user.username);
                    final uid = await Provider.of(context).auth.getCurrentUID();
                    if (_usernameController.text != null &&
                        _usernameController.text != '') {
                      if ((user.username != _usernameController.text) &&
                          !await usernameCheck(_usernameController.text)) {
                        print('ALREADY TAKEN');
                        showAlertDialog(context);
                      } else {
                        user.username = _usernameController.text;
                        /*setState(() {
                              _usernameController.text = user.username;
                            });*/
                        await Provider.of(context)
                            .db
                            .collection('userData')
                            .doc(uid)
                            .update({'username': user.username});
                      }
                    }
                    if (_displayNameController.text != null &&
                        _displayNameController.text != '') {
                      user.displayName = _displayNameController.text;
                      print(_displayNameController.text);
                      /*setState(() {
                            _displayNameController.text = user.displayName;
                          });*/
                      await Provider.of(context)
                          .db
                          .collection('userData')
                          .doc(uid)
                          .update({'displayName': user.displayName});
                    }
                    if (_bioController.text != null &&
                        _bioController.text != '') {
                      user.bio = _bioController.text;
                      print(_bioController.text);
                      /*setState(() {
                            _bioController.text = user.bio;
                          });*/
                      await Provider.of(context)
                          .db
                          .collection('userData')
                          .doc(uid)
                          .update({'bio': user.bio});
                    }

                    user.year = year;
                    /*setState(() {
                            year = user.year;
                          });*/
                    await Provider.of(context)
                        .db
                        .collection('userData')
                        .doc(uid)
                        .update({'year': year});

                    /*if (_profilePictureController.text != null &&
                              _profilePictureController.text != "") {
                            user.picturePath = _profilePictureController.text;
                            print(_profilePictureController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }*/
                    /*if (_covidController.text != null) {
                            user.covid = _covidController.text;
                            print(_covidController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }*/
                    /*if (_locationController.text != null) {
                            user.location = _locationController.text;
                            print(_locationController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }*/
                    //_getProfileData();
                    //print("user.year: " + user.year);

                    // Navigator.of(context).pop();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TabsPage()),
                    );
                    //return HomePage();
                  },
                  child: Text('Submit'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }

  Widget pad = Container(
    padding: const EdgeInsets.all(32),
  );

  Widget _changeInfo(
      String textBoxText, TextEditingController editingController) {
    return TextField(
      controller: editingController,
      autofocus: false,
      style: TextStyle(fontSize: 22.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFfae9d7),
        hintText: textBoxText,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
  }

  final db = FirebaseFirestore.instance;

  // ignore: always_declare_return_types
  showAlertDialog(BuildContext context) async {
    // set up the button
    var email = await Provider.of(context).auth.getEmail();
    var suggested = await generateUsername(email);
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('OK'),
    );

    // set up the AlertDialog
    var alert = AlertDialog(
      title: Text('PLEASE CHOOSE ANOTHER USERNAME'),
      content: Text('Suggested usernames: $suggested'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final firestore = FirebaseFirestore.instance; //
  fire_auth.FirebaseAuth auth = fire_auth.FirebaseAuth
      .instance; //recommend declaring a reference outside the methods

  Future<bool> usernameCheck(String username) async {
    final result = await firestore
        .collection('userData')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

  Future<String> generateUsername(String email) async {
    var username = email.substring(0, email.indexOf('@'));
    var num = 1;
    if (!await usernameCheck(username)) {
      print(username + ' exists');
      while (!await usernameCheck(username + num.toString())) {
        num += 1;
      }
    }
    print(username);
    return username +
        num.toString() +
        ' ' +
        username +
        (num + 1).toString() +
        ' ' +
        username +
        (num + 2).toString();
  }
}

class _MyYearDropDownWidget extends StatefulWidget {
  const _MyYearDropDownWidget({Key key}) : super(key: key);

  @override
  _MyYearDropDown createState() => _MyYearDropDown();
}

class _MyYearDropDown extends State<_MyYearDropDownWidget> {
  User user = User('', '', '', '', [], []);
  //String _currentYear = "";

  final db = FirebaseFirestore.instance;
  String dropdownValue = 'freshman';

  // ignore: always_declare_return_types

  @override
  Widget build(BuildContext context) {
    /*return FutureBuilder(
      future: Provider.of(context).auth.getCurrentUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _displayDropDown(context, snapshot);
        } else {
          return CircularProgressIndicator();
        }
      },
    );*/
    return _displayDropDown(context);
  }

  Widget _displayDropDown(context) {
    return DropdownButton<String>(
      value: dropdownValue,
      //icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.grey, fontSize: 24),
      underline: Container(
        height: 3,
        color: const Color(0xFFF99E3E),
      ),
      onChanged: (String newValue) async {
        user.year = newValue;
        setState(() {
          year = newValue;
          print('global variable year: ' + year);
          dropdownValue = newValue;
          //_currentYear = newValue;
          //print("_currentYear: " + _currentYear);
        });
        /*final uid = await Provider.of(context).auth.getCurrentUID();
                  await Provider.of(context)
                      .db
                      .collection('userData')
                      .doc(uid)
                      .update({"year": dropdownValue});*/
      },
      items: <String>['freshman', 'sophomore', 'junior', 'senior']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

/*hello*/

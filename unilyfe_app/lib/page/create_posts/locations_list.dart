import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class LocationList extends StatefulWidget {
  LocationList({Key key}) : super(key: key);
  @override
  LocationsListState createState() => LocationsListState();
}

class LocationsListState extends State<LocationList> {
  LocationsListState({Key key});
  String chosenValue;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    var _titleController = TextEditingController();

    var _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'CREATE A REVIEW POST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        //child: Container(
          children: [
            SizedBox(height: 30),
            Center(
            child: DropdownButton<String>(
            value: chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            items: <String>[
              'Earhart Dining Court',
              'Wiley Dining Court',
              'Windsor Dining Court',
              'Hillenbrand Dining Court',
              'Harrison Grill',
              'Triple XXX Family Restaurant',
              'Einstein Bagels',
              'Earhart Residence Hall',
              'Wiley Residence Hall',
              'Windsor Residence Hall',
              'Hillenbrand Residence Hall',
              'Chauncey Square Apartments',
              'Aspire at Discovery Park',
              'Hub State Street',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          
            onChanged: (String value) {
              setState(() {
                chosenValue = value;
              });
            },
          ),
        ),
        SizedBox(height: 30),
          Text('Enter a Post Title'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
          
        SizedBox(height: 40),
          Text('\nGive your location a rating'),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
            child: SmoothStarRating(
        )),
            ),
          
        SizedBox(height: 10),
        Text('\nEnter Review'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _textController,
                autofocus: true,
              ),
            ),
            
          ],
      ),
      
    );
    
  }
}

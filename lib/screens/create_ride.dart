import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Models/ride_model.dart';
import 'package:lift/Models/user_model.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/dashboard.dart';

class CreateRidePage extends StatefulWidget {
  @override
  _CreateRideState createState() => _CreateRideState();
}

class _CreateRideState extends State<CreateRidePage> {

  var mySingleton = Singleton();
  String destinationResort = "";
  String meetupSpot = "";
  String meetupTime = "";
  int availableSeats = 0;
  String returningTime = "";

  _submitRide() {
    String key = "1234";
    RideModel aRide = new RideModel(mySingleton.myUser, destinationResort, meetupSpot, meetupTime, availableSeats, returningTime, key);
    addRider(aRide);
    mySingleton.myUser.myDrives.add(aRide);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 37, 57, 100),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 76, 118, 100),
        title: Text("Find A Ride"),
        actions: <Widget>[
          AccountWidget(),
        ],
      ),
      drawer: HamburgerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                onChanged: (value) {
                  destinationResort = value;
                  print(destinationResort);
                },
                decoration: InputDecoration(
                  hintText: "Enter Resort...",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                onChanged: (value) {
                  meetupSpot = value;
                  print(meetupSpot);
                },
                decoration: InputDecoration(
                  hintText: "Enter meetup spot...",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                onChanged: (value) {
                  meetupTime = value;
                  print(meetupTime);
                },
                decoration: InputDecoration(
                  hintText: "Enter meetup time...",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                onChanged: (value) {
                  availableSeats = int.parse(value);
                  print(availableSeats);
                },
                decoration: InputDecoration(
                  hintText: "How many seats do you have?",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                onChanged: (value) {
                  returningTime = value;
                  print(returningTime);
                },
                decoration: InputDecoration(
                  hintText: "When are you leaving the resort",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(0, 140, 216, 100),
              heroTag: 'Back',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
              child: Icon(
                Icons.arrow_left,
                size: 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(0, 140, 216, 100),
              heroTag: 'Submit Ride',
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Submit this Ride?'),
                  content: const Text('Select ok to add this ride to your list of drives. ' +
                          'This will allow other user to find and request your drive.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _submitRide();
                      },                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: Icon(
                Icons.check_outlined,
                size: 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Add more floating buttons if you want
          // There is no limit
        ],
      ),
    );
  }

  addRider(RideModel ride) {
    UserModel user1 = new UserModel();
    user1.name = "Matt";
    UserModel user2 = new UserModel();
    user2.name = "Joey";

    ride.addRider(user1, "pending");
    ride.addRider(user2, "pending");
  }

}
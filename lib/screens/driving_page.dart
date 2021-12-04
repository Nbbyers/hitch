import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/ride_model.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/dashboard.dart';
import 'package:lift/screens/view_route_page.dart';

class DrivingPage extends StatelessWidget {
  DrivingPage(RideModel myRide) {this.myRide = myRide;}

  RideModel myRide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Drive"),
        actions: <Widget>[
          AccountWidget(),
        ],
      ),
      drawer: HamburgerMenu(),
      body: Column (
        children: [
          Text(myRide.meetupSpot + " to " + myRide.destinationResort),
          Text("Meet up time: " + myRide.meetupTime),
          Text("Leaving resort at: " + myRide.returningTime),
          Text("Available seats: " + myRide.availableSeats.toString()),
          Text("Current Riders"),
          Text("Replace with list of riders"),
          Text("Requests"),
          Text("Replace with list of requested riders"),
          Row(
            children: [
              FloatingActionButton(
                child: Text("Back"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
              ),
              FloatingActionButton(
                child: Text("View Ride Route"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewRoutePage()),
                  );
                },
              ),
            ],
          )
        ],

      ),
    );
  }

}
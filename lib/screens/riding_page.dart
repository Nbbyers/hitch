import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Models/ride_model.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/dashboard.dart';

import 'browse_rides.dart';

class RidingPage extends StatelessWidget {
  RidingPage(RideModel myRide) {this.myRide = myRide;}

  var mySingleton = Singleton();


  RideModel myRide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myRide.driver.name + "'s Ride"),
        actions: <Widget>[
          AccountWidget(),
        ],
      ),
      drawer: HamburgerMenu(),
      body: Column (
        children: [
          Text(myRide.meetupSpot + " to " + myRide.destinationResort),
          Text("Meet up time: " + myRide.meetupTime),
          Text("Available seats: " + myRide.availableSeats.toString()),
          Text("Leaving resort around: " + myRide.returningTime),
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
                child: Text("Request Rides"),
                onPressed: () {
                  mySingleton.myUser.myRides.add(myRide);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
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
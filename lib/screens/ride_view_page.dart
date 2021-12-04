import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Models/ride_model.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/dashboard.dart';

import 'browse_rides.dart';

class RideViewPage extends StatelessWidget {
  RideViewPage(RideModel myRide) {this.myRide = myRide;}

  var mySingleton = Singleton();


  RideModel myRide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 37, 57, 100),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 76, 118, 100),
        title: Text(myRide.driver.name + "'s Ride"),
        actions: <Widget>[
          AccountWidget(),
        ],
      ),
      drawer: HamburgerMenu(),
      body: Padding (
        padding: EdgeInsets.fromLTRB(0,4,0,0),
        child: Column (
          children: [
            Text(
              myRide.meetupSpot + " to " + myRide.destinationResort + "           ",
              style: TextStyle (
                backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                fontSize: 35,
                color: Colors.white
              )
            ),
            Text(
              "Meet up time: " + myRide.meetupTime + "                       ",
              style: TextStyle (
                backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                fontSize: 25,
                color: Colors.white
              )
            ),
            Text(
              "Available seats: " + myRide.availableSeats.toString() + "                                 ",
              style: TextStyle (
                backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                fontSize: 25,
                color: Colors.white
              )
            ),
            Text(
              "Leaving resort around: " + myRide.returningTime + "                 ",
              style: TextStyle (
                backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                fontSize: 25,
                color: Colors.white
              )
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
                  MaterialPageRoute(builder: (context) => BrowseRidesPage()),
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
              heroTag: 'Join Ride',
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Request this Ride?'),
                  content: const Text('Select ok to send a ride request.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        myRide.addRider(mySingleton.myUser, "requested");
                        mySingleton.myUser.myRides.add(myRide);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
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

}
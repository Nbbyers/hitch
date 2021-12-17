import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Models/ride_model.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/dashboard.dart';
import 'package:lift/screens/riding_map_page.dart';

import 'browse_rides.dart';

class RidingPage extends StatelessWidget {
  RidingPage(RideModel myRide) {this.myRide = myRide;}

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
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                  myRide.meetupSpot + " to " + myRide.destinationResort + "           ",
                  style: TextStyle (
                      backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                      fontSize: 35,
                      color: Colors.white
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                  "Meet up time: " + myRide.meetupTime + "                       ",
                  style: TextStyle (
                      backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                      fontSize: 25,
                      color: Colors.white
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                  "Available seats: " + myRide.availableSeats.toString() + "                                 ",
                  style: TextStyle (
                      backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                      fontSize: 25,
                      color: Colors.white
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                  "Leaving resort around: " + myRide.returningTime + "                 ",
                  style: TextStyle (
                      backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                      fontSize: 25,
                      color: Colors.white
                  )
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
            left: 170,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(0, 140, 216, 100),
              heroTag: 'Delete',
              onPressed: () {
                mySingleton.myUser.myRides.remove(myRide);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
              child: Icon(
                Icons.delete,
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
              heroTag: 'Map',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RidingMapPage(myRide)),
                );
              },
              child: Icon(
                Icons.map_outlined,
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
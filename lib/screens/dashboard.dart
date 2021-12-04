import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Models/user_model.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/account_page.dart';
import 'package:lift/screens/browse_rides.dart';
import 'package:lift/screens/create_ride.dart';
import 'package:lift/screens/riding_page.dart';

import 'driving_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
  }

class _DashboardState extends State<Dashboard> {
  var mySingleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 37, 57, 100),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 76, 118, 100),
        title: Text("Dashboard"),
        actions: <Widget>[
          AccountWidget(),
        ],
      ),
      drawer: HamburgerMenu(),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "              My Drives                 ",
            style: TextStyle (
              backgroundColor: Color.fromRGBO(0, 140, 216, 100),
              fontSize: 30,
              color: Colors.white
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                showDrivingList(),
              ],
            ),
          ),
          Text(
            "              My Rides                 ",
            style: TextStyle (
                backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                fontSize: 30,
                color: Colors.white
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                showRideList(),
              ],
            ),
          ),
        ],
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
              heroTag: 'Create Ride',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateRidePage()),
                );
              },
              child: Icon(
                Icons.directions_car_outlined,
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
              onPressed: () {
                mySingleton.buildRides();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowseRidesPage()),
                );
              },
              child: Icon(
                Icons.hail,
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





  Widget showDrivingList()
  {
    if (mySingleton.myUser == null) {
      mySingleton.myUser = new UserModel();
    }
    List driveList = mySingleton.myUser.myDrives;

    if (driveList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: driveList.length,
          itemBuilder: (BuildContext context, int index) {
            String key = driveList[index].key;
            String destination = driveList[index].destinationResort;
            String meetupTime = driveList[index].meetupTime;
            String meetupSpot = driveList[index].meetupSpot;
            int availableSeats = driveList[index].availableSeats;
            String returningTime = driveList[index].returningTime;
            return Padding(
              padding: EdgeInsets.fromLTRB(0,4,0,0),
              child: ListTile(
                tileColor: Color.fromRGBO(0, 76, 118, 100),
                title: Text(
                  destination,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                  ),
                ),
                subtitle: Text(
                  "Meeting at " + meetupSpot + " at " + meetupTime +
                      " with " + availableSeats.toString() + " available seats",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DrivingPage(driveList[index])),
                  );
                },
              ),
            );
          });
    } else {
      return Center(
        child: Text(
          "    You don't have any drives    ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22.0,
              backgroundColor: Color.fromRGBO(0, 76, 118, 100),
              color: Colors.white,
          ),
        )
    );
    }
  }

  Widget showRideList()
  {
    if (mySingleton.myUser == null) {
      mySingleton.myUser = new UserModel();
    }
    List rideList = mySingleton.myUser.myRides;

    if (rideList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rideList.length,
          itemBuilder: (BuildContext context, int index) {
            String key = rideList[index].key;
            String name = rideList[index].driver.name;
            String destination = rideList[index].destinationResort;
            String meetupTime = rideList[index].meetupTime;
            String meetupSpot = rideList[index].meetupSpot;
            int availableSeats = rideList[index].availableSeats;
            String returningTime = rideList[index].returningTime;
            return Padding(
              padding: EdgeInsets.fromLTRB(0,4,0,0),
              child: ListTile(
                tileColor: Color.fromRGBO(0, 76, 118, 100),
                title: Text(
                  name,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  meetupSpot + " to " + destination + " at " + meetupTime +
                      " with " + availableSeats.toString() + " available seats",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RidingPage(rideList[index])),
                  );
                },
              ),
            );
          });
    } else {
      return Center(
        child: Text(
          "      You don't have any rides      ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            backgroundColor: Color.fromRGBO(0, 76, 118, 100),
            color: Colors.white,
          ),
        )
      );
    }
  }
  
}


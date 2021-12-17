import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/dashboard.dart';
import 'package:lift/screens/ride_view_page.dart';

class BrowseRidesPage extends StatefulWidget {
  @override
  _BrowseRidesState createState() => _BrowseRidesState();
}

class _BrowseRidesState extends State<BrowseRidesPage> {
  var mySingleton = Singleton();


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
      body: Column (
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              "          Choose a Ride                 ",
              style: TextStyle (
                  backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                  fontSize: 30,
                  color: Colors.white
              ),
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
              heroTag: 'Join Ride',
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('No Filter Yet'),
                  content: const Text('The filter rides function will be brought in a future update'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: Icon(
                Icons.filter_alt,
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


  Widget showRideList()
  {
    List rideList = mySingleton.allRides;

    if (rideList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
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
                    color: Colors.white,
                    fontSize: 14
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RideViewPage(rideList[index])),
                  );
                },
              ),
            );
          });
    } else {
      return Center(
          child: Text(
            "You don't have any drives",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0),
          ));
    }
  }

}
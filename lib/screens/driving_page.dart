import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Models/ride_model.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/dashboard.dart';
import 'package:lift/screens/riding_map_page.dart';
import 'package:lift/screens/view_route_page.dart';

class DrivingPage extends StatelessWidget {
  var mySingleton = Singleton();
  DrivingPage(RideModel myRide) {this.myRide = myRide;}

  RideModel myRide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 37, 57, 100),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 76, 118, 100),
        title: Text("My Drive"),
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
            Text(
                "Riders",
                style: TextStyle (
                    backgroundColor: Color.fromRGBO(0, 140, 216, 100),
                    fontSize: 40,
                    color: Colors.white
                )
            ),
            showRiderList(),
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


  Widget showRiderList()
  {
    List riderList = myRide.riders;

    if (riderList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: riderList.length,
          itemBuilder: (BuildContext context, int index) {
            String name = riderList[index].rider.name;
            String status = riderList[index].status;
            return Padding(
              padding: EdgeInsets.fromLTRB(0,4,0,0),
              child: ListTile(
                tileColor: Color.fromRGBO(0, 76, 118, 100),
                title: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),
                ),
                subtitle: Text(
                  status,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14
                  ),
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('CHANGE RIDER STATUS'),
                    content: const Text("Accept or reject the rider's request to join your ride."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => {
                          riderList[index].status = "rejected",
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DrivingPage(myRide)),
                          ),
                        },
                        child: const Text('REJECT'),
                      ),
                      TextButton(
                        onPressed: () => {
                          riderList[index].status = "accepted",
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DrivingPage(myRide)),
                          ),
                        },
                        child: const Text('ACCEPT'),
                      ),
                    ],
                  ),
                ),
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

}
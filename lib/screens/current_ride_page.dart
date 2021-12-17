import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Models/ride_model.dart';
import 'package:lift/Widgets/account_widget.dart';
import 'package:lift/Widgets/hamburger_menu.dart';
import 'package:lift/screens/dashboard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'browse_rides.dart';

class CurrentRidePage extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  CurrentRidePage(RideModel myRide) {this.myRide = myRide;}

  var mySingleton = Singleton();


  RideModel myRide;


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
        child: Padding (
          padding: EdgeInsets.fromLTRB(16, 16, 16, 130),
          child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
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
              heroTag: 'SOS',
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Send SOS'),
                  content: const Text('This feature will be added in a future update.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Ok'),
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              ),
              child: Icon(
                Icons.warning,
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
              heroTag: 'Stop Ride',
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('End Ride?'),
                  content: const Text('Select end to end the ride.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        mySingleton.riding = false;
                        mySingleton.myUser.myRides.remove(myRide);
                        mySingleton.myUser.myDrives.remove(myRide);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                      child: const Text('END'),
                    ),
                  ],
                ),
              ),
              child: Icon(
                Icons.stop,
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
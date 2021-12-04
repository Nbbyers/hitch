import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/screens/account_page.dart';
import 'package:lift/screens/browse_rides.dart';
import 'package:lift/screens/create_ride.dart';
import 'package:lift/screens/dashboard.dart';

class HamburgerMenu extends StatelessWidget{
  HamburgerMenu();

  HamburgerMenu.setUser(userNameIn, userEmailIn)
  {
    userName = userNameIn;
    userEmail = userEmailIn;
  }

  //var mySingleton = Singleton();
  static String userName = "", userEmail = "";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("name"),
              accountEmail: Text("email"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
                child: Text(
                  "N",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);  //close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            ListTile(
              title: Text("Create Ride"),
              onTap: () {
                Navigator.pop(context);  //close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateRidePage()),
                );
              },
            ),
            ListTile(
              title: Text("Browse Rides"),
              onTap: () {
                Navigator.pop(context);  //close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowseRidesPage()),
                );
              },
            ),
            ListTile(
              title: Text("Account"),
              onTap: () {
                Navigator.pop(context);  //close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () async {
                while(Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                await FirebaseAuth.instance.signOut();
              },
            ),
          ]
      ),
    );
  }
}
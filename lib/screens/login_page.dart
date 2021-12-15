import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/Models/Singleton.dart';
import 'package:lift/Models/user_model.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var mySingleton = Singleton();
  String _email;
  String _password;
  final String mtnUrl = 'lift/images/mtn_blue-01.svg';

  Future <void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch(e) {
      print("Error: $e");
    } catch(e) {
      print("Error: $e");
    }
  }

  Future <void> _login() async {
    try {
      mySingleton.myUser =  new UserModel();
      mySingleton.myUser.username = _email;
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch(e) {
      print("Error: $e");
    } catch(e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 37, 57, 100),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: [
            /*
            SvgPicture.network(
              mtnUrl,
              placeholderBuilder: (context) => CircularProgressIndicator(),
              height: 128.0,
            ),

             */
            Text(
              "Hitch",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              )
            ),
            Text(
                "-a-",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                )
            ),
            Text(
                "RIDE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                )
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  onChanged: (value) {
                    _email = value;
                    print(_email);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter email...",
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    _password = value;
                    print(_password);
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter password..."
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  onPressed: () {
                    _login();
                  },
                  child: Text("Sign In"),
                  color: Colors.white,

                ),
                MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  onPressed: () {
                    _createUser();
                  },
                  child: Text("Create New Account"),
                  color: Colors.white,

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
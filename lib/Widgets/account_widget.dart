import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift/screens/account_page.dart';

class AccountWidget extends StatelessWidget{

  AccountWidget();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.account_circle),
        iconSize: 45,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountPage()),
          );
        }
    );
  }
}
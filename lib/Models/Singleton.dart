import 'dart:developer';

import 'package:lift/Models/ride_model.dart';
import 'package:lift/Models/user_model.dart';

class Singleton {
  factory Singleton() {return _singleton;}
  Singleton.internal();
  static final Singleton _singleton = Singleton.internal();

  UserModel myUser;
  List allRides = <RideModel> [];

  void setUser(UserModel aUser) {this.myUser = aUser;}
  UserModel getUser() {return myUser;}

  void buildRides() {
    allRides.clear();
    UserModel tom = new UserModel();
    tom.name = "Tom";
    RideModel one = new RideModel(tom, "Brighton", "Target", "8:00 am", 2, "4:00 pm", "111");

    UserModel Joey = new UserModel();
    Joey.name = "Joey";
    RideModel two = new RideModel(Joey, "Solitude", "McDonalds", "6:30 am", 4, "12:00 pm", "222");

    allRides.add(one);
    allRides.add(two);
  }
}
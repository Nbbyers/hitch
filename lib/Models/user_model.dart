import 'package:lift/Models/ride_model.dart';

class UserModel implements Comparable<UserModel> {
  @override
  int compareTo(UserModel other) {
    // TODO: implement compareTo
    throw UnimplementedError();
  }

  String userID = "";
  String name = "";
  String username = "";
  String vehicle = "";
  List myRides = <RideModel> [];
  List myDrives = <RideModel> [];

}
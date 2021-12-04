import 'package:lift/Models/user_model.dart';

class RideModel implements Comparable<RideModel> {
  @override
  int compareTo(RideModel other) {
    // TODO: implement compareTo
    throw UnimplementedError();
  }

  UserModel driver;
  String destinationResort = "";
  String meetupSpot = "";
  String meetupTime = "";
  int availableSeats = 0;
  String returningTime = "";
  String key = "";
  List riders = <RiderTuple> [];

  RideModel(this.driver, this.destinationResort, this.meetupSpot, this.meetupTime, this.availableSeats, this.returningTime, this.key);

  String getDestinationResort() {return destinationResort;}
  String getMeetupSpot() {return meetupSpot;}
  String getMeetupTime() {return meetupTime;}
  int getAvailableSeats() {return availableSeats;}
  String getReturnTime() {return returningTime;}

  void addRider(UserModel rider, String status) {
    RiderTuple newSet = new RiderTuple(rider, status);
    riders.add(newSet);
  }

}


class RiderTuple {
  UserModel rider;
  String status;

  RiderTuple(UserModel aRider, String status) {
    this.rider = aRider;
    this.status = status;
  }

  void changeStatus(String status) {
    this.status = status;
  }

}
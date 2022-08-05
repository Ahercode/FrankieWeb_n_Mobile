import 'package:flutter/material.dart';


class Location {
  int? id;
  String? name;
  String? address;
  String? telephoneNumber;
  String? mobilePhoneNumber1;
  String? mobilePhoneNumber2;
  // bool? isRestaurant;

  Location({
   @required this.id,
   @required this.name,
   @required this.address,
   @required this.telephoneNumber,
   @required this.mobilePhoneNumber1,
   @required this.mobilePhoneNumber2,
  //  @required this.isRestaurant,
  });

  Location.fromMapObject(map) {
    this.id = map['id'];
    this.name = map['name'].toString().trim();
    this.address = map['address'];
    this.telephoneNumber = map['telephoneNumber'];
    this.mobilePhoneNumber1 = map['mobilePhoneNumber1'];
    this.mobilePhoneNumber2 = map['mobilePhoneNumber2'];
    // this.isRestaurant = map['isRestaurant'];
  }
}

class Locationlist {
  List<Location>? locationList;

  Locationlist({@required this.locationList});
}

Locationlist methodList = Locationlist(locationList: []);
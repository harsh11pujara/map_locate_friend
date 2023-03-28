import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserModel {
  double? lat;
  double? lng;
  String? id;
  String? name;
  String? subTitle;
  double? markerOpacity;
  String? address;

  UserModel({this.id, this.name, this.lat, this.lng, this.subTitle, this.markerOpacity = 1,this.address = "No data"});
}

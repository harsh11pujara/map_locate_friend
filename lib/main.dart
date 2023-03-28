import 'package:flutter/material.dart';
import 'package:google_map_friends/user_details_screen.dart';
import 'package:google_map_friends/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

CameraPosition initialPos =
    const CameraPosition(target: LatLng(37.43296265331129, -122.08832357078792), zoom: 20, tilt: 35, bearing: 150.5);

class _MyAppState extends State<MyApp> {
  List<UserModel> userMarker = [
    UserModel(
        name: "Mike",
        lng: -122.08832357078792,
        lat: 37.43296265331129,
        id: "initialMarker",
        markerOpacity: 0.8,
        subTitle: "California Lake",
      address: "123, abc road, xyz city, pqr state"
    ),
    UserModel(
        name: "John",
        lng: -115.08832357078792,
        lat: 37.43296265331129,
        id:"user3",
        markerOpacity: 0.5,
        subTitle: "Near Lake",
        address: "785, south road, john city, pqr state"
    ),
    UserModel(name: "Sam", id: "user2", lat: 35.666, lng: -110.08832357078792),
    UserModel(name: "Gus", id: "user4", lat: 40.666, lng: -115.08832357078792,subTitle: "In city")
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        GoogleMap(
          indoorViewEnabled: true,
          initialCameraPosition: initialPos,
          mapType: MapType.hybrid,
          buildingsEnabled: true,
          compassEnabled: false,
          zoomControlsEnabled: false,
          markers: userMarker.map((e) {
            return Marker(
                markerId: MarkerId(e.id!),
                position: LatLng(e.lat!, e.lng!),
                infoWindow: InfoWindow(title: e.name!, snippet: e.subTitle,onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetails(userData: e),));
                },),
                alpha: e.markerOpacity!,
            );
          }).toSet(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_map_friends/services.dart';
import 'package:google_map_friends/user_details_screen.dart';
import 'package:google_map_friends/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/src/places.dart';

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

class _MyAppState extends State<MyApp> {
  GoogleMapController? mapController;
  String apiKey = "AIzaSyDdfZW0c9OBwdTilbJJYDddYeOcO6snkcw";
  CameraPosition? initialPos;
  Position? userPosition;
  bool didMove = false;

  List<UserModel> userMarker = [
    UserModel(
        name: "Mike",
        lng: -122.08832357078792,
        lat: 37.43296265331129,
        id: "initialMarker",
        markerOpacity: 0.8,
        subTitle: "California Lake",
        address: "123, abc road, xyz city, pqr state"),
    UserModel(
        name: "John",
        lng: -115.08832357078792,
        lat: 37.43296265331129,
        id: "user3",
        markerOpacity: 0.5,
        subTitle: "Near Lake",
        address: "785, south road, john city, pqr state"),
    UserModel(name: "Sam", id: "user2", lat: 35.666, lng: -110.08832357078792),
    UserModel(name: "Gus", id: "user4", lat: 40.666, lng: -115.08832357078792, subTitle: "In city")
  ];

  @override
  void initState() {
    getUserLocation().then((value) {
      userPosition = value;
      initialPos =
          CameraPosition(target: LatLng(userPosition!.latitude, userPosition!.longitude), zoom: 18, tilt: 20, bearing: 35.5);
      // userMarker.add(UserModel(id: "userHarsh",lat: userPosition!.latitude,lng: userPosition!.longitude,name: "Harsh",subTitle: "Office"));

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: initialPos == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (controller) {
                        mapController = controller;
                        setState(() {});
                      },
                      indoorViewEnabled: true,
                      initialCameraPosition: initialPos!,
                      mapType: MapType.hybrid,
                      buildingsEnabled: true,
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: userMarker.map((e) {
                        return Marker(
                          markerId: MarkerId(e.id!),
                          position: LatLng(e.lat!, e.lng!),
                          infoWindow: InfoWindow(
                            title: e.name!,
                            snippet: e.subTitle,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDetails(userData: e),
                              ));
                            },
                          ),
                          alpha: e.markerOpacity!,
                        );
                      }).toSet(),
                    ),
                    mapController != null
                        ? Positioned(
                            bottom: 50,
                            right: 20,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.gps_fixed_sharp),
                                    onPressed: () {
                                      mapController!.animateCamera(CameraUpdate.newCameraPosition(initialPos!));
                                      setState(() {
                                        didMove = false;
                                      });
                                    }),
                              ),
                            ))
                        : Container(),
                    // Container(
                    //   margin: EdgeInsets.only(top: 20, left: 20),
                    //   height: 50,
                    //   decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    //   child: IconButton(
                    //     padding: EdgeInsets.zero,
                    //     icon: const Icon(
                    //       Icons.search_sharp,
                    //       color: Colors.black,
                    //     ),
                    //     onPressed: () async {
                    //       var place = await PlacesAutocomplete.show(
                    //         context: context,
                    //         apiKey: apiKey,
                    //         mode: Mode.overlay,
                    //       );
                    //
                    //       if (place != null) {
                    //
                    //       }
                    //     },
                    //   ),
                    // )
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: 60,
                      color: Colors.white,
                      child: TextField(decoration: InputDecoration(label: Text("Search Loaction"),suffixIcon: Icon(Icons.search_sharp)),onChanged: (value) {
                        MapServices().getAutocorrectData(value);
                      },),
                    )
                  ],
                )),
    );
  }

  Future<Position> getUserLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}

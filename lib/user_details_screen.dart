import 'package:flutter/material.dart';
import 'package:google_map_friends/user_model.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key, required this.userData}) : super(key: key);
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar( automaticallyImplyLeading: true,backgroundColor: Colors.blueGrey,elevation: 0),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(backgroundColor: Colors.blueGrey,radius: 35, child: Icon(Icons.person,color: Colors.white,)),
                  const SizedBox(height: 15,),
                  const Text("Name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                  Text(userData.name!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  const SizedBox(height: 15,),
                  const Text("Address",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),softWrap: true),
                  Text(userData.address!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  const SizedBox(height: 15,),
                  const Text("Location",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                  Text("Latitude : ${userData.lat}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  Text("Longitude : ${userData.lng}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

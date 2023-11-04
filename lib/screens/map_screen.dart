import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isNormal = true;
  late GoogleMapController myController;
  List<Marker> myMarkers = [];
  List<Polyline> myPolylines = [];
  int id = 0;
  List<String> names = ["abdo", "mohamed", "ahmed", "omar", "abdallah"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onTap: (position) async{
                // Position myPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                // PolylinePoints polylinePoints = PolylinePoints();
                // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
                //   'AIzaSyAaa_h3ZzyER8ARK_mwIPdmWZD1BrErDb4',
                //     PointLatLng(myPosition.latitude, myPosition.longitude), PointLatLng(position.latitude, position.longitude));
                // print(result.points);

                print('${position.latitude} , ${position.longitude}');
                Marker newMarker = Marker(
                  onTap: (){
                    // setState(() {
                    //   myMarkers.removeWhere((element) => element.markerId.value == "destination");
                    // });
                  },
                  markerId: MarkerId('to'),
                  position: LatLng(position.latitude, position.longitude),
                  infoWindow: InfoWindow(
                    title: "Your destination",
                    snippet: "your trip destination"
                  ),
                );
                setState(() {
                  myMarkers.add(newMarker);
                });
                Position myPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                Polyline newPolyline = Polyline(
                  polylineId: PolylineId('1'),
                  color: Colors.blue,
                  width: 3,
                  points: [
                    LatLng(myPosition.latitude, myPosition.longitude),
                    LatLng(position.latitude, position.longitude), // newMarker.position,
                    LatLng(37.42357263744577, -122.08204250792728),
                    LatLng(37.42357263944677, -122.08204250992828),
                    LatLng(37.42357283744777, -122.08204280792928),
                  ]
                );
                setState(() {
                  myPolylines.add(newPolyline);
                });
              },
              markers: myMarkers.toSet(),
              polylines: myPolylines.toSet(),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: isNormal ? MapType.normal : MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.43296265331129, -122.08832357078792),
                zoom: 20,
              ),
              onMapCreated: (GoogleMapController googleController){
                myController = googleController;
              },
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Row(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(50),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            isNormal = !isNormal;
                          });
                        }, 
                        icon: Icon(Icons.swap_horiz, size: 25,),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 300,
                      child: TextField(
                        onChanged: (value){
                         List filteredList = names.where((element) => element.contains(value)).toList();
                         print(filteredList);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          print("latitude = ${position.latitude}");
          print("longitude = ${position.longitude}");
          myController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 20,
            ),
          ));
        },
        child: Icon(Icons.location_pin),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
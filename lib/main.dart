import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  

  static const LatLng _center = const LatLng(20.2961, 85.8245);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
   void initState() {
   super.initState();
  _getLocation();
       
     }
   
     
       final Set<Marker> _markers = {};
  
       @override
       Widget build(BuildContext context) {
         return MaterialApp(
           home: Scaffold(
             appBar: AppBar(
               title: Text('Maps Sample App'),
               backgroundColor: Colors.green[700],
             ),
             body:Stack(
               children: <Widget>[
                 GoogleMap(
                   onMapCreated: _onMapCreated,
                   initialCameraPosition: CameraPosition(
                     target: _center,
                     zoom: 11.0,
                   ),
                   markers: _markers
     
               ),
                  Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Align(
                     alignment: Alignment.topRight,
                     child: Column(
                       children: <Widget> [
                      
                         SizedBox(height: 16.0),
                         FloatingActionButton(
                           onPressed: _onAddMarkerButtonPressed,
                                                 materialTapTargetSize: MaterialTapTargetSize.padded,
                                                 backgroundColor: Colors.green,
                                                 child: const Icon(Icons.add_location, size: 36.0),
                                               ),
                                             ],
                                           ),
                                   ),
                                 )])));
                               
                             }
        Future<void> _onAddMarkerButtonPressed() async {
          print("1");
        
  
        }
  
    Future<void> _getLocation() async {
      
            var currentLocation = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
         setState(() {
           print(currentLocation);
         
                 _markers.add(Marker(
             // This marker id can be anything that uniquely identifies each marker.
             markerId: MarkerId(currentLocation.toString()),
             position:LatLng(currentLocation.latitude, currentLocation.longitude),
             infoWindow: InfoWindow(
               title: 'Really cool place',
               snippet: '5 Star Rating',
             ),
             icon: BitmapDescriptor.defaultMarker,
           ));
         });
    }
}
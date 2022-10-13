import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';
class Archized extends StatefulWidget {
  @override
  State<Archized> createState() => _ArchizedState();
}
class _ArchizedState extends State<Archized> {
  @override
  Set<Marker> mylist = {};
  var n1=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(" share my location ");
              String x=n1.text.toString();
              Share.share(x);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 600,
            child: GoogleMap(
              onMapCreated: (controller) {},
              initialCameraPosition: CameraPosition(
                  target: LatLng(30.1, 30.2),
                  zoom: 10.0
              ),
              markers: mylist,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blueGrey,
            child: MaterialButton(onPressed: () async {
              Location myloc = new Location();
              LocationData x = await myloc.getLocation();
              dynamic a = x.latitude;
              dynamic b = x.longitude;
              setState(() {
                mylist.add(
                    Marker(
                      markerId: MarkerId("mena yaser"),
                      position: LatLng(a, b),
                      infoWindow: InfoWindow(snippet: "mobile developer", title: "mena yaser"),
                    )
                );
              });
            },child: Text('find my location',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),),),
          ),
        ],
      ),
    );
  }
}
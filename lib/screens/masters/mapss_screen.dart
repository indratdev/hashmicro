import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapssScreen extends StatelessWidget {
  MapssScreen({Key? key}) : super(key: key);

  LatLng latlon = LatLng(45.5231, -122.6765);

  final markers = <Marker>[
    Marker(
      width: 80,
      height: 80,
      point: LatLng(45.5231, -122.6765),
      builder: (ctx) => Icon(
        Icons.pin_drop,
        size: 60,
        color: Colors.red,
      ),
    ),
    // Marker(
    //   width: 80,
    //   height: 80,
    //   point: LatLng(53.3498, -6.2603),
    //   builder: (ctx) => const FlutterLogo(
    //     textColor: Colors.green,
    //   ),
    //   // anchorPos: anchorPos,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 50,
              width: 100,
              color: Colors.red,
              child: Column(
                children: [
                  Text("Masukan Nama lokasi : "),
                  TextField(
                    // controller: locationNameController,
                    decoration: InputDecoration(hintText: "Nama Lokasi"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(45.5231, -122.6765),
                zoom: 13,
              ),
              layers: [
                TileLayerOptions(
                  minZoom: 1,
                  maxZoom: 18,
                  backgroundColor: Colors.black,
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(markers: markers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

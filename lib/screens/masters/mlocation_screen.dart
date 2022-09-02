import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hashmicro/Data/locationApp.dart';
import 'package:hashmicro/statemanagement/bloc/attendance_bloc.dart';

class MLocationScreen extends StatelessWidget {
  MLocationScreen({Key? key}) : super(key: key);
  String location = 'Null, Press Button';
  String address = 'search';

  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Future<Position> _getGeoLocationPosition() async {
    //   bool serviceEnabled;
    //   LocationPermission permission;
    //   // Test if location services are enabled.
    //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //   if (!serviceEnabled) {
    //     // Location services are not enabled don't continue
    //     // accessing the position and request users of the
    //     // App to enable the location services.
    //     await Geolocator.openLocationSettings();
    //     return Future.error('Location services are disabled.');
    //   }
    //   permission = await Geolocator.checkPermission();
    //   if (permission == LocationPermission.denied) {
    //     permission = await Geolocator.requestPermission();
    //     if (permission == LocationPermission.denied) {
    //       // Permissions are denied, next time you could try
    //       // requesting permissions again (this is also where
    //       // Android's shouldShowRequestPermissionRationale
    //       // returned true. According to Android guidelines
    //       // your App should show an explanatory UI now.
    //       return Future.error('Location permissions are denied');
    //     }
    //   }
    //   if (permission == LocationPermission.deniedForever) {
    //     // Permissions are denied forever, handle appropriately.
    //     return Future.error(
    //         'Location permissions are permanently denied, we cannot request permissions.');
    //   }
    //   // When we reach here, permissions are granted and we can
    //   // continue accessing the position of the device.
    //   return await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high);
    // }

    // Future<void> GetAddressFromLatLong(Position position) async {
    //   List<Placemark> placemarks =
    //       await placemarkFromCoordinates(position.latitude, position.longitude);
    //   print(placemarks);
    //   Placemark place = placemarks[0];
    //   address =
    //       '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    // }

    // GetAddresFromQuery(String address) async {
    //   // final query =
    //   //     "Jl. Prof. DR. Satrio No.Kav.3, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12940";
    //   List<Location> locations = await locationFromAddress(address);
    //   print(locations);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("new"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Text("Masukan Nama lokasi : "),
                TextField(
                  controller: locationNameController,
                  decoration: InputDecoration(hintText: "Nama Lokasi"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Column(
              children: [
                Text("Masukan Alamat lokasi : "),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(hintText: "Alamat"),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (locationNameController.text.isEmpty ||
                  addressController.text.isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Peringatan"),
                        content: const Text("Nama Lokasi / Alamat kosong"),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Tutup"),
                          ),
                        ],
                      );
                    });
              } else {
                // GetAddresFromQuery(
                //     "Jl. Prof. DR. Satrio No.Kav.3, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12940");
                BlocProvider.of<AttendanceBloc>(context).add(
                  GetLocationAddressByQuery(
                      locationName: locationNameController.text,
                      // address: addressController.text,
                      address:
                          "Jl. Prof. DR. Satrio No.Kav.3, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12940"),
                );
                // GetAddresFromQuery("asal");
                // LocationApp().GetAddresFromQuery(
                //     "Jl. Prof. DR. Satrio No.Kav.3, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12940");
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}

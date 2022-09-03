import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hashmicro/screens/customwidgets.dart';

import 'package:latlong2/latlong.dart';

import '../../statemanagement/bloc/attendance_bloc.dart';

class MapssScreen extends StatelessWidget {
  MapssScreen({Key? key}) : super(key: key);
  TextEditingController addressController = TextEditingController();

  LatLng latlonDefault = LatLng(-6.173920, 106.766970);
  List<Location> result = [];

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: latlonDefault,
        builder: (ctx) => const Icon(
          Icons.pin_drop,
          size: 50,
          color: Colors.red,
        ),
      ),
    ];

    return SafeArea(
      child: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          //
        },
        builder: (context, state) {
          if (state is LoadingGetAddressByQuery) {
            return Container(
                color: Colors.white,
                child:
                    const Center(child: CircularProgressIndicator.adaptive()));
          }
          if (state is AttendanceInitial) {
            return InitialWidgetLocation(
                latlonDefault: latlonDefault,
                markers: markers,
                addressController: addressController);
          }

          if (state is SuccessGetAddressByQuery) {
            result = state.resultAddress;
            var latlon = LatLng(result[0].latitude, result[0].longitude);
            return SuccesslWidgetLocation(
                resultLocation: result,
                latlonDefault: latlon,
                markers: [
                  Marker(
                    width: 80,
                    height: 80,
                    point: latlon,
                    builder: (ctx) => const Icon(
                      Icons.pin_drop,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                ],
                addressController: addressController);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class InitialWidgetLocation extends StatelessWidget {
  const InitialWidgetLocation({
    Key? key,
    required this.latlonDefault,
    required this.markers,
    required this.addressController,
  }) : super(key: key);

  final LatLng latlonDefault;
  final List<Marker> markers;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FlutterMap(
                options: MapOptions(
                  center: latlonDefault, //LatLng(45.5231, -122.6765),
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
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.9),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: "Masukan Nama Lokasi",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (addressController.text.isEmpty) {
                        CustomWidgets.showWarningDialog(
                            context, "Nama Lokasi Kosong!");
                      } else {
                        BlocProvider.of<AttendanceBloc>(context).add(
                            GetLocationAddressByQuery(
                                address: addressController.text));
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
class SuccesslWidgetLocation extends StatelessWidget {
  SuccesslWidgetLocation({
    Key? key,
    required this.latlonDefault,
    required this.markers,
    required this.addressController,
    required this.resultLocation,
  }) : super(key: key);

  final LatLng latlonDefault;
  final List<Marker> markers;
  final List<Location> resultLocation;
  final TextEditingController addressController;
  TextEditingController nameForSavingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FlutterMap(
                options: MapOptions(
                  center: latlonDefault, //LatLng(45.5231, -122.6765),
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
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.9),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: "Masukan Nama Lokasi",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (addressController.text.isEmpty) {
                        CustomWidgets.showWarningDialog(
                            context, "Nama Lokasi Kosong!");
                      } else {
                        BlocProvider.of<AttendanceBloc>(context).add(
                            GetLocationAddressByQuery(
                                address: addressController.text));
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  )
                ],
              ),
            ),
          ),

          // tombol simpan
          Positioned(
            bottom: 10,
            left: 50,
            right: 50,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Nama Tempat :"),
                              content: TextField(
                                controller: nameForSavingController,
                                decoration: const InputDecoration(
                                  hintText: "Masukan Nama Lokasi",
                                ),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Batal"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (nameForSavingController
                                            .text.isNotEmpty) {
                                          List<String> result = [
                                            nameForSavingController.text,
                                            resultLocation[0]
                                                .latitude
                                                .toString(),
                                            resultLocation[0]
                                                .longitude
                                                .toString()
                                          ];
                                          BlocProvider.of<AttendanceBloc>(
                                                  context)
                                              .add(SavingLocationMaster(
                                                  savingList: result));
                                          Navigator.of(context)
                                            ..pop()
                                            ..pop();
                                          BlocProvider.of<AttendanceBloc>(
                                                  context)
                                              .add(GetAllMasterLocation());
                                        }
                                      },
                                      child: const Text("Simpan"),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    child: const Text("Simpan Lokasi"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashmicro/screens/customwidgets.dart';
import 'package:hashmicro/statemanagement/bloc/attendance_bloc.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> listLocation = [];
    String selectedLocation = "";

    locationManagement(List<dynamic> value) {
      for (var element in value) {
        listLocation.add(element[0]);
      }
      selectedLocation = listLocation[0];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Absen"),
      ),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is LoadingAbsen) {
            showDialog(
                barrierDismissible: false,
                context: context,
                barrierColor: Colors.white.withOpacity(0.5),
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                });
          }
          if (state is FailureAbsen) {
            Navigator.pop(context);
            CustomWidgets.showSuccesFailedDialog(
                context, state.messageError.toString(), false);
          }
          if (state is SuccessAbsen) {
            Navigator.pop(context);
            CustomWidgets.showSuccesFailedDialog(
                context, state.message.toString(), true);
          }

          if (state is ChangeLocationState) {
            selectedLocation = state.locationName;
          }
        },
        builder: (context, state) {
          if (state is SuccessAllMaster) {
            var value = state.result;
            locationManagement(value);
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                    value: selectedLocation,
                    elevation: 8,
                    items: listLocation.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (value) {
                      context
                          .read<AttendanceBloc>()
                          .add(ChangeLocation(value: value.toString()));
                    }),
                ElevatedButton(
                  onPressed: () async {
                    context
                        .read<AttendanceBloc>()
                        .add(AbsensiProcess(locationMaster: selectedLocation));
                  },
                  child: const Text("Absen"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

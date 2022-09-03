import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashmicro/Data/csharedPreferences.dart';
import 'package:hashmicro/screens/masters/mapss_screen.dart';
import 'package:hashmicro/statemanagement/bloc/attendance_bloc.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Master"),
        actions: [
          IconButton(
              onPressed: () {
                CSharedPreferences().deleteAll();
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MapssScreen()));
          BlocProvider.of<AttendanceBloc>(context).add(InitialLocation());
        },
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is SuccessSavingLocation) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Data Berhasil disimpan"),
              ),
            );
          }
          if (state is FailureSavingLocation) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.messageError.toString()),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SuccessAllMaster) {
            var result = state.result;
            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(result[index][0]),
                );
                // return Text(result[index][0]);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

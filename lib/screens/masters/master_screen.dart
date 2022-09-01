import 'package:flutter/material.dart';
import 'package:hashmicro/screens/masters/mlocation_screen.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Master"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MasterLocationScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 200,
        itemBuilder: (context, index) {
          return Text("data");
        },
      ),
    );
  }
}

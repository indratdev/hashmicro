import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hashmicro/screens/hashmicro.dart.dart';

import 'package:hashmicro/statemanagement/bloc/attendance_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttendanceBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HashmicroScreen(),
      ),
    );
  }
}

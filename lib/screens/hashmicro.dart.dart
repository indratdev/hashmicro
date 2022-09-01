import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashmicro/screens/attendance/attendance_screen.dart';
import 'package:hashmicro/screens/masters/master_screen.dart';
import 'package:hashmicro/screens/setting/setting_screen.dart';
import 'package:hashmicro/statemanagement/bloc/attendance_bloc.dart';

class HashmicroScreen extends StatelessWidget {
  const HashmicroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    List<Widget> _widgetOption = <Widget>[
      MasterScreen(),
      AttendanceScreen(),
      SettingScreen()
    ];

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state is MovedPage) {
          currentIndex = state.page;

          switch (state.page) {
            case 0:
              // BlocProvider.of<NewsBloc>(context)
              //     .add(FetchNewsEvent(type: 'General'));
              break;
            case 1:
              // BlocProvider.of<NewsBloc>(context)
              //     .add(FetchTrendingNewsEvent(type: 'entertainment'));
              break;
          }
        }
        return Scaffold(
          // appBar: AppBar(
          //   title: Text("Attendance App"),
          // ),
          body: _widgetOption.elementAt(currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Master',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up),
                label: 'Attendance',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                label: 'Setting',
              )
            ],
            currentIndex: currentIndex,
            onTap: (value) {
              BlocProvider.of<AttendanceBloc>(context)
                  .add(changePages(page: value));
            },
          ),
        );
      },
    );
  }
}

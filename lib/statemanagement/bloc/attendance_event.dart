part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceEvent {}

class changePages extends AttendanceEvent {
  int page;

  changePages({required this.page});
}

class GetLocationAddressByQuery extends AttendanceEvent {
  // String locationName;
  String address;

  GetLocationAddressByQuery({
    // required this.locationName,
    required this.address,
  });
}

class InitialLocation extends AttendanceEvent {}

class SavingLocationMaster extends AttendanceEvent {
  List<String> savingList;

  SavingLocationMaster({
    required this.savingList,
  });
}

class GetAllMasterLocation extends AttendanceEvent {}

class ChangeLocation extends AttendanceEvent {
  String value;

  ChangeLocation({required this.value});
}

class AbsensiProcess extends AttendanceEvent {
  String locationMaster;

  AbsensiProcess({
    required this.locationMaster,
  });
}

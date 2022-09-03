part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceState {}

abstract class FaiureAttendance extends AttendanceState {
  String messageError;

  FaiureAttendance({
    required this.messageError,
  });
}

class AttendanceInitial extends AttendanceState {}

class BottomnavInitial extends AttendanceState {}

class MovedPage extends AttendanceState {
  final int page;

  MovedPage({required this.page});

  @override
  List<Object> get props => [page];
}

class LoadingGetAddressByQuery extends AttendanceState {}

class FailureGetAddressByQuery extends FaiureAttendance {
  FailureGetAddressByQuery({required super.messageError});
}

class SuccessGetAddressByQuery extends AttendanceState {
  List<Location> resultAddress;

  SuccessGetAddressByQuery({
    required this.resultAddress,
  });

  @override
  List<Object> get props => [resultAddress];
}

class LoadingSavingLocation extends AttendanceState {}

class FailureSavingLocation extends FaiureAttendance {
  FailureSavingLocation({required super.messageError});
}

class SuccessSavingLocation extends AttendanceState {}

// get all master

class LoadingAllMaster extends AttendanceState {}

class FailureAllMaster extends FaiureAttendance {
  FailureAllMaster({required super.messageError});
}

class SuccessAllMaster extends AttendanceState {
  List<dynamic> result;

  SuccessAllMaster({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

class ChangeLocationState extends AttendanceState {
  final String locationName;

  ChangeLocationState({required this.locationName});

  @override
  List<Object> get props => [locationName];
}

// absen
class LoadingAbsen extends AttendanceState {}

class FailureAbsen extends FaiureAttendance {
  FailureAbsen({required super.messageError});
}

class SuccessAbsen extends AttendanceState {
  String message;

  SuccessAbsen({
    this.message = "Absensi Data Berhasil",
  });
  @override
  List<Object> get props => [message];
}

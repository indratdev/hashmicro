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

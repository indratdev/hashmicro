part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class BottomnavInitial extends AttendanceState {}

class MovedPage extends AttendanceState {
  final int page;

  MovedPage({required this.page});

  @override
  List<Object> get props => [page];
}

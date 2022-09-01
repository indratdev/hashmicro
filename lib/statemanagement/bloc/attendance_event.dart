part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceEvent {}

class changePages extends AttendanceEvent {
  int page;

  changePages({required this.page});

  // @override
  // List<Object> get props => [page];
}

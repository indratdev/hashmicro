import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    on<changePages>((event, emit) {
      emit(MovedPage(page: event.page));
    });
  }
}

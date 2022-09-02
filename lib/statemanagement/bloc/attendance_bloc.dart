import 'package:bloc/bloc.dart';
import 'package:hashmicro/Data/locationApp.dart';
import 'package:meta/meta.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  LocationApp loc = LocationApp();

  AttendanceBloc() : super(AttendanceInitial()) {
    on<changePages>((event, emit) {
      emit(MovedPage(page: event.page));
    });
    on<GetLocationAddressByQuery>((event, emit) async {
      try {
        emit(LoadingGetAddressByQuery());
        var locationName = await loc.GetAddresFromQuery(event.address);
        if (locationName.isNotEmpty) {
          print("Data data");
        }
      } catch (e) {
        print("E: $e");
        emit(FailureGetAddressByQuery(
            messageError: "Gagal : Lokasi Tidak Ditemukan"));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hashmicro/Data/csharedPreferences.dart';
import 'package:hashmicro/Data/customException.dart';
import 'package:hashmicro/Data/locationApp.dart';
import 'package:meta/meta.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  LocationApp loc = LocationApp();
  CSharedPreferences shared = CSharedPreferences();

  AttendanceBloc() : super(AttendanceInitial()) {
    on<InitialLocation>((event, emit) {
      emit(AttendanceInitial());
    });

    on<changePages>((event, emit) {
      emit(MovedPage(page: event.page));
    });

    on<GetLocationAddressByQuery>((event, emit) async {
      try {
        emit(LoadingGetAddressByQuery());
        var locationResult = await loc.GetAddresFromQuery(event.address);
        if (locationResult.isNotEmpty) {
          print("Data data");
          emit(SuccessGetAddressByQuery(resultAddress: locationResult));
        }
      } catch (e) {
        print("E: $e");
        emit(FailureGetAddressByQuery(
            messageError: "Gagal : Lokasi Tidak Ditemukan"));
      }
    });

    on<SavingLocationMaster>((event, emit) async {
      try {
        emit(LoadingSavingLocation());

        List<String> value = event.savingList;
        await shared.saveLocationMaster(value);
        emit(SuccessSavingLocation());
      } catch (e) {
        print(e.toString());
        emit(FailureSavingLocation(messageError: "Gagal Simpan Data"));
      }
    });

    on<GetAllMasterLocation>((event, emit) async {
      try {
        emit(LoadingAllMaster());
        List<dynamic> result = await shared.getAll();
        if (result.isNotEmpty) {
          print(result);
          emit(SuccessAllMaster(result: result));
        } else {
          emit(FailureAllMaster(messageError: "GAGAL"));
        }
      } catch (e) {
        print(e.toString());
      }
    });

    on<ChangeLocation>((event, emit) {
      emit(ChangeLocationState(locationName: event.value));
    });

    on<AbsensiProcess>((event, emit) async {
      try {
        emit(LoadingAbsen());
        Position locationNow = await loc.getGeoLocationPosition();
        var locationMaster =
            await shared.getLocationMaster(event.locationMaster);
        var distanceLocation = await loc.getDistanceFromLatLonInM(
            locationNow.latitude,
            locationNow.longitude,
            double.parse(locationMaster[1]),
            double.parse(locationMaster[2]));

        var result = loc.validateDistanceLocation(distanceLocation);
        print("result : $result");
        if (!result) {
          throw LocationNotValidException();
        } else {
          emit(SuccessAbsen());
        }
      } on LocationNotValidException catch (e) {
        emit(FailureAbsen(messageError: e.toString()));
      } catch (e) {
        print(e);
        emit(FailureAbsen(messageError: "Gagal Proses Absensi"));
      }
    });
  }
}

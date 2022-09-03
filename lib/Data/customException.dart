abstract class CustomException implements Exception {
  String messageError;

  CustomException({required this.messageError});

  @override
  String toString() => messageError;
}

class LocationNotValidException extends CustomException {
  LocationNotValidException(
      {super.messageError = "Anda Melebihi Jarak Yang Ditentukan"});
}

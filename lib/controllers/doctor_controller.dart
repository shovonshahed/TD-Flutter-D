import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../models/index.dart';
import '../services/network_service.dart';

class DoctorController extends GetxController {
  // late LoginResponse _loginResponse;
  late Doctor _doctor;
  late String _token;
  RxBool authenticated = false.obs;

  Doctor get doctor => _doctor;

  Future<bool> updateProfile(Doctor doctor) async {
    final Either<String, Doctor> response =
        await NetworkService.updateProfile(doctor, _doctor.email, _token);
    bool update = false;
    response.fold((left) {
      update = false;
    }, (right) {
      _doctor = right;
      notifyChildrens();
      update = !update;
    });
    return update;
  }

  Future login(String email, String password) async {
    final Either<String, LoginResponse> response =
        await NetworkService.login(email, password);
    response.fold((left) {
      authenticated.value = false;
    }, (right) {
      _token = right.token;
      _doctor = right.dataToReturn;
      authenticated.value = true;
    });
    return authenticated.value;
  }

  Future signup(String name, String email, String password,
      String confirmPassword) async {
    return NetworkService.signup(name, email, password, confirmPassword);
  }

  Future logout() async {
    _token = "";
    _doctor = Doctor();
    authenticated.value = false;
    return !authenticated.value;
  }
}

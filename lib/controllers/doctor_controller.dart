import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../models/index.dart';
import '../services/loading_service.dart';
import '../services/network_service.dart';

class DoctorController extends GetxController {
  // late LoginResponse _loginResponse;
  // late Doctor _doctor;
  var doctor = Doctor().obs;
  var schedules = <Schedule>[].obs;
  late String _token;
  RxBool authenticated = false.obs;

  // Doctor get doctor => _doctor;

  Future getSchedules() async {
    final Either<String, List<Schedule>> response =
        await NetworkService.getSchedules(doctor.value.email, _token);
    response.fold((left) {
      CustomDialog.showToast("Schedules loading failed");
    }, (right) {
      schedules.value = right;
      if (schedules.value.isNotEmpty) {
        print("Day of week: ${schedules.value.first.dayOfWeek}");
      }
    });
    notifyChildrens();
  }

  Future<bool> addSchedule(Schedule schedule) async {
    final Either<String, List<Schedule>> response =
        await NetworkService.addSchedule(schedule, _token);
    bool update = false;
    response.fold((left) {
      update = false;
    }, (right) {
      schedules.value = right;
      if (schedules.value.isNotEmpty) {
        print("Day of week: ${schedules.value.first.dayOfWeek}");
      }
      notifyChildrens();
      update = !update;
    });
    return update;
  }

  Future<bool> updateProfile(Doctor tempDoctor) async {
    final Either<String, Doctor> response = await NetworkService.updateProfile(
        tempDoctor, doctor.value.email, _token);
    bool update = false;
    response.fold((left) {
      update = false;
    }, (right) {
      doctor.value = right;
      notifyChildrens();
      update = !update;
    });
    return update;
  }

  Future getUser(String email) async {
    final Either<String, Patient> response =
        await NetworkService.getUser(email, _token);
    response.fold((left) {
      authenticated.value = false;
    }, (right) {
      return right;
    });
  }

  Future login(String email, String password) async {
    final Either<String, LoginResponse> response =
        await NetworkService.login(email, password);
    response.fold((left) {
      authenticated.value = false;
    }, (right) {
      _token = right.token;
      doctor.value = right.dataToReturn;
      authenticated.value = true;
      getSchedules();
    });
    return authenticated.value;
  }

  Future signup(String name, String email, String password,
      String confirmPassword) async {
    return NetworkService.signup(name, email, password, confirmPassword);
  }

  Future logout() async {
    _token = "";
    doctor.value = Doctor();
    authenticated.value = false;
    return !authenticated.value;
  }
}

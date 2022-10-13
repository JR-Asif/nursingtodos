import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/core/preferences/preference_data.dart';
import 'package:flutter_firebase/core/preferences/preference_keys.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/modules/task/home_controller.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

class LoginController extends GetxController {
  String myUserId = "4wpU3gIFdFXVArB9qYtD";
  String myShiftId = "morning_shift";

  bool isUserDataLoaded = false;
  UserModel? userData;

  login() {
    SharedPreferenceManager.saveString(SharePreferenceKeys.userId, myUserId);
    SharedPreferenceManager.saveString(SharePreferenceKeys.shiftId, myUserId);
  }

  logout() {
    SharedPreferenceManager.removeKey(SharePreferenceKeys.userId);
    SharedPreferenceManager.removeKey(SharePreferenceKeys.shiftId);
  }

  getLoginID() async {
    return await SharedPreferenceManager.getString(SharePreferenceKeys.userId);
  }

  getShiftID() async {
    return await SharedPreferenceManager.getString(SharePreferenceKeys.shiftId);
  }

  getLoginData() {
    isUserDataLoaded = false;
    update();
    FirebaseFirestore.instance
        .collection("users")
        .doc(myUserId)
        .get()
        .then((dat) {
      userData = UserModel.fromJson(dat.data() as Map<String, dynamic>);
      isUserDataLoaded = true;
      print(userData);
      update();
    });
  }
}

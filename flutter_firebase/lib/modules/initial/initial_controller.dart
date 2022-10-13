import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/shift_model.dart';
import 'package:flutter_firebase/models/task_model.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/modules/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InitialController extends GetxController {
  String? shiftId;
  String? userId;
  final cron = Cron();
  CollectionReference _taskDb = FirebaseFirestore.instance.collection("tasks");
  CollectionReference _userDb = FirebaseFirestore.instance.collection("users");
  UserModel? userModel;

  cronJob() async {
    print("INITIAL CONTROLLER");
    LoginController loginController = LoginController();

    shiftId = loginController.myShiftId;
    userId = loginController.myUserId;
    _userDb.doc(userId).get().then((doc) {
      userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      shiftId = userModel!.shift_id;
      print("Shift Id was: $shiftId");
      if (shiftId == ShiftType.morning_shift.name) {
        cron.schedule(Schedule.parse('0 14 * * *'), () async {
          // cron.schedule(Schedule.parse('19 1 * * *'), () async {
          print('Morning Shift has Ended');
          passTaskstoNextShift(ShiftType.evening_shift.name);
        });
      } else if (shiftId == ShiftType.evening_shift.name) {
        cron.schedule(Schedule.parse('30 21 * * *'), () async {
          print('Evening Shift has Ended');
          passTaskstoNextShift(ShiftType.night_shift.name);
        });
      } else if (shiftId == ShiftType.night_shift.name) {
        cron.schedule(Schedule.parse('30 6 * * *'), () async {
          print('Night Shift has Ended');
          passTaskstoNextShift(ShiftType.morning_shift.name);
        });
      }
    });
  }

  passTaskstoNextShift(String shift) {
    Get.defaultDialog(
        contentPadding: EdgeInsets.all(16),
        title: "Shift Alert",
        middleText:
            "As your shift time is over we need to shift your incomplete duties to the next staff",
        backgroundColor: Colors.white.withOpacity(0.8),
        titleStyle: const TextStyle(color: Colors.black),
        middleTextStyle: const TextStyle(color: Colors.black87),
        radius: 18);
    print("passTaskstoNextShift ---------");
    _userDb
        .where("shift_id", isEqualTo: ShiftType.evening_shift.name)
        .limit(1)
        .get()
        .then((userDoc) {
      print(userDoc.docs.first.id);
      _taskDb
          .where("assignedTo", isEqualTo: userId)
          .where("status", isNotEqualTo: TaskStatus.completed.name)
          .get()
          .then((docss) {
        for (int i = 0; i < docss.size; i++) {
          print("assigning tasks to $shift to");
          print(docss.docs.elementAt(i).id);
          _taskDb
              .doc(docss.docs.elementAt(i).id)
              .update({"assignedTo": userDoc.docs.first.id});
        }
      }).onError((error, stackTrace) {
        print(error);
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}

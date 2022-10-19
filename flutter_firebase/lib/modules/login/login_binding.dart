import 'package:flutter_firebase/modules/task/task_controller.dart';
import 'package:flutter_firebase/modules/login/login_controller.dart';
import 'package:get/instance_manager.dart'; 

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

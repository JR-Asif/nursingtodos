import 'package:flutter_firebase/modules/task/task_controller.dart';
import 'package:get/instance_manager.dart'; 

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

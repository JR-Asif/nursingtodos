import 'package:flutter_firebase/modules/initial/initial_controller.dart';
import 'package:get/instance_manager.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitialController(), fenix: true);
  }
}

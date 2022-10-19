import 'package:flutter/material.dart';
import 'package:flutter_firebase/modules/login/login_binding.dart'; 
import 'package:flutter_firebase/modules/task/views/detail_task.dart';
import 'package:flutter_firebase/modules/task/task_binding.dart';
import 'package:flutter_firebase/modules/login/login.dart';
import 'package:flutter_firebase/modules/task/views/list_task.dart';
import 'package:flutter_firebase/modules/task/views/add_task.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  // final initial = Routes.SPLASH;
  final initial = Routes.LOGIN;

  static final routes = [
    // GetPage(
    //   name: Routes.SPLASH,
    //   page: () => const SplashScreen(),
    //   binding: SplashBinding(),
    // ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const MyLogin(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.ADDACTION,
      transition: Transition.downToUp,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(seconds: 1),
      page: () => const AddAction(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TASKLIST, 
      page: () => TaskList(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: Routes.HOME, 
        page: () => Home(),
        binding: HomeBinding(),
        children: [
          GetPage(
            name: Routes.ADDACTION,
            page: () => const AddAction(),
            binding: HomeBinding(),
          ),
          // GetPage(
          //   name: Routes.SETTING,
          //   page: () => SettingScreen(),
          //   binding: SettingBinding(),
          // ),
        ]),
  ];
}

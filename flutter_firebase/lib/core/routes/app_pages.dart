import 'package:flutter/material.dart';
import 'package:flutter_firebase/modules/task/add_task.dart';
import 'package:flutter_firebase/modules/task/detail_task.dart';
import 'package:flutter_firebase/modules/task/home_binding.dart';
import 'package:flutter_firebase/modules/login/login.dart';
import 'package:flutter_firebase/modules/task/list_task.dart';
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
      page: () => MyLogin(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.ADDACTION,
      page: () => AddAction(),
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
            page: () => AddAction(),
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

import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/modules/initial/initial_controller.dart';
import 'package:flutter_firebase/modules/login/login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'core/routes/app_pages.dart';
import 'modules/initial/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    InitialController().cronJob();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages().initial,
        getPages: AppPages.routes,
        navigatorKey: Get.key,
        // initialBinding: InitialBinding(),
        home: const Scaffold(
          body: MyLogin(),
        ));
  }
}

// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:user/main.dart';
// import 'package:user/modules/order_screen/views/order_processing.dart';
// import 'package:user/shared/constant/colors.dart';

// import '../../modules/order_detail/controller/order_detail_controller.dart';
// import '../../modules/order_screen/controllers/order_controller.dart';
// import '../routes/app_routes.dart';

// class PushNotificationsManager {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   factory PushNotificationsManager() => _instance;
//   PushNotificationsManager._();
//   static final PushNotificationsManager _instance =
//       PushNotificationsManager._();
//   bool _initialized = false;
//   late String token;
//   late AndroidNotificationDetails androidNotificationDetails;

//   // notification routes define here
//   static const String ORDERCANCELLED = 'order_cancelled';
//   static const String ORDERTIMEOUT = 'order_timeout';
//   static const String ORDERACCEPTED = 'order_accepted';
//   static const String ORDERREJECTED = 'order_rejected';
//   static const String ORDERCOLLECTIONSTARTED = 'order_collection_started';
//   static const String ORDERCOLLECTED = 'order_collected';

//   Future<void> init(BuildContext context) async {
//     if (!_initialized) {
//       const initializationSettingsAndroid =
//           AndroidInitializationSettings('notification_icon');
//       const IOSInitializationSettings initializationSettingsIOs =
//           IOSInitializationSettings();
//       const initSetttings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOs,
//       );
//       flutterLocalNotificationsPlugin.initialize(
//         initSetttings,
//         onSelectNotification: onSelectNotification,
//       );
//       _firebaseMessaging.getToken().then((token) {
//         this.token = token!;
//       });

//       _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );

//       FirebaseMessaging.onBackgroundMessage(
//         (message) => backgroundHandler(message),
//       );

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//         final RemoteNotification? notification = message.notification;
//         final AndroidNotification? android = message.notification?.android;

//         print('message ==> ${message.data}');

//         androidNotificationDetails = AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           icon: 'notification_icon',
//           importance: Importance.max,
//           color: AppColors.primaryColor,
//           priority: Priority.high,
//           styleInformation: BigTextStyleInformation(
//             message.notification!.body!,
//             summaryText: 'New Notification',
//           ),
//           groupKey: channel.groupId,
//         );
//         print("Notification & Android: 0 "  );
//         if (notification != null && android != null) {
//           print("Notification & Android: " +
//               notification.toString() +
//               android.toString());
//           if (message.data['action'] == ORDERACCEPTED) {
//             final bool isRegister = Get.isRegistered<OrderController>();
//             if (isRegister) {
//               final OrderController orderController =
//                   Get.find<OrderController>();
//               if (orderController != null &&
//                   (orderController.orderId ==
//                       int.parse(message.data["order_id"].toString()))) {
//                 orderController
//                     .setOrderId(int.parse(message.data["order_id"].toString()));
//                 orderController.orderDetailsSingle();
//                 // break the code if user is on the current screen
//                 return;
//               } else {
//                 _localNotificationShowMessage(
//                   notification,
//                   jsonEncode(message.data),
//                   androidNotificationDetails,
//                 );
//               }
//             }
//           }
//         }
//       });

//       FirebaseMessaging.onMessageOpenedApp
//           .listen((RemoteMessage message) async {
//         if (message != null) {
//           switch (message.data['action'].toString()) {
//             case ORDERCANCELLED:
//               navigateOrderCancelledOrCompleted(
//                 message.data["order_id"].toString(),
//               );
//               break;
//             case ORDERTIMEOUT:
//               navigateToOrderProcessing(
//                 int.parse(message.data["order_id"].toString()),
//               );
//               break;
//             case ORDERACCEPTED:
//               navigateToOrderProcessing(
//                 int.parse(message.data["order_id"].toString()),
//               );

//               break;
//             case ORDERREJECTED:
//               navigateToOrderProcessing(
//                 int.parse(message.data["order_id"].toString()),
//               );
//               break;
//             case ORDERCOLLECTIONSTARTED:
//               break;
//             case ORDERCOLLECTED:
//               navigateOrderCancelledOrCompleted(
//                 message.data["order_id"].toString(),
//               );
//               break;
//             default:
//               break;
//           }
//         }
//       });

//       _initialized = true;
//     }
//   }

//   Future<void> getInitialMessage({bool background = false}) async {
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) async {
//       print("Handling foreground message");
//       if (message != null) {
//         switch (message.data['action'].toString()) {
//           case ORDERCANCELLED:
//             navigateOrderCancelledOrCompleted(
//               message.data["order_id"].toString(),
//               background: background,
//             );
//             break;
//           case ORDERTIMEOUT:
//             navigateToOrderProcessing(
//               int.parse(message.data["order_id"].toString()),
//             );
//             break;
//           case ORDERACCEPTED:
//             navigateToOrderProcessing(
//               int.parse(message.data["order_id"].toString()),
//             );
//             break;
//           case ORDERREJECTED:
//             navigateToOrderProcessing(
//               int.parse(message.data["order_id"].toString()),
//             );
//             break;
//           case ORDERCOLLECTIONSTARTED:
//             navigateToOrderProcessing(
//               int.parse(message.data["order_id"].toString()),
//             );
//             break;
//           case ORDERCOLLECTED:
//             navigateOrderCancelledOrCompleted(
//               message.data["order_id"].toString(),
//               background: background,
//             );
//             break;
//           default:
//             break;
//         }
//       }
//     });
//   }

//   Future<void> _localNotificationShowMessage(
//     RemoteNotification notification,
//     String message,
//     AndroidNotificationDetails androidDetail,
//   ) async {
//     await flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: androidDetail,
//         iOS: const IOSNotificationDetails(
//           presentBadge: false,
//         ),
//       ),
//       payload: message,
//     );

//     final List<ActiveNotification>? activeNotifications =
//         await flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>()
//             ?.getActiveNotifications();
//     if (activeNotifications!.isNotEmpty) {
//       final List<String> lines =
//           activeNotifications.map((e) => e.title.toString()).toList();

//       final InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
//         lines,
//         contentTitle: "${activeNotifications.length - 1} messages",
//         summaryText: "${activeNotifications.length - 1} messages",
//       );
//       final AndroidNotificationDetails groupNotificationDetails =
//           AndroidNotificationDetails(
//         channel.id,
//         channel.name,
//         channelDescription: channel.description,
//         styleInformation: inboxStyleInformation,
//         setAsGroupSummary: true,
//         category: 'Notification',
//         groupKey: channel.groupId,
//       );

//       final NotificationDetails groupNotificationDetailsPlatformSpefics =
//           NotificationDetails(android: groupNotificationDetails);
//       await flutterLocalNotificationsPlugin.show(
//         0,
//         '',
//         '',
//         groupNotificationDetailsPlatformSpefics,
//       );
//     }
//   } 



//   Future<void> onSelectNotification(String? payload) async {
//     if (payload != null) {
//       Map<String, dynamic> payloadData =
//           jsonDecode(payload) as Map<String, dynamic>;
//       if (payloadData != null) {
//         switch (payloadData['action'].toString()) {
//           case ORDERCANCELLED:
//             navigateOrderCancelledOrCompleted(
//               payloadData["order_id"].toString(),
//             );
//             break;
//           case ORDERTIMEOUT:
//             navigateToOrderProcessing(
//               int.parse(payloadData["order_id"].toString()),
//             );
//             break;
//           case ORDERACCEPTED:
//             navigateToOrderProcessing(
//               int.parse(payloadData["order_id"].toString()),
//             );
//             break;
//           case ORDERREJECTED:
//             navigateToOrderProcessing(
//               int.parse(payloadData["order_id"].toString()),
//             );
//             break;
//           case ORDERCOLLECTIONSTARTED:
//             navigateToOrderProcessing(
//               int.parse(payloadData["order_id"].toString()),
//             );
//             break;
//           case ORDERCOLLECTED:
//             navigateOrderCancelledOrCompleted(
//               payloadData["order_id"].toString(),
//             );
//             break;
//           default:
//             break;
//         }
//       }
//     }
//   }

//   Future<void> backgroundHandler(RemoteMessage message) async {
//     navigateToOrderProcessing(int.parse(message.data["order_id"].toString()));
//   }

//   String get deviceToken => token;
// }

// void navigateOrderCancelledOrCompleted(
//   String orderid, {
//   bool background = false,
// }) {
//   print("Order Collected Completed ");
//   Get.lazyPut(
//     () => OrderDetailController(orderid, null),
//   );
//   if (background) {
//     Get.offNamedUntil(
//       Routes.ORDER_PROCESSING + Routes.ORDER_COMPLETED,
//       (route) => false,
//     );
//   } else {
//     Get.toNamed(Routes.ORDER_PROCESSING + Routes.ORDER_COMPLETED);
//   }
// }

// Future<void> navigateToOrderProcessing(
//   int orderid,
// ) async {
//   //try {
//   final bool isRegister = Get.isRegistered<OrderController>();
//   final OrderController controller;
//   if (isRegister) {
//     controller = Get.find<OrderController>();
//     print("IsRegistered");
//   } else {
//     print("IsRegistered");
//     controller = Get.put(OrderController());
//   }
//   controller.clearDetails();

//   controller.setOrderId(orderid);
//   controller.orderDetailsSingle();
//   //controller.orderDetailsSingle();
//   print("Order ID ===> $orderid");

//   Get.key.currentState
//       ?.push(MaterialPageRoute(builder: (_) => const OrderProcessingScreen()));
//   //Get.toNamed(Routes.ORDER_PROCESSING, preventDuplicates: true);
//   // } on Exception catch (e) {
//   //   print('error');
//   // } catch (e) {
//   //   print('error');
//   // }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_firebase/core/routes/app_routes.dart';
import 'package:flutter_firebase/models/task_model.dart';
import 'package:flutter_firebase/utils/appbar.dart';
import 'package:flutter_firebase/utils/colors.dart';
import 'package:flutter_firebase/utils/util_functions.dart';
import 'package:flutter_firebase/modules/task/detail_task.dart';
import 'package:flutter_firebase/modules/task/home_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../utils/task_list_box.dart';

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TaskListState();
}

late HomeController homeController = HomeController();

class _TaskListState extends State<TaskList> {
  List<String> days = [
    "Aged Care",
    "General Ward",
    "Stand Up",
    "Medicines",
    "Regular Checkups",
    "Saturday",
    "Sunday"
  ];
  List<Color> colors = [
    Colors.cyan.shade900,
    Colors.deepOrange.shade300,
    Colors.lime.shade700,
    Colors.brown.shade600,
    Colors.tealAccent.shade700,
    Colors.red.shade400,
    Colors.blueGrey.shade800
  ];
  List<String> images = [
    "assets/images/healthcare0.png",
    "assets/images/healthcare7.png",
    "assets/images/healthcare7.png",
    "assets/images/healthcare7.png",
    "assets/images/healthcare7.png",
    "assets/images/healthcare7.png",
    "assets/images/healthcare7.png",
  ];
  @override
  void initState() {
    homeController = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          appBar: standardAppBar,
          body: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: GetBuilder<HomeController>(
                init: homeController.getAssignedTasks(),
                builder: (controller) {
                  return controller.isTaskLoading
                      ? Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "All tasks",
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35.0),
                                  ),
                                  Text(
                                    "of this week",
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 12, right: 12),
                                child: Container(
                                    height: 0.5, color: Colors.grey.shade300),
                              ),
                              Container(
                                height: Get.height * 0.50,
                                width: Get.width * 0.85,
                                child: Expanded(
                                    child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: days.length,
                                  itemBuilder: ((context, i) {
                                    return GestureDetector(
                                      onTap: (() {
                                        Get.toNamed(Routes.HOME, arguments: {
                                          "day": days.elementAt(i),
                                          "color": colors.elementAt(i)
                                        });
                                      }),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0, bottom: 10),
                                          child: taskListBox(
                                              "${days.elementAt(i)}",
                                              colors.elementAt(i),
                                              images.elementAt(i))),
                                    );
                                  }),
                                )),
                              )

                              // child: GridView.count(
                              //     crossAxisCount: 2,
                              //     crossAxisSpacing: 2.0,
                              //     mainAxisSpacing: 2.0,
                              //     childAspectRatio: 1.5,
                              //     shrinkWrap: true,
                              //     children: List.generate(
                              //       days.length,
                              //       (i) {
                              //         return GestureDetector(
                              //           onTap: (() => Get.toNamed(
                              //                   Routes.HOME,
                              //                   arguments: {
                              //                     "day": days.elementAt(i),
                              //                     "color":
                              //                         colors.elementAt(i)
                              //                   })),
                              //           child: Padding(
                              //             padding: const EdgeInsets.only(
                              //                 right: 10.0, bottom: 10),
                              //             child: Container(
                              //               decoration: BoxDecoration(
                              //                 color: colors.elementAt(i),
                              //                 borderRadius:
                              //                     const BorderRadius.all(
                              //                   Radius.circular(8.0),
                              //                 ),
                              //               ),
                              //               child: Center(
                              //                   child: Text(
                              //                 "${days.elementAt(i)}",
                              //                 style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 18),
                              //               )),
                              //             ),
                              //           ),
                              //         );
                              //       },
                              //     ))),
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                          color: ColorsScheme.primaryColor,
                        ));
                }),
          )),
    );
  }
}

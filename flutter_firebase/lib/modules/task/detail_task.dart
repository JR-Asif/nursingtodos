import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_firebase/core/routes/app_routes.dart';
import 'package:flutter_firebase/models/task_model.dart';
import 'package:flutter_firebase/utils/appbar.dart';
import 'package:flutter_firebase/utils/colors.dart';
import 'package:flutter_firebase/utils/util_functions.dart';
import 'package:flutter_firebase/modules/task/home_controller.dart';
import 'package:flutter_firebase/modules/task/list_task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int totalDone = 0;
  late var themeColor;
  @override
  void initState() {
    HomeController homeController = HomeController();
    // homeController.generateUserMock();
    themeColor = Get.arguments["color"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          appBar: standardAppBar,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(14.0),
            child: FloatingActionButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                backgroundColor: themeColor,
                onPressed: () {
                  Get.toNamed(Routes.ADDACTION);
                },
                child: const Icon(FontAwesomeIcons.add)),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: GetBuilder<HomeController>(
                init: HomeController().getAssignedTasks(),
                builder: (controller) {
                  return controller.isTaskLoading
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("tasks")
                              .where("assignedTo",
                                  isEqualTo: homeController.myUserId)
                              .orderBy("createdAt", descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              totalDone = snapshot.data!.docs
                                  .where((element) =>
                                      element.data()["status"] ==
                                      TaskStatus.completed.name)
                                  .length;
                              return Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 10,
                                          lineWidth: 3,

                                          percent: totalDone /
                                              controller.tasks.length,
                                          // center: Icon(Icons.today_rounded),
                                        ),
                                        const SizedBox(width: 14.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Get.arguments["day"],
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  color: themeColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 35.0),
                                            ),
                                            Text(
                                              "$totalDone of ${controller.tasks.length} tasks",
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, bottom: 12, right: 12),
                                      child: Container(
                                          height: 0.5,
                                          color: Colors.grey.shade300),
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: snapshot.data!.size,
                                      itemBuilder: (_, i) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              color: ColorsScheme.primaryColor.withOpacity(0.2)),
                                              margin: EdgeInsets.only(bottom: 12,right:12),
                                          padding: const EdgeInsets.only(left: 14,
                                              top: 16, bottom: 16, right: 8),
                                          child: GestureDetector(
                                            onTap: (() {
                                              if (snapshot.data!.docs
                                                      .elementAt(i)
                                                      .data()["status"] ==
                                                  TaskStatus.completed.name) {
                                                controller.updateTaskStatus(
                                                    snapshot.data!.docs
                                                        .elementAt(i)
                                                        .id,
                                                    false);
                                                totalDone++;
                                              } else {
                                                controller.updateTaskStatus(
                                                    snapshot.data!.docs
                                                        .elementAt(i)
                                                        .id,
                                                    true);
                                                totalDone--;
                                              }
                                              setState(() {});
                                            }),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0),
                                                  child: Icon(
                                                    snapshot.data!.docs
                                                                    .elementAt(i)
                                                                    .data()[
                                                                "status"] ==
                                                            TaskStatus
                                                                .completed.name
                                                                .toString()
                                                        ? FontAwesomeIcons
                                                            .checkSquare
                                                        : FontAwesomeIcons
                                                            .square,
                                                    color: snapshot.data!.docs
                                                                    .elementAt(i)
                                                                    .data()[
                                                                "status"] ==
                                                            TaskStatus
                                                                .completed.name
                                                                .toString()
                                                        ? themeColor
                                                            .withOpacity(0.7)
                                                        : Colors.black54,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot.data!.docs
                                                              .elementAt(i)
                                                              .data()["title"]
                                                              .toString(),
                                                          maxLines: 5,
                                                          style: TextStyle(
                                                              decorationColor:
                                                                  themeColor.withOpacity(
                                                                      0.7),
                                                              decoration: snapshot.data!.docs.elementAt(i).data()["status"] ==
                                                                      TaskStatus
                                                                          .completed
                                                                          .name
                                                                          .toString()
                                                                  ? TextDecoration
                                                                      .lineThrough
                                                                  : TextDecoration
                                                                      .none,
                                                              height: 1,
                                                              color: snapshot.data!.docs.elementAt(i).data()["status"] ==
                                                                      TaskStatus
                                                                          .completed
                                                                          .name
                                                                          .toString()
                                                                  ? themeColor
                                                                      .withOpacity(
                                                                          0.7)
                                                                  : Colors.black
                                                                      .withOpacity(0.9),
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 18),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          readTimestamp(
                                                                  controller
                                                                      .tasks
                                                                      .elementAt(
                                                                          i)
                                                                      .createdAt
                                                                      .seconds)
                                                              .toString(),
                                                          maxLines: 5,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14),
                                                        )
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                                  ],
                                ),
                              );
                            } else {
                              return const Center(child: Text("No Tasks"));
                            }
                          })
                      : Center(
                          child: CircularProgressIndicator(
                              color: ColorsScheme.primaryColor));
                }),
          )),
    );
  }
}

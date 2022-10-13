import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_firebase/core/routes/app_routes.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/modules/task/detail_task.dart';
import 'package:flutter_firebase/utils/appbar.dart';
import 'package:flutter_firebase/utils/colors.dart';
import 'package:flutter_firebase/modules/task/home_controller.dart';
import 'package:get/get.dart';

class AddAction extends StatefulWidget {
  const AddAction({super.key});

  @override
  State<AddAction> createState() => _AddActionState();
}

class _AddActionState extends State<AddAction> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  late String selectedValue;
  late String selectedId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset : false,
      appBar: standardAppBar,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: descController,
                style: TextStyle(),
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              FutureBuilder(
                future: HomeController().getAllUsers(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    selectedValue = snapshot.data!.first.name;
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: DropdownButtonFormField(
                        isExpanded: true, 
                        // underline: Container(),
                        value: selectedValue,

                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            selectedId = snapshot.data!
                                .where(
                                    (element) => element.name == selectedValue)
                                .first
                                .id;
                            print(selectedId);
                          });
                        },
                        items: snapshot.data!.map((UserModel item) {
                          return DropdownMenuItem(
                            value: item.name,
                            child: Text(item.name),
                          );
                        }).toList(),
                      ),
                    );
                  } else
                    return Container();
                }),
              ),
              const SizedBox(height: 40),
              Container(
                height: 60,
                width: Get.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsScheme.primaryColor),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    if (titleController.text.isEmpty) {
                      Get.snackbar("Invalid Input!", "Title cannot be null");
                    } else {
                      await HomeController()
                          .addTask(titleController.text, descController.text);
                      titleController.clear();
                      descController.clear();
                      Get.snackbar("Great", "Action Added Successfully!");
                      Get.offAllNamed(Routes.TASKLIST);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/resident_model.dart';
import 'package:flutter_firebase/models/task_model.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/modules/login/login_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String myUserId = LoginController().myUserId;
  bool isTaskLoading = false;
  List<TaskModel> tasks = [];
  List<TaskModel> tasks2 = [];
  bool isNursesLoading = false;
  List<UserModel> nurses = [];

  static final String _taskUrl = 'tasks';
  CollectionReference _taskDb = FirebaseFirestore.instance.collection(_taskUrl);

  static final String _residentUrl = 'residents';
  CollectionReference _residentDb =
      FirebaseFirestore.instance.collection(_residentUrl);

  static final String _userUrl = 'users';
  CollectionReference _userDb = FirebaseFirestore.instance.collection(_userUrl);

  generateTaskMock() {
    String docId = _taskDb.doc().id;
    TaskModel taskModel = TaskModel(
      id: docId,
      title:
          "We need to confirm that Mrs. Schneider drinks at least 700 ml liquids per day",
      description:
          "Mr. Schneider is a insomniac patient in room no 6, general ward. Here is his medical History: ",
      assignedTo: "",
      createdAt: Timestamp.now(),
      patientId: "Sks65XGmg3gzV0PoQFk6",
      status: TaskStatus.notAssigned.name,
    );
    _taskDb.doc(docId).set(taskModel.toJson());
  }

  generateResidentMock() {
    String docId = _residentDb.doc().id;
    ResidentModel residentModel = ResidentModel(
      id: docId,
      name: "Mr. Meyer",
      phone_number: '+923206898882',
      disease: "Typhoid",
    );

    _residentDb.doc(docId).set(residentModel.toJson());
  }

  generateUserMock() {
    String docId = _userDb.doc().id;
    UserModel _userModel = UserModel(
        id: docId,
        name: "Dr Joe",
        phone_number: '+923206898332',
        shift_id: "evening_shift");

    _userDb.doc(docId).set(_userModel.toJson());
  }

  getAssignedTasks() {
    print("getAssignedTasks");
    tasks = [];
    isTaskLoading = false;
    update();
    _taskDb
        .where("assignedTo", isEqualTo: myUserId)
        .get()
        .then((querySnapshot) {
      print(querySnapshot);
      for (var doc in querySnapshot.docs) {
        print("adding ${doc.id}");
        tasks.add(TaskModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      isTaskLoading = true;
      print(tasks);
      tasks2.addAll(tasks);
      update();
    });
  }

  getTasks() {
    print("getTasks");
    tasks = [];
    isTaskLoading = false;
    update();
    var querySnapshot = _taskDb.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        tasks.add(TaskModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      isTaskLoading = true;
      tasks2.addAll(tasks);
      update();
    });
  }

  updateTaskStatus(String docId, bool val) async {
    _taskDb.doc(docId).update({
      "status": val ? TaskStatus.completed.name : TaskStatus.notAssigned.name
    });
    // getAssignedTasks();
    // update();
  }

  addTask(String title, String description) async {
    String docId = _taskDb.doc().id;
    TaskModel taskModel = TaskModel(
      id: docId,
      title: title,
      description: description,
      assignedTo: LoginController().myUserId,
      createdAt: Timestamp.now(),
      patientId: "Sks65XGmg3gzV0PoQFk6",
      status: TaskStatus.notAssigned.name,
    );
    _taskDb.doc(docId).set(taskModel.toJson());

    update();
  }

  Future<List<UserModel>> getAllUsers() async {
    // nurses = [];
    // isNursesLoading = false;
    // update();
    QuerySnapshot docss = await _userDb.get();

    for (int i = 0; i < docss.size; i++) {
      nurses.add(UserModel.fromJson(
          docss.docs.elementAt(i).data() as Map<String, dynamic>));
    }
    // print("nurses" + nurses.toString());
    // isNursesLoading = true;
    // update();
    return nurses;
  }
}

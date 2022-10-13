import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { notAssigned, assigned, inProgress, completed }

class TaskModel {
  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.assignedTo,
      required this.status,
      required this.patientId});

  String id = "";
  String title = "";
  String description = "";
  Timestamp createdAt = Timestamp.now();
  String assignedTo = "";
  String status = "";
  String patientId = "";

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    description = json['description'].toString();
    createdAt = json['createdAt'];
    assignedTo = json['assignedTo'].toString();
    status = json['status'].toString();
    patientId = json['patientId'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['createdAt'] = createdAt;
    _data['assignedTo'] = assignedTo;
    _data['status'] = status;
    _data['patientId'] = patientId;

    return _data;
  }
}

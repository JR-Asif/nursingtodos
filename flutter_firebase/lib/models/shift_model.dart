import 'package:cloud_firestore/cloud_firestore.dart';

enum ShiftType{
  morning_shift,
  evening_shift,
  night_shift
}
class ShiftModel {
 
  ShiftModel({
    required this.id,
    required this.start_timing,
    required this.off_timing,
  });

  String? id;
  String? start_timing;
  String? off_timing;

  ShiftModel.fromJson(Map<String, dynamic> json, String uid) {
    id = uid;
    start_timing = json['start_timing'].toString();
    off_timing = json['off_timing'].toString();
  }

  Map<String, dynamic> toJson(String uid) {
    final _data = <String, dynamic>{};
    _data['id'] = uid;
    _data['start_timing'] = start_timing;
    _data['off_timing'] = off_timing;
    return _data;
  }
}

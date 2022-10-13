import 'package:flutter_firebase/models/shift_model.dart';

class UserModel {
  UserModel(
      {required this.id,
      required this.name,
      required this.phone_number,
      required this.shift_id});

  String id = "";
  String name = "";
  String phone_number = "";
  String shift_id = "";

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    phone_number = json['phone_number'].toString();
    shift_id = json['shift_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['phone_number'] = phone_number;
    _data['shift_id'] = phone_number;
    return _data;
  }
}

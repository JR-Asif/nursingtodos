class ResidentModel {
  ResidentModel({
    required this.id,
    required this.name,
    required this.phone_number,
    required this.disease,
  });

  String? id;
  String? name;
  String? phone_number;
  String? disease;

  ResidentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    phone_number = json['phone_number'].toString();
    disease = json['disease'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['phone_number'] = phone_number;
    _data['disease'] = disease;
    return _data;
  }
}

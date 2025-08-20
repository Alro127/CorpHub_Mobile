class NameInfo {
  final int id;
  final String fullName;

  NameInfo({required this.id, required this.fullName});

  factory NameInfo.fromJson(Map<String, dynamic> json) {
    return NameInfo(id: json['id'], fullName: json['fullName']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'fullName': fullName};
  }
}

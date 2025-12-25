class UnitProductModel {
  final int id;
  final String name;
  final String status;

  UnitProductModel({
    required this.id,
    required this.name,
    required this.status,
  });

  factory UnitProductModel.fromJson(Map<String, dynamic> json) {
    return UnitProductModel(
      id: json['id'],
      name: json['name'],
      status: json['status'].toString(),
    );
  }
}

class CategoryModel {
  final int id;
  final int status;
  final String name;

  CategoryModel({
    required this.id,
    required this.status,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      status: json['status'],
      name: json['name'],
    );
  }
}

class SubCategoryModel {
  final int id;
  final int status;
  final int categoryId;
  final String categoryName;
  final String subCategoryName;

  SubCategoryModel({
    required this.id,
    required this.status,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryName,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      status: json['status'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      subCategoryName: json['subCategory_name'],
    );
  }
}

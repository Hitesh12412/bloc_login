class BrandModel {
  final int id;
  final String name;
  final String brandImage;
  final int status;

  BrandModel({
    required this.id,
    required this.name,
    required this.brandImage,
    required this.status,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      name: json['name'],
      brandImage: json['brand_image'] ?? '',
      status: json['status'],
    );
  }
}

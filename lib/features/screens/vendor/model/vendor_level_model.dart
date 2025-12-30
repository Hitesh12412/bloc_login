class VendorLevelModel {
  final int id;
  final int createdBy;
  final int updatedBy;
  final String name;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  VendorLevelModel({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory VendorLevelModel.fromJson(Map<String, dynamic> json) {
    return VendorLevelModel(
      id: json['id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      name: json['name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'name': name,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}

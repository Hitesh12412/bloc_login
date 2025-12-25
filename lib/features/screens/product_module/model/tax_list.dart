class TaxModel {
  final int id;
  final String taxType;
  final String taxName;
  final String taxRate;
  final String status;

  TaxModel({
    required this.id,
    required this.taxType,
    required this.taxName,
    required this.taxRate,
    required this.status,
  });

  factory TaxModel.fromJson(Map<String, dynamic> json) {
    return TaxModel(
      id: json['id'],
      taxType: json['tax_type'],
      taxName: json['tax_name'],
      taxRate: json['tax_rate'],
      status: json['status'],
    );
  }
}

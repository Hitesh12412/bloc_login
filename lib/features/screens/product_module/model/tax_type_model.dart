class TaxTypeModel {
  final int id;
  final String taxType;
  final String taxName;
  final String taxRate;

  TaxTypeModel({
    required this.id,
    required this.taxType,
    required this.taxName,
    required this.taxRate,
  });

  factory TaxTypeModel.fromJson(Map<String, dynamic> json) {
    return TaxTypeModel(
      id: json['id'],
      taxType: json['tax_type'],
      taxName: json['tax_name'],
      taxRate: json['tax_rate'],
    );
  }
}

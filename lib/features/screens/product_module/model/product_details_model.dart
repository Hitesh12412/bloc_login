class ProductDetailModel {
  final int status;
  final ProductData data;
  final String message;

  ProductDetailModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      status: json['status'] ?? 0,
      data: ProductData.fromJson(json['data'] ?? {}),
      message: json['message'] ?? '',
    );
  }
}

class ProductData {
  final int id;
  final String jobNumber;
  final String name;
  final String description;
  final String hsnCode;
  final int categoryId;
  final String categoryName;
  final int subCategoryId;
  final String subCategoryName;
  final int brandId;
  final String brandName;
  final int unitId;
  final String unitName;
  final int tax1Id;
  final String tax1Rate;
  final String tax1Name;
  final int tax2Id;
  final String tax2Rate;
  final String tax2Name;
  final int tax3Id;
  final String tax3Rate;
  final String tax3Name;
  final int productTypeId;
  final String productTypeName;
  final String status;
  final int qty;
  final String productPrice;
  final String maxPurchasePrice;
  final List<dynamic> productItemList;

  ProductData({
    required this.id,
    required this.jobNumber,
    required this.name,
    required this.description,
    required this.hsnCode,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.brandId,
    required this.brandName,
    required this.unitId,
    required this.unitName,
    required this.tax1Id,
    required this.tax1Rate,
    required this.tax1Name,
    required this.tax2Id,
    required this.tax2Rate,
    required this.tax2Name,
    required this.tax3Id,
    required this.tax3Rate,
    required this.tax3Name,
    required this.productTypeId,
    required this.productTypeName,
    required this.status,
    required this.qty,
    required this.productPrice,
    required this.maxPurchasePrice,
    required this.productItemList,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] ?? 0,
      jobNumber: json['job_number'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      hsnCode: json['hsn_code'] ?? '',
      categoryId: json['category_id'] ?? 0,
      categoryName: json['category_name'] ?? '',
      subCategoryId: json['sub_category_id'] ?? 0,
      subCategoryName: json['subCategory_name'] ?? '',
      brandId: json['brand_id'] ?? 0,
      brandName: json['brand_name'] ?? '',
      unitId: json['unit_id'] ?? 0,
      unitName: json['unit_name'] ?? '',
      tax1Id: json['tax1_id'] ?? 0,
      tax1Rate: json['tax1_rate']?.toString() ?? '',
      tax1Name: json['tax1_name'] ?? '',
      tax2Id: json['tax2_id'] ?? 0,
      tax2Rate: json['tax2_rate']?.toString() ?? '',
      tax2Name: json['tax2_name'] ?? '',
      tax3Id: json['tax3_id'] ?? 0,
      tax3Rate: json['tax3_rate']?.toString() ?? '',
      tax3Name: json['tax3_name'] ?? '',
      productTypeId: json['product_type_id'] ?? 0,
      productTypeName: json['product_type_name'] ?? '',
      status: json['status'] ?? '',
      qty: json['qty'] ?? 0,
      productPrice: json['product_price']?.toString() ?? '',
      maxPurchasePrice: json['max_purchase_price']?.toString() ?? '',
      productItemList: json['productItemList'] ?? [],
    );
  }
}

class ProductList {
  final int status;
  final List<ProductListModel> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  ProductList({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => ProductListModel.fromJson(e))
          .toList(),
      totalPages: json['totalPages'] ?? 1,
      totalCount: json['totalCount'] ?? 0,
      pageNumber: json['pageNumber'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class ProductListModel {
  final int id;
  final String jobNumber;
  final String name;
  final String description;
  final String hsnCode;
  final int categoryId;
  final String categoryName;
  final int subCategoryId;
  final String subCategoryName;
  final String orderId;
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
  final String qty;
  final int taxOrNot;
  final String productPrice;
  final String maxPurchasePrice;
  final List<ProductItem> productItemList;

  ProductListModel({
    required this.id,
    required this.jobNumber,
    required this.name,
    required this.description,
    required this.hsnCode,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.orderId,
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
    required this.taxOrNot,
    required this.productPrice,
    required this.maxPurchasePrice,
    required this.productItemList,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id'] ?? 0,
      jobNumber: json['job_number'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      hsnCode: json['hsn_code'] ?? '',
      categoryId: json['category_id'] ?? 0,
      categoryName: json['category_name'] ?? '',
      subCategoryId: json['sub_category_id'] ?? 0,
      subCategoryName: json['subCategory_name'] ?? '',
      orderId: json['order_id'] ?? '',
      brandId: json['brand_id'] ?? 0,
      brandName: json['brand_name'] ?? '',
      unitId: json['unit_id'] ?? 0,
      unitName: json['unit_name'] ?? '',
      tax1Id: json['tax1_id'] ?? 0,
      tax1Rate: json['tax1_rate']?.toString() ?? '0',
      tax1Name: json['tax1_name'] ?? '',
      tax2Id: json['tax2_id'] ?? 0,
      tax2Rate: json['tax2_rate']?.toString() ?? '0',
      tax2Name: json['tax2_name'] ?? '',
      tax3Id: json['tax3_id'] ?? 0,
      tax3Rate: json['tax3_rate']?.toString() ?? '0',
      tax3Name: json['tax3_name'] ?? '',
      productTypeId: json['product_type_id'] ?? 0,
      productTypeName: json['product_type_name'] ?? '',
      status: json['status']?.toString() ?? '',
      qty: json['qty']?.toString() ?? '0',
      taxOrNot: json['taxOrNot'] ?? 0,
      productPrice: json['product_price']?.toString() ?? '0',
      maxPurchasePrice:
      json['max_purchase_price']?.toString() ?? '0',
      productItemList: (json['productItemList'] as List? ?? [])
          .map((e) => ProductItem.fromJson(e))
          .toList(),
    );
  }
}

class ProductItem {
  final int id;
  final int categoryId;
  final String categoryName;
  final int subCategoryId;
  final String subCategoryName;
  final int brandId;
  final String brandName;
  final int productid;
  final int productId;
  final String jobNumber;
  final String productName;
  final int productQty;
  final String productPrice;
  final String subProductMaxPurchasePrice;
  final String qty;
  final String description;

  ProductItem({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.brandId,
    required this.brandName,
    required this.productid,
    required this.productId,
    required this.jobNumber,
    required this.productName,
    required this.productQty,
    required this.productPrice,
    required this.subProductMaxPurchasePrice,
    required this.qty,
    required this.description,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['category_name'] ?? '',
      subCategoryId: json['subCategoryId'] ?? 0,
      subCategoryName: json['subCategory_name'] ?? '',
      brandId: json['brandId'] ?? 0,
      brandName: json['brand_name'] ?? '',
      productid: json['productid'] ?? 0,
      productId: json['product_id'] ?? 0,
      jobNumber: json['job_number'] ?? '',
      productName: json['product_name'] ?? '',
      productQty: json['product_qty'] ?? 0,
      productPrice: json['product_price']?.toString() ?? '0',
      subProductMaxPurchasePrice:
      json['sub_product_max_purchase_price']?.toString() ?? '0',
      qty: json['qty']?.toString() ?? '0',
      description: json['description'] ?? '',
    );
  }
}

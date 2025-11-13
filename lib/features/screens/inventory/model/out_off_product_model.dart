class OutOfStockResponse {
  final int status;
  final List<OutOfStockData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  OutOfStockResponse({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory OutOfStockResponse.fromJson(Map<String, dynamic> json) {
    return OutOfStockResponse(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => OutOfStockData.fromJson(e))
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

class OutOfStockData {
  final int id;
  final String productName;
  final String productCode;
  final String categoryName;
  final String qty;
  final String minQty;
  final String productPrice;
  final String totalValue;
  final String lastRestockDate;
  final String branchId;
  final String branchName;
  final String supplierId;
  final String supplierName;
  final String status;
  final String statusName;
  final String statusTextColor;
  final String statusBgColor;
  final String createdAt;
  final String updatedAt;
  final String urgencyLevel;
  final String daysOutOfStock;

  OutOfStockData({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.categoryName,
    required this.qty,
    required this.minQty,
    required this.productPrice,
    required this.totalValue,
    required this.lastRestockDate,
    required this.branchId,
    required this.branchName,
    required this.supplierId,
    required this.supplierName,
    required this.status,
    required this.statusName,
    required this.statusTextColor,
    required this.statusBgColor,
    required this.createdAt,
    required this.updatedAt,
    required this.urgencyLevel,
    required this.daysOutOfStock,
  });

  factory OutOfStockData.fromJson(Map<String, dynamic> json) {
    return OutOfStockData(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      productName: json['product_name'] ?? '',
      productCode: json['product_code'] ?? '',
      categoryName: json['category_name'] ?? '',
      qty: json['qty']?.toString() ?? '0',
      minQty: json['min_qty']?.toString() ?? '0',
      productPrice: json['product_price']?.toString() ?? '0.00',
      totalValue: json['total_value']?.toString() ?? '0.00',
      lastRestockDate: json['last_restock_date'] ?? '',
      branchId: json['branch_id']?.toString() ?? '',
      branchName: json['branch_name'] ?? '',
      supplierId: json['supplier_id']?.toString() ?? '',
      supplierName: json['supplier_name'] ?? '',
      status: json['status']?.toString() ?? '',
      statusName: json['status_name'] ?? '',
      statusTextColor: json['status_text_color'] ?? '',
      statusBgColor: json['status_bgcolor'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      urgencyLevel: json['urgency_level'] ?? '',
      daysOutOfStock: json['days_out_of_stock']?.toString() ?? '0',
    );
  }
}

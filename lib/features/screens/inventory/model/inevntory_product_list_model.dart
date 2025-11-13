class InventoryResponse {
  final int status;
  final List<ProductData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  InventoryResponse({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory InventoryResponse.fromJson(Map<String, dynamic> json) {
    return InventoryResponse(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => ProductData.fromJson(e))
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

class ProductData {
  final String lowQtyStatus;
  final String lowQty;
  final int id;
  final String name;
  final String qty;
  final String productPrice;

  ProductData({
    required this.lowQtyStatus,
    required this.lowQty,
    required this.id,
    required this.name,
    required this.qty,
    required this.productPrice,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      lowQtyStatus: json['low_qty_status'] ?? '0',
      lowQty: json['low_qty'] ?? '0',
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      qty: json['qty']?.toString() ?? '0.00',
      productPrice: json['product_price']?.toString() ?? '0.00',
    );
  }
}

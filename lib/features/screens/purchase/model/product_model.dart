class PurchaseResponse {
  final int status;
  final List<PurchaseProduct> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  PurchaseResponse({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory PurchaseResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseResponse(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => PurchaseProduct.fromJson(e))
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

class PurchaseProduct {
  final int id;
  final String purchaseNo;
  final String orderId;
  final String productId;
  final String productName;
  final String maxPurchasePrice;
  final String qty;
  final String paymentTermsId;
  final String paymentTerm;
  final String deliverDate;
  final String description;
  final String createdAt;
  final int status;
  final String orderNo;

  PurchaseProduct({
    required this.id,
    required this.purchaseNo,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.maxPurchasePrice,
    required this.qty,
    required this.paymentTermsId,
    required this.paymentTerm,
    required this.deliverDate,
    required this.description,
    required this.createdAt,
    required this.status,
    required this.orderNo,
  });

  factory PurchaseProduct.fromJson(Map<String, dynamic> json) {
    return PurchaseProduct(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      purchaseNo: json['purchase_no'] ?? '',
      orderId: json['order_id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      productName: json['product_name'] ?? '',
      maxPurchasePrice: json['max_purchase_price']?.toString() ?? '0',
      qty: json['qty']?.toString() ?? '0',
      paymentTermsId: json['payment_terms_id']?.toString() ?? '',
      paymentTerm: json['payment_term'] ?? '',
      deliverDate: json['deliver_date'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      status: json['status'] is int ? json['status'] : int.tryParse(json['status'].toString()) ?? 0,
      orderNo: json['order_no']?.toString() ?? '',
    );
  }
}

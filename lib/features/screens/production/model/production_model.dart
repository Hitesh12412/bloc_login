class ProductionResponse {
  final int status;
  final List<OrderData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  ProductionResponse({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory ProductionResponse.fromJson(Map<String, dynamic> json) {
    return ProductionResponse(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => OrderData.fromJson(e))
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

class OrderData {
  final int id;
  final String description;
  final String branchId;
  final String branchName;
  final int status;
  final String stockStatus;
  final String orderNo;
  final String createdAt;
  final String billingAddress;
  final String shippingAddress;
  final String customerName;
  final String email;
  final String mobileNo;
  final String whatsappNo;
  final String grandTotal;
  final String pendingAmount;
  final String receivedAmount;
  final String address;
  final String statusTextColor;
  final String statusBgColor;
  final String statusName;
  final String createdBy;
  final String createdByStatus;

  OrderData({
    required this.id,
    required this.description,
    required this.branchId,
    required this.branchName,
    required this.status,
    required this.stockStatus,
    required this.orderNo,
    required this.createdAt,
    required this.billingAddress,
    required this.shippingAddress,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.whatsappNo,
    required this.grandTotal,
    required this.pendingAmount,
    required this.receivedAmount,
    required this.address,
    required this.statusTextColor,
    required this.statusBgColor,
    required this.statusName,
    required this.createdBy,
    required this.createdByStatus,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      description: json['description'] ?? '',
      branchId: json['branch_id']?.toString() ?? '',
      branchName: json['branch_name'] ?? '',
      status: json['status'] is int ? json['status'] : int.tryParse(json['status'].toString()) ?? 0,
      stockStatus: json['stock_status']?.toString() ?? '',
      orderNo: json['order_no'] ?? '',
      createdAt: json['created_at'] ?? '',
      billingAddress: json['billing_address'] ?? '',
      shippingAddress: json['shipping_address'] ?? '',
      customerName: json['customer_name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      grandTotal: json['grand_total']?.toString() ?? '0',
      pendingAmount: json['pending_amount']?.toString() ?? '0',
      receivedAmount: json['received_amount']?.toString() ?? '0',
      address: json['address'] ?? '',
      statusTextColor: json['status_text_color'] ?? '',
      statusBgColor: json['status_bgcolor'] ?? '',
      statusName: json['status_name'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdByStatus: json['created_by_status'] ?? '',
    );
  }
}

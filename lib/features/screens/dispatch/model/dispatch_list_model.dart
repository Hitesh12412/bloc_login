class DispatchList {
  final int status;
  final List<DispatchOrder> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  DispatchList({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory DispatchList.fromJson(Map<String, dynamic> json) {
    return DispatchList(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => DispatchOrder.fromJson(e))
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

class DispatchOrder {
  final int id;
  final String branchId;
  final String branchName;
  final String description;
  final int status;
  final String stockStatus;
  final String createdAt;
  final String orderNo;
  final String billingAddress;
  final String shippingAddress;
  final String exclusiveOrInclusive;
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

  DispatchOrder({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.description,
    required this.status,
    required this.stockStatus,
    required this.createdAt,
    required this.orderNo,
    required this.billingAddress,
    required this.shippingAddress,
    required this.exclusiveOrInclusive,
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

  factory DispatchOrder.fromJson(Map<String, dynamic> json) {
    return DispatchOrder(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      branchId: json['branch_id']?.toString() ?? '',
      branchName: json['branch_name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] is int ? json['status'] : int.tryParse(json['status'].toString()) ?? 0,
      stockStatus: json['stock_status']?.toString() ?? '',
      createdAt: json['created_at'] ?? '',
      orderNo: json['order_no'] ?? '',
      billingAddress: json['billing_address'] ?? '',
      shippingAddress: json['shipping_address'] ?? '',
      exclusiveOrInclusive: json['exclusive_or_inclusive']?.toString() ?? '',
      customerName: json['customer_name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      grandTotal: json['grand_total']?.toString() ?? '',
      pendingAmount: json['pending_amount']?.toString() ?? '',
      receivedAmount: json['received_amount']?.toString() ?? '',
      address: json['address'] ?? '',
      statusTextColor: json['status_text_color'] ?? '',
      statusBgColor: json['status_bgcolor'] ?? '',
      statusName: json['status_name'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdByStatus: json['created_by_status'] ?? '',
    );
  }
}

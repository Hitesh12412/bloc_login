class VendorPaymentResponse {
  final int status;
  final List<VendorPayment> data;
  final String message;

  VendorPaymentResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory VendorPaymentResponse.fromJson(Map<String, dynamic> json) {
    return VendorPaymentResponse(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => VendorPayment.fromJson(e))
          .toList(),
      message: json['message'] ?? '',
    );
  }
}

class VendorPayment {
  final int id;
  final int vendorId;
  final String vendorName;
  final String mobileNumber;
  final String receivedAmount;
  final String pendingAmount;
  final String totalAmount;

  VendorPayment({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.mobileNumber,
    required this.receivedAmount,
    required this.pendingAmount,
    required this.totalAmount,
  });

  factory VendorPayment.fromJson(Map<String, dynamic> json) {
    return VendorPayment(
      id: json['id'] ?? 0,
      vendorId: json['vendor_id'] ?? 0,
      vendorName: json['vendor_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      receivedAmount: json['receivedAmount'] ?? '0',
      pendingAmount:json['pendingAmount'] ?? '0',
      totalAmount:json['totalAmount'] ?? '0',
    );
  }
}

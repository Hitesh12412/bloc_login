class CreateCustomerRequest {
  final String dbConnection;
  final String customerName;
  final String email;
  final String mobileNo;
  final String? whatsappNo;
  final String? gstNo;
  final String address;
  final String userId;
  final String customerLevelId;
  final String productId;

  CreateCustomerRequest({
    required this.dbConnection,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    this.whatsappNo,
    this.gstNo,
    required this.address,
    required this.userId,
    required this.customerLevelId,
    required this.productId,
  });

  Map<String, dynamic> toJson() => {
        'dbconnection': dbConnection,
        'customer_name': customerName,
        'email': email,
        'mobile_no': mobileNo,
        'whatsapp_no': whatsappNo,
        'gst_no': gstNo,
        'address': address,
        'user_id': userId,
        'customer_level_id': customerLevelId,
        'product_id': productId,
      };
}

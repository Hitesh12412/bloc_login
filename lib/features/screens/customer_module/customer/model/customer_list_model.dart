class CustomerList {
  final int status;
  final List<CustomerModel> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  CustomerList({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory CustomerList.fromJson(Map<String, dynamic> json) {
    return CustomerList(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => CustomerModel.fromJson(e))
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

class CustomerModel {
  final int id;
  final String createdBy;
  final String updatedBy;
  final String branchId;
  final String productId;
  final String visitAreaId;
  final String customerName;
  final String email;
  final String mobileNo;
  final String whatsappNo;
  final String customerCompanyName;
  final String gstNo;
  final String address;
  final String latitude;
  final String longitude;
  final int customerLevelId;
  final String status;
  final String checkInCheckOutStatus;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String customerLevelName;
  final List<ProductModel> products;

  CustomerModel({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.branchId,
    required this.productId,
    required this.visitAreaId,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.whatsappNo,
    required this.customerCompanyName,
    required this.gstNo,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.customerLevelId,
    required this.status,
    required this.checkInCheckOutStatus,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.customerLevelName,
    required this.products,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      createdBy: json['created_by']?.toString() ?? '',
      updatedBy: json['updated_by']?.toString() ?? '',
      branchId: json['branch_id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      visitAreaId: json['visit_area_id']?.toString() ?? '',
      customerName: json['customer_name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      customerCompanyName: json['customer_company_name'] ?? '',
      gstNo: json['gst_no'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      customerLevelId: json['customer_level_id'] is int
          ? json['customer_level_id']
          : int.tryParse(json['customer_level_id']?.toString() ?? '0') ?? 0,
      status: json['status']?.toString() ?? '',
      checkInCheckOutStatus: json['check_in_check_out_status']?.toString() ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      customerLevelName: json['customer_level_name'] ?? '',
      products: (json['products'] as List? ?? [])
          .map((e) => ProductModel.fromJson(e))
          .toList(),
    );
  }
}

class ProductModel {
  final int id;
  final String name;

  ProductModel({
    required this.id,
    required this.name,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

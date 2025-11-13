class VendorsList {
  final int status;
  final List<VendorData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  VendorsList({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory VendorsList.fromJson(Map<String, dynamic> json) {
    return VendorsList(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => VendorData.fromJson(e))
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

class VendorData {
  final int id;
  final int createdBy;
  final int updatedBy;
  final String branchId;
  final String productId;
  final String vendorName;
  final String vendorEmail;
  final String mobileNumber;
  final String whatsappNo;
  final String vendorCompanyName;
  final String gstNo;
  final int vendorLevelId;
  final String address;
  final String latitude;
  final String longitude;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String vendorLevelName;
  final String branchName;
  final String vendorTransactionDate;
  final List<VendorProduct> products;
  final String totalVendorPayment;
  final String totalGivenPayment;
  final String totalOutstandingPayment;

  VendorData({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.branchId,
    required this.productId,
    required this.vendorName,
    required this.vendorEmail,
    required this.mobileNumber,
    required this.whatsappNo,
    required this.vendorCompanyName,
    required this.gstNo,
    required this.vendorLevelId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.vendorLevelName,
    required this.branchName,
    required this.vendorTransactionDate,
    required this.products,
    required this.totalVendorPayment,
    required this.totalGivenPayment,
    required this.totalOutstandingPayment,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) {
    return VendorData(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      createdBy: json['created_by'] is int ? json['created_by'] : int.tryParse(json['created_by'].toString()) ?? 0,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : int.tryParse(json['updated_by'].toString()) ?? 0,
      branchId: json['branch_id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      vendorName: json['vendor_name'] ?? '',
      vendorEmail: json['vendor_email'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      vendorCompanyName: json['vendor_company_name'] ?? '',
      gstNo: json['gst_no'] ?? '',
      vendorLevelId: json['vendor_level_id'] is int ? json['vendor_level_id'] : int.tryParse(json['vendor_level_id'].toString()) ?? 0,
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      vendorLevelName: json['vendor_level_name'] ?? '',
      branchName: json['branch_name'] ?? '',
      vendorTransactionDate: json['vendor_transaction_date'] ?? '',
      products: (json['products'] as List? ?? [])
          .map((e) => VendorProduct.fromJson(e))
          .toList(),
      totalVendorPayment: json['totalVendorPayment']?.toString() ?? '0',
      totalGivenPayment: json['totalGivenPayment']?.toString() ?? '0',
      totalOutstandingPayment: json['totalOutstandingPayment']?.toString() ?? '0',
    );
  }
}

class VendorProduct {
  final int id;
  final String name;

  VendorProduct({
    required this.id,
    required this.name,
  });

  factory VendorProduct.fromJson(Map<String, dynamic> json) {
    return VendorProduct(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
    );
  }
}

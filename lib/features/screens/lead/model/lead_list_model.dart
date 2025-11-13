class LeadList {
  final int status;
  final List<LeadModel> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  LeadList({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory LeadList.fromJson(Map<String, dynamic> json) {
    return LeadList(
      status: json['status'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => LeadModel.fromJson(e))
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

class LeadModel {
  final int id;
  final String leadCategoryId;
  final String leadCategoryName;
  final String leadSubCategoryName;
  final String leadName;
  final String leadNo;
  final String branchName;
  final String status;
  final String billingAddress;
  final int employeeId;
  final String employeeName;
  final String customerName;
  final String email;
  final String mobileNo;
  final String createdAt;
  final String grandTotal;
  final String statusName;
  final String statusTextColor;
  final String statusBgColor;
  final List<TermsAndCondition> termsAndConditionList;

  LeadModel({
    required this.id,
    required this.leadCategoryId,
    required this.leadCategoryName,
    required this.leadSubCategoryName,
    required this.leadName,
    required this.leadNo,
    required this.branchName,
    required this.status,
    required this.billingAddress,
    required this.employeeId,
    required this.employeeName,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.createdAt,
    required this.grandTotal,
    required this.statusName,
    required this.statusTextColor,
    required this.statusBgColor,
    required this.termsAndConditionList,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'] ?? 0,
      leadCategoryId: json['lead_category_id'] ?? '',
      leadCategoryName: json['lead_category_name'] ?? '',
      leadSubCategoryName: json['lead_sub_category_name'] ?? '',
      leadName: json['lead_name'] ?? '',
      leadNo: json['lead_no'] ?? '',
      branchName: json['branch_name'] ?? '',
      status: json['status'] ?? '',
      billingAddress: json['billing_address'] ?? '',
      employeeId: json['employee_id'] is int
          ? json['employee_id']
          : int.tryParse(json['employee_id'].toString()) ?? 0,
      employeeName: json['employeeName'].toString(),
      customerName: json['customer_name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      createdAt: json['created_at'] ?? '',
      grandTotal: json['grand_total'].toString(),
      statusName: json['status_name'] ?? '',
      statusTextColor: json['status_text_color'] ?? '',
      statusBgColor: json['status_bgcolor'] ?? '',
      termsAndConditionList: (json['termsAndConditionList'] as List? ?? [])
          .map((e) => TermsAndCondition.fromJson(e))
          .toList(),
    );
  }
}

class TermsAndCondition {
  final int id;
  final String title;
  final String description;

  TermsAndCondition({
    required this.id,
    required this.title,
    required this.description,
  });

  factory TermsAndCondition.fromJson(Map<String, dynamic> json) {
    return TermsAndCondition(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

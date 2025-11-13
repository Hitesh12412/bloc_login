class KycListModel {
  final int status;
  final List<KycData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  KycListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'],
        data = List<KycData>.from(json['data'].map((e) => KycData.fromJsonMap(e))),
        totalPages = json['totalPages'],
        totalCount = json['totalCount'],
        pageNumber = json['pageNumber'],
        hasNextPage = json['hasNextPage'],
        hasPreviousPage = json['hasPreviousPage'],
        message = json['message'];
}

class KycData {
  final int id;
  final int employeeId;
  final int createdBy;
  final int updatedBy;
  final String documentType;
  final String documentNo;
  final String fullName;
  final String documentUpload;
  final String fileSize;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  KycData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        employeeId = json['employee_id'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        documentType = json['document_type'],
        documentNo = json['document_no'],
        fullName = json['full_name'],
        documentUpload = json['document_upload'],
        fileSize = json['file_size'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];
}

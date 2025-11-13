class ExperienceListModel {
  final int status;
  final List<ExperienceData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  ExperienceListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'],
        data = List.from(json['data']).map((e) => ExperienceData.fromJsonMap(e)).toList(),
        totalPages = json['totalPages'],
        totalCount = json['totalCount'],
        pageNumber = json['pageNumber'],
        hasNextPage = json['hasNextPage'],
        hasPreviousPage = json['hasPreviousPage'],
        message = json['message'];
}

class ExperienceData {
  final int id;
  final int employeeId;
  final int createdBy;
  final int updatedBy;
  final String companyName;
  final String joiningDate;
  final String endDate;
  final String documentUpload;
  final String fileSize;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  ExperienceData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        employeeId = json['employee_id'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        companyName = json['company_name'],
        joiningDate = json['joining_date'],
        endDate = json['end_date'],
        documentUpload = json['document_upload'],
        fileSize = json['file_size'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];
}

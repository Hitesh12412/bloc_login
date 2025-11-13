class AwardListModel {
  final int status;
  final List<AwardData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  AwardListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'],
        data = List.from(json['data']).map((e) => AwardData.fromJsonMap(e)).toList(),
        totalPages = json['totalPages'],
        totalCount = json['totalCount'],
        pageNumber = json['pageNumber'],
        hasNextPage = json['hasNextPage'],
        hasPreviousPage = json['hasPreviousPage'],
        message = json['message'];
}

class AwardData {
  final int id;
  final int employeeId;
  final int createdBy;
  final int updatedBy;
  final String name;
  final String yearOfReceivingAward;
  final String description;
  final String documentUpload;
  final String fileSize;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  AwardData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        employeeId = json['employee_id'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        name = json['name'],
        yearOfReceivingAward = json['year_of_receiving_award'],
        description = json['description'],
        documentUpload = json['document_upload'],
        fileSize = json['file_size'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];
}

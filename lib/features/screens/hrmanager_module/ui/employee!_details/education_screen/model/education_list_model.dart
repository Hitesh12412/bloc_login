class EducationListModel {
  final int status;
  final List<EducationListData> data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  EducationListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'],
        data = List.from(json['data']).map((e) => EducationListData.fromJsonMap(e)).toList(),
        totalPages = json['totalPages'],
        totalCount = json['totalCount'],
        pageNumber = json['pageNumber'],
        hasNextPage = json['hasNextPage'],
        hasPreviousPage = json['hasPreviousPage'],
        message = json['message'];
}

class EducationListData {
  final int id;
  final int employeeId;
  final int createdBy;
  final int updatedBy;
  final String school_collage_name;
  final String year_of_joining;
  final String year_of_reliving;
  final String documentUpload;
  final String fileSize;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  EducationListData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        employeeId = json['employee_id'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        school_collage_name = json['school_collage_name'],
        year_of_joining = json['year_of_joining'],
        year_of_reliving = json['year_of_reliving'],
        documentUpload = json['document_upload'],
        fileSize = json['file_size'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];
}

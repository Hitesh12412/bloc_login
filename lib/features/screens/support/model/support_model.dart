class SupportResponse {
  final int status;
  final SupportData data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  SupportResponse({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.totalCount,
    required this.pageNumber,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.message,
  });

  factory SupportResponse.fromJson(Map<String, dynamic> json) {
    return SupportResponse(
      status: json['status'] ?? 0,
      data: SupportData.fromJson(json['data'] ?? {}),
      totalPages: json['totalPages'] ?? 1,
      totalCount: json['totalCount'] ?? 0,
      pageNumber: json['pageNumber'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class SupportData {
  final UserData userData;
  final List<SupportItem> supportListData;

  SupportData({
    required this.userData,
    required this.supportListData,
  });

  factory SupportData.fromJson(Map<String, dynamic> json) {
    return SupportData(
      userData: UserData.fromJson(json['userData'] ?? {}),
      supportListData: (json['supportListData'] as List? ?? [])
          .map((e) => SupportItem.fromJson(e))
          .toList(),
    );
  }
}

class UserData {
  final int id;
  final String userName;
  final String companyName;
  final String email;
  final String address;
  final String countryId;
  final String stateId;
  final String cityId;
  final String gstNo;
  final String mobileNo;
  final String countryName;
  final String stateName;
  final String cityName;

  UserData({
    required this.id,
    required this.userName,
    required this.companyName,
    required this.email,
    required this.address,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.gstNo,
    required this.mobileNo,
    required this.countryName,
    required this.stateName,
    required this.cityName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      userName: json['user_name'] ?? '',
      companyName: json['company_name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      countryId: json['country_id'].toString(),
      stateId: json['state_id'].toString(),
      cityId: json['city_id'].toString(),
      gstNo: json['gst_no'] ?? '',
      mobileNo: json['mobileno'] ?? '',
      countryName: json['country_name'] ?? '',
      stateName: json['state_name'] ?? '',
      cityName: json['city_name'] ?? '',
    );
  }
}

class SupportItem {
  final int id;
  final String moduleId;
  final String moduleName;
  final String description;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String statusName;
  final List<Media> media;

  SupportItem({
    required this.id,
    required this.moduleId,
    required this.moduleName,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.statusName,
    required this.media,
  });

  factory SupportItem.fromJson(Map<String, dynamic> json) {
    return SupportItem(
      id: json['id'] ?? 0,
      moduleId: json['module_id'].toString(),
      moduleName: json['module_name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      statusName: json['status_name'] ?? '',
      media: (json['media'] as List? ?? [])
          .map((e) => Media.fromJson(e))
          .toList(),
    );
  }
}

class Media {
  final int id;
  final String media;
  final String mediaType;

  Media({
    required this.id,
    required this.media,
    required this.mediaType,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] ?? 0,
      media: json['media'] ?? '',
      mediaType: json['media_type'] ?? '',
    );
  }
}

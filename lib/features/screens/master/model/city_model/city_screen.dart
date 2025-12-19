class CityListModel {
  final int status;
  final List<CityData> data;
  final String message;

  CityListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'] ?? 200,
        data = (json['data'] as List<dynamic>? ?? [])
            .map((e) => CityData.fromJsonMap(e))
            .toList(),
        message = json['message'] ?? '';
}

class CityData {
  final int id;
  final String name;
  final int stateId;
  final String stateCode;
  final String countryCode;

  CityData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        stateId = json['state_id'] ?? 0,
        stateCode = json['state_code'] ?? '',
        countryCode = json['country_code'] ?? '';
}

class StateListModel {
  final int status;
  final List<StateData> data;
  final String message;

  StateListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'] ?? 200,
        data = (json['data'] as List<dynamic>? ?? [])
            .map((e) => StateData.fromJsonMap(e))
            .toList(),
        message = json['message'] ?? '';
}

class StateData {
  final int id;
  final String name;
  final int countryId;
  final String countryCode;

  StateData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        countryId = json['country_id'] ?? 0,
        countryCode = json['country_code'] ?? '';
}

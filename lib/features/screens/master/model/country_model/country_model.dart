class CountryListModel {
  final int status;
  final List<CountryData> data;
  final String message;

  CountryListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'] ?? 200,
        data = (json['data'] as List<dynamic>? ?? [])
            .map((e) => CountryData.fromJsonMap(e))
            .toList(),
        message = json['message'] ?? '';
}

class CountryData {
  final int id;
  final String name;
  final String iso2;
  final String phoneCode;
  final String emoji;

  CountryData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        iso2 = json['iso2'] ?? '',
        phoneCode = json['phonecode'] ?? '',
        emoji = json['emoji'] ?? '';
}

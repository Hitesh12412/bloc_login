import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/award_screen/model/award_list_model/award_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AwardRepository {
  static const String _baseUrl = 'https://shiserp.com/demo/api/getAwardList';

  Future<AwardListModel> fetchAwards({
    required int employeeId,
    required String dbConnection,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'employee_id': employeeId.toString(),
      'db_connection': dbConnection,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return AwardListModel.fromJsonMap(jsonBody);
    } else {
      throw Exception('Failed to load Awards');
    }
  }
}

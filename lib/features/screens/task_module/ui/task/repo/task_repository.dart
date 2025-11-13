import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/education_screen/model/education_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EducationRepository {
  static const String _baseUrl = 'https://shiserp.com/demo/api/taskList';

  Future<EducationListModel> fetchEducations({
    required int userId,
    required String dbConnection,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'user_id': userId.toString(),
      'db_connection': dbConnection,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return EducationListModel.fromJsonMap(jsonBody);
    } else {
      throw Exception('Failed to load Educations');
    }
  }
}

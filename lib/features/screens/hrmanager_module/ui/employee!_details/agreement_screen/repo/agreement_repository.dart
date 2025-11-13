import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/model/agreement_list_model/agreement_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AgreementRepository {
  static const String _baseUrl = 'https://shiserp.com/demo/api/getAgreementList';

  Future<AgreementListModel> fetchAgreements({
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
      return AgreementListModel.fromJsonMap(jsonBody);
    } else {
      throw Exception('Failed to load agreements');
    }
  }
}

import 'dart:convert';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employeescreen/model/employee_model.dart';
import 'package:http/http.dart' as http;

class EmployeeService {

  final String _url = "https://shiserp.com/demo/api/employeeList";


  Future<Map<String, dynamic>> getEmployees({int page = 1, int pageSize = 8}) async{
    try {
      final response = await http.post(
        Uri.parse(_url),
        body: {
          "search_text": "",
          "page_number": "$page",
          "page_size": "$pageSize",
          "user_id": "1",
          "db_connection": "erp_tata_steel_demo"
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final data = jsonData['data'] ?? {};
        final employeeList = data['employeeList'] ?? [];
        final totalPendingSalary = data['total_pending_salary'] ?? "0";
        return {
          "employees": (employeeList as List)
              .map((e) => Employee.fromJson(e as Map<String, dynamic>))
              .toList(),
          "pendingSalary": double.tryParse(totalPendingSalary.toString()) ?? 0.0,
        };
      } else {
        throw Exception('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

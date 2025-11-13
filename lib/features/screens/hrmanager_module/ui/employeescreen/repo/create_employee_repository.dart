import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CreateEmployeeRepository {
  final String baseUrl = 'https://shiserp.com/demo/api';

  Future<bool> createEmployee({
    required String name,
    required String designation,
    required String dateOfBirth,
    required String dateOfJoining,
    required String email,
    required String mobileNo,
    required String employeeCode,
    File? profilePicture,
  }) async {
    final uri = Uri.parse('$baseUrl/createEmployee');
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['designation'] = designation;
    request.fields['date_of_birth'] = dateOfBirth;
    request.fields['date_of_joining'] = dateOfJoining;
    request.fields['email'] = email;
    request.fields['mobile_no'] = mobileNo;
    request.fields['employee_code'] = employeeCode;

    if (profilePicture != null) {
      request.files.add(await http.MultipartFile.fromPath('profile_picture', profilePicture.path));
    }

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    print('API Response: $responseString');

    if (response.statusCode == 200) {
      final jsonResp = json.decode(responseString);
      if (jsonResp['status'] == 200) {
        return true;
      } else {
        throw Exception(jsonResp['message'] ?? 'Failed to create employee');
      }
    } else {
      throw Exception('Failed to create employee: HTTP ${response.statusCode}');
    }
  }
}

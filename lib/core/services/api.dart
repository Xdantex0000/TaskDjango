import 'dart:convert';
import 'package:tasks/core/models/company.dart';
import 'package:tasks/core/models/task.dart';
import 'package:tasks/core/models/user.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://testenglish.spdns.eu';

  var client = new http.Client();

  void helpPrint(var response) {
    print('statusCode : ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      print('response body : ${response.body}');
      try {
        json.decode(response.body);
        print('trying to decode  Respose Body result is : success');
      } catch (Ex) {
        print("Exepition with json decode : $Ex");
      }
    }
  }

  Future<List<Company>> getAllCompanies() async {
    List<Company> result = List<Company>();

    var response = await client.get('$endpoint/api/company/');
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var company in parsed) {
      result.add(Company.fromJson(company));
    }
    return result;
  }

  Future<List<Task>> getTasksByCompany(String companyName) async {
    List<Task> result = List<Task>();
    var response = await client.get(
      'https://testenglish.spdns.eu/api/task/?company=$companyName',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    helpPrint(response);
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var task in parsed) {
      result.add(Task.fromJson(task));
    }
    return result;
  }

  Future<User> getUserProfile(String name, String password) async {
    // Get user profile for id
    var response = await client.post(
      '$endpoint/api/token/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': name,
          'password': password,
        },
      ),
    );
    helpPrint(response);
    var parsed = json.decode(response.body) as Map<String, dynamic>;
    // Convert and return
    return User.fromJson(parsed);
  }
}

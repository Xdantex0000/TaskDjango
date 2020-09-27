import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:tasks/core/models/company.dart';
import 'package:tasks/core/models/task.dart';
import 'package:tasks/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:tasks/core/services/store_service.dart';
import 'package:tasks/locator.dart';

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://testenglish.spdns.eu';

  var client = new http.Client();
  final StorageService _storage = locator<StorageService>();

  var header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

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

  Future<bool> refreshToken(String token) async {
    var response = await client.post(
      '$endpoint/api/token/refresh/',
      body: jsonEncode(
        {'refresh': token},
      ),
      headers: header,
    );
    helpPrint(response);
    if (response.statusCode == 200) {
      var parsed = json.decode(response.body);
      await _storage.setNewTokenPair(parsed['access'], token);
      return true;
    } else {
      return false;
    }
  }

  Map<String, String> addAuthCookie(User user) {
    return <String, String>{
      'Authorization': 'Bearer ${user.acces}',
      'Content-Type': 'application/json; charset=UTF-8'
    };
  }

  Future<String> sendSolution(String text, User user) async {
    print(addAuthCookie(user));
    var response = await client.post(
      '$endpoint/api/solution/',
      headers: addAuthCookie(user),
      body: jsonEncode({'programText': text}),
    );
    helpPrint(response);
    var parsed = json.decode(response.body) as Map<String, dynamic>;
    return parsed.toString();
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
      '$endpoint/api/task/?company=$companyName',
      headers: header,
    );
    helpPrint(response);
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var task in parsed) {
      result.add(Task.fromJson(task));
    }
    return result;
  }

  Future<Map<String, dynamic>> getUserProfile(
      String name, String password) async {
    // Get user profile for id
    var response = await client.post(
      '$endpoint/api/token/',
      headers: header,
      body: jsonEncode(
        <String, String>{
          'username': name,
          'password': password,
        },
      ),
    );
    helpPrint(response);
    if (response.statusCode == 200) {
      var parsed = json.decode(response.body) as Map<String, dynamic>;
      // Convert and return
      return parsed;
    } else {
      return {'details': 'server error'};
    }
  }

  Future<Map<String, dynamic>> registerUser(
      String name, String password) async {
    // Get user profile for id
    var response = await client.post(
      '$endpoint/api/register/',
      headers: header,
      body: jsonEncode(
        <String, String>{
          'username': name,
          'password': password,
        },
      ),
    );
    helpPrint(response);

    if (response.statusCode == 200) {
      var parsed = json.decode(response.body) as Map<String, dynamic>;
      // Convert and return
      return parsed;
    } else {
      return {'details': 'server error'};
    }
  }
}

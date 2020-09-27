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
  StorageService _storage = locator<StorageService>();

  var header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  //help function
  // returns default header with authorization
  Map<String, String> addAuthCookie(String token) {
    return <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8'
    };
  }

  //function tries to refresh tiken and resend request
  Future<Map<String, dynamic>> tryRefresh(http.Response response) async {
    var parsed = json.decode(response.body) as Map<String, dynamic>;
    if (parsed.containsKey('code')) {
      // tries to refresh tokens, on succes resends request
      //outherway returns empty dict
      if (parsed['code'] == 'token_not_valid') {
        String refresh = await _storage.getRefreshToken();
        Map<String, dynamic> info = await refreshToken(refresh);
        if (info.length != 0 && !info.containsKey('error')) {
          await _storage.setNewTokenPair(info['access'], info['refresh']);
          return <String, dynamic>{'message': info['access'], 'status': true};
        }
        return <String, dynamic>{'message': info['error'], 'status': false};
      }
      return <String, dynamic>{
        'message': 'problem not in refresh',
        'status': false
      };
    }
  }

  // prints response
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

  //get user ptofile info
  Future<Map<String, dynamic>> getProfile(String token) async {
    var response = await client.get(
      '$endpoint/api/userData/',
      headers: addAuthCookie(token),
    );
    helpPrint(response);
    if (response.statusCode == 200) {
      var parsed = json.decode(response.body) as Map<String, dynamic>;
      return parsed;
    } else if (response.statusCode == 401) {
      var result = await tryRefresh(response);
      if (result['status']) {
        return await getProfile(result['message']);
      } else {
        return <String, dynamic>{
          'error': result['message'],
        };
      }
    }
    return <String, dynamic>{
      'error': response.body.toString(),
    };
  }

  // sends logout request
  Future<bool> logout(String token) async {
    var response = await client.post(
      '$endpoint/api/token/logout/',
      headers: header,
      body: jsonEncode(
        {'refresh': token},
      ),
    );
    helpPrint(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //sends reuest to update tokens
  // on success return map with access and refresh tokens adnd user profile info
  // outherway return empty dict
  Future<Map<String, dynamic>> refreshToken(String token) async {
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
      return parsed;
    } else {
      return <String, dynamic>{
        'error': response.body.toString(),
      };
    }
  }

  // uploads solution to the server
  Future<Map<String, dynamic>> sendSolution(String text) async {
    String access = await _storage.getAccessToken();
    var response = await client.post(
      '$endpoint/api/solution/',
      headers: addAuthCookie(access),
      body: jsonEncode({'programText': text}),
    );
    helpPrint(response);
    //if response status code is 200, just return response body
    if (response.statusCode == 200) {
      var parsed = json.decode(response.body) as Map<String, dynamic>;
      return parsed;
      // if response code 401, checks if token was expired
    } else if (response.statusCode == 401) {
      var result = await tryRefresh(response);
      if (result['status']) {
        return await sendSolution(text);
      } else {
        return <String, dynamic>{
          'error': result['message'],
        };
      }
    }
    return <String, dynamic>{
      'error': response.body.toString(),
    };
  }

  // get all companies
  Future<List<Company>> getAllCompanies() async {
    List<Company> result = List<Company>();

    var response = await client.get('$endpoint/api/company/');
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var company in parsed) {
      result.add(Company.fromJson(company));
    }
    return result;
  }

  // gets all tasks from one company
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

  // sends login request
  // on success return response body
  Future<Map<String, dynamic>> login(String name, String password) async {
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

  // register user
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

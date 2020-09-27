import 'dart:async';

import 'package:tasks/core/models/user.dart';
import 'package:tasks/core/services/store_service.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  Api _api = locator<Api>();
  final StorageService _storage = locator<StorageService>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> getProfile(String token) async {
    Map<String, dynamic> user = await _api.getProfile(token);
    if (user.length != 0) {
      userController.add(User.fromJson(user));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var tokens = await _storage.checkTokens();
    print(tokens.toString());
    if (tokens.containsKey('access') && tokens.containsKey('refresh')) {
      var result = await _api.refreshToken(tokens['refresh']);
      if (result.length != 0) {
        await _storage.setNewTokenPair(result['access'], result['refresh']);
        var user = await _api.getProfile(result['access']);
        if (user.length != 0) {
          userController.add(User.fromJson(user));
          return true;
        }
      }
    }
    return false;
  }

  Future<String> login(String name, String password) async {
    var fetchedUser = await _api.login(name, password);
    var result;
    if (fetchedUser.containsKey('details')) {
      result = fetchedUser['details'].toString();
    } else {
      await _storage.setNewTokenPair(
          fetchedUser['access'], fetchedUser['refresh']);
      var user = await _api.getProfile(fetchedUser['access']);
      if (user.containsKey('error')) {
        return user['error'];
      } else {
        result = 'OK';
        userController.add(User.fromJson(fetchedUser));
        return result;
      }
    }

    return result;
  }

  Future<String> register(
    String name,
    String password,
  ) async {
    var fetchedUser = await _api.registerUser(name, password);
    String result;
    if (fetchedUser.containsKey('detail')) {
      result = fetchedUser['details'];
    } else {
      result = 'OK';
      userController.add(User.fromJson(fetchedUser));
    }

    return result;
  }
}

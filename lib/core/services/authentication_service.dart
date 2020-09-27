import 'dart:async';

import 'package:tasks/core/models/user.dart';
import 'package:tasks/core/services/store_service.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  Api _api = locator<Api>();
  final StorageService _storage = locator<StorageService>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> isUserLoggedIn() async {
    var tokens = await _storage.checkTokens();
    print(tokens.toString());
    if (tokens.containsKey('access') && tokens.containsKey('refresh')) {
      bool check = await _api.refreshToken(tokens['refresh']);
      return check;
    }
    return false;
  }

  Future<String> login(String name, String password) async {
    var fetchedUser = await _api.getUserProfile(name, password);
    var result;
    if (fetchedUser.containsKey('details')) {
      result = fetchedUser['details'].toString();
    } else {
      result = 'OK';
      await _storage.setNewTokenPair(
          fetchedUser['access'], fetchedUser['refresh']);
      userController.add(User.fromJson(fetchedUser));
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

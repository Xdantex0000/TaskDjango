import 'dart:async';

import 'package:tasks/core/models/user.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(String name, String password) async {
    var fetchedUser = await _api.getUserProfile(name, password);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      userController.add(fetchedUser);
    }

    return hasUser;
  }
}

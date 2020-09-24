import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/services/authentication_service.dart';
import 'package:tasks/core/viewmodels/base_model.dart';

import '../../locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String input_name, String input_password) async {
    setState(ViewState.Busy);

    var name = input_name;
    var password = input_password;

    // Not a number
    if (name == null || password == null) {
      errorMessage = 'Value entered is not a number';
      setState(ViewState.Idle);
      return false;
    }

    var success = await _authenticationService.login(name, password);

    // Handle potential error here too.

    setState(ViewState.Idle);
    return success;
  }
}

import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/services/authentication_service.dart';
import 'package:tasks/core/viewmodels/base_model.dart';

import '../../locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String inputName, String inputPassword) async {
    setState(ViewState.Busy);

    var name = inputName;
    var password = inputPassword;

    // Not a number
    if (name == '' || password == '') {
      errorMessage = 'all fields must be filled';
      setState(ViewState.Idle);
      return false;
    }

    var success = await _authenticationService.login(name, password);

    if (success != 'OK') {
      errorMessage = success;
      setState(ViewState.Idle);
      return false;
    }
    // Handle potential error here too.
    setState(ViewState.Idle);
    return true;
  }
}

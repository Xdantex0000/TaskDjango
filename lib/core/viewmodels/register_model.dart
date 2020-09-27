import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/services/authentication_service.dart';
import 'package:tasks/core/viewmodels/base_model.dart';
import 'package:tasks/locator.dart';

class RegisterModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  String errorMessage;

  Future<bool> register(
      String name, String password, String repeatPassword) async {
    setState(ViewState.Busy);
    if (name == null || password == null || repeatPassword == null) {
      errorMessage = 'fill required fields';
      setState(ViewState.Idle);
      return false;
    }
    if (password != repeatPassword) {
      errorMessage = 'passwords are not same';
      setState(ViewState.Idle);
      return false;
    }

    var success = await _authenticationService.register(name, password);

    if (success != "OK") {
      errorMessage = success;
      setState(ViewState.Idle);

      return false;
    }
    // Handle potential error here too.

    setState(ViewState.Idle);
    return true;
  }
}

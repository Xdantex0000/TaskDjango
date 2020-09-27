import 'package:flutter/cupertino.dart';
import 'package:tasks/core/services/authentication_service.dart';
import 'package:tasks/core/services/store_service.dart';
import 'package:tasks/core/viewmodels/base_model.dart';
import 'package:tasks/locator.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final StorageService _storage = locator<StorageService>();

  Future handleStartUpLogic(BuildContext context) async {
    // Register for push notifications
    // await _pushNotificationService.initialise();

    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    print(hasLoggedInUser);
    if (hasLoggedInUser) {
      Navigator.pushNamed(context, '/');
      // _navigationService.navigateTo(HomeViewRoute);
    } else {
      Navigator.pushNamed(context, 'login/');
      // _navigationService.navigateTo(LoginViewRoute);
    }
  }
}

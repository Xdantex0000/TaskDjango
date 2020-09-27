import 'package:flutter/cupertino.dart';
import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/services/api.dart';
import 'package:tasks/core/services/store_service.dart';
import 'package:tasks/core/viewmodels/base_model.dart';
import 'package:tasks/locator.dart';

class ProfileViewModel extends BaseModel {
  Api _api = locator<Api>();
  StorageService _storage = locator<StorageService>();

  Future<bool> logout(BuildContext context) async {
    setState(ViewState.Busy);
    String token = await _storage.getRefreshToken();
    var check = await _api.logout(token);
    if (check) {
      _storage.deleteTokens();
      setState(ViewState.Idle);
      return true;
    } else {
      _storage.deleteTokens();
      setState(ViewState.Idle);
      return false;
    }
  }
}

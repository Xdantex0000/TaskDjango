import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/models/user.dart';
import 'package:tasks/core/services/api.dart';
import 'package:tasks/core/viewmodels/base_model.dart';
import 'package:tasks/locator.dart';

class TaskViewModel extends BaseModel {
  Api _api = locator<Api>();
  // Srting result = ''

  String result = '';
  Future<String> sendSolution(String solution, User user) async {
    setState(ViewState.Busy);
    result = await _api.sendSolution(solution, user);

    setState(ViewState.Idle);
    return result;
  }
}

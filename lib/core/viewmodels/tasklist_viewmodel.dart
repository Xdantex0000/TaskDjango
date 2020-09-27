import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/models/task.dart';
import 'package:tasks/core/services/api.dart';

import '../../locator.dart';
import 'base_model.dart';

class TaskListViewModel extends BaseModel {
  Api _api = locator<Api>();

  List<Task> tasks;

  Future fetchTasks(String companyName) async {
    setState(ViewState.Busy);
    tasks = await _api.getTasksByCompany(companyName);
    setState(ViewState.Idle);
  }
}

import 'package:get_it/get_it.dart';
import 'package:tasks/core/viewmodels/compamy_viewmodel.dart';

import 'core/services/api.dart';
import 'core/services/authentication_service.dart';
import 'core/viewmodels/task_viewmodel.dart';
import 'core/viewmodels/login_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());

  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => TaskListViewModel());
  locator.registerFactory(() => CompanyViewModel());
}

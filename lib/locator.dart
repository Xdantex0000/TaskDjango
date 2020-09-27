import 'package:get_it/get_it.dart';
import 'package:tasks/core/services/store_service.dart';
import 'package:tasks/core/viewmodels/compamy_viewmodel.dart';
import 'package:tasks/core/viewmodels/profile_viewmodel.dart';
import 'package:tasks/core/viewmodels/startup_viewmodel.dart';
import 'package:tasks/core/viewmodels/task_viewmodel.dart';

import 'core/services/api.dart';
import 'core/services/authentication_service.dart';
import 'core/viewmodels/tasklist_viewmodel.dart';
import 'core/viewmodels/login_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => StorageService());

  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => TaskListViewModel());
  locator.registerFactory(() => CompanyViewModel());
  locator.registerFactory(() => TaskViewModel());
  locator.registerFactory(() => StartUpViewModel());
  locator.registerFactory(() => ProfileViewModel());
}

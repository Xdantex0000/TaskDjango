import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/core/services/authentication_service.dart';
import 'package:tasks/locator.dart';
import 'package:tasks/ui/router.dart';
import 'package:tasks/ui/shared/theme.dart';

import 'core/models/user.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      create: (BuildContext context) =>
          locator<AuthenticationService>().userController.stream,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme,
        initialRoute: 'login',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

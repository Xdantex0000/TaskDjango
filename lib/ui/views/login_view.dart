import 'package:flutter/material.dart';
import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/viewmodels/login_model.dart';
import 'package:tasks/ui/shared/app_colors.dart';
import 'package:tasks/ui/widgets/login_header.dart';

import 'base_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginHeader(
              validationMessage: model.errorMessage,
              controller_name: _controllerName,
              controller_password: _controllerPassword,
            ),
            model.state == ViewState.Busy
                ? CircularProgressIndicator()
                : FlatButton(
                    color: Colors.white,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      var loginSuccess = await model.login(
                          _controllerName.text, _controllerPassword.text);
                      if (loginSuccess) {
                        Navigator.pushNamed(context, '/');
                      }
                    },
                  )
          ],
        ),
      ),
    );
  }
}

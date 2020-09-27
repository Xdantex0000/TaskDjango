import 'package:flutter/material.dart';
import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/viewmodels/login_viewmodel.dart';
import 'package:tasks/ui/shared/ui_helpers.dart';
import 'package:tasks/ui/widgets/login_header.dart';

import 'base_view.dart';

class LoginView extends StatefulWidget {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Text signUpText = Text(
    'sign up',
    style: TextStyle(color: Colors.white),
  );

  void redirectWasHooved(ch) {
    setState(
      () {
        final String text = 'sign up';
        if (ch) {
          signUpText = Text(
            text,
            style: TextStyle(decoration: TextDecoration.underline),
          );
        } else {
          signUpText = Text(
            text,
            // style: TextStyle(color: Colors.white),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginHeader(
              validationMessage: model.errorMessage,
              controller_name: widget._controllerName,
              controller_password: widget._controllerPassword,
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
                          widget._controllerName.text,
                          widget._controllerPassword.text);
                      if (loginSuccess) {
                        Navigator.pushNamed(context, '/');
                      }
                    },
                  ),
            UIHelper.verticalSpaceSmall(),
            InkWell(
              child: signUpText,
              onTap: () {
                Navigator.pushNamed(context, 'signup/');
              },
              onHover: (ch) {
                redirectWasHooved(ch);
              },
            )
          ],
        ),
      ),
    );
  }
}

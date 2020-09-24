import 'package:flutter/material.dart';
import 'package:tasks/ui/shared/text_styles.dart';
import 'package:tasks/ui/shared/ui_helpers.dart';

class LoginHeader extends StatelessWidget {
  final TextEditingController controller_name;
  final TextEditingController controller_password;

  final String validationMessage;

  LoginHeader(
      {@required this.controller_name,
      @required this.controller_password,
      this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Login', style: headerStyle),
      UIHelper.verticalSpaceMedium(),
      Text('Enter a number between 1 - 10', style: subHeaderStyle),
      LoginTextField(controller_name, 'login'),
      LoginTextField(controller_password, 'password'),
      this.validationMessage != null
          ? Text(validationMessage, style: TextStyle(color: Colors.red))
          : Container(),
    ]);
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String helpMsg;
  LoginTextField(this.controller, this.helpMsg);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: helpMsg),
        controller: controller,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

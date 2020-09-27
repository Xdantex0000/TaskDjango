import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/models/user.dart';
import 'package:tasks/core/viewmodels/profile_viewmodel.dart';
import 'package:tasks/ui/shared/text_styles.dart';
import 'package:tasks/ui/shared/ui_helpers.dart';
import 'package:tasks/ui/views/base_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome ${Provider.of<User>(context).username}',
                      style: headerStyle,
                    ),
                    UIHelper.horizontalSpaceMedium(),
                    model.state == ViewState.Busy
                        ? CircularProgressIndicator()
                        : FlatButton(
                            color: Colors.white,
                            child: Text(
                              'Logout',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () async {
                              bool check = await model.logout(context);
                              if (check) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  'login/',
                                  (r) => false,
                                );
                              }
                            },
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

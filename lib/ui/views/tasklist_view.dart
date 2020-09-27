import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/models/user.dart';
import 'package:tasks/core/viewmodels/tasklist_viewmodel.dart';
import 'package:tasks/ui/shared/app_colors.dart';
import 'package:tasks/ui/shared/text_styles.dart';
import 'package:tasks/ui/shared/ui_helpers.dart';
import 'package:tasks/ui/widgets/task/task_list.dart';

import 'base_view.dart';

class TaskListView extends StatelessWidget {
  final String company;
  TaskListView({this.company});

  @override
  Widget build(BuildContext context) {
    return BaseView<TaskListViewModel>(
      onModelReady: (model) => model.fetchTasks(company),
      builder: (context, model, child) => Scaffold(
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceLarge(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Welcome ${Provider.of<User>(context).username}',
                      style: headerStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child:
                        Text('Here are all companies', style: subHeaderStyle),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Expanded(
                    child: TaskList(tasks: model.tasks),
                  ),
                ],
              ),
      ),
    );
  }
}

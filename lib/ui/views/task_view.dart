import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/core/models/task.dart';
import 'package:tasks/core/models/user.dart';
import 'package:tasks/ui/shared/app_colors.dart';
import 'package:tasks/ui/shared/text_styles.dart';
import 'package:tasks/ui/shared/ui_helpers.dart';
import 'package:tasks/ui/widgets/app_drawer.dart';

class TaskView extends StatelessWidget {
  final Task task;
  TaskView({this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Text('${task.number.toString()} ${task.difficulty}',
                style: headerStyle),
            Text(
              'by ${task.company}',
              style: TextStyle(
                fontSize: 14.0,
                // color: Colors.white,
              ),
            ),
            UIHelper.verticalSpaceMedium(),
            Text(task.text),
            // Comments(post.id)
          ],
        ),
      ),
    );
  }
}

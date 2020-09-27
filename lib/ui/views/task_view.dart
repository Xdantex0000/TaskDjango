import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/core/enums/viewstate.dart';
import 'package:tasks/core/models/task.dart';
import 'package:tasks/core/models/user.dart';
import 'package:tasks/core/viewmodels/task_viewmodel.dart';
import 'package:tasks/ui/shared/text_styles.dart';
import 'package:tasks/ui/shared/ui_helpers.dart';
import 'package:tasks/ui/views/base_view.dart';
import 'package:tasks/ui/widgets/editor/editor.dart';

class TaskView extends StatelessWidget {
  final Task task;
  TaskView({this.task});

  @override
  Widget build(BuildContext context) {
    return BaseView<TaskViewModel>(
      builder: (context, model, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          // drawer: AppDrawer(),
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('task'),
                ),
                Tab(
                  child: Text('result'),
                ),
                // Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // fitst tab screen
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                    UIHelper.verticalSpaceMedium(),
                    Editor(task),
                    Align(
                      //Кнопка "Оформить заказ"
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: model.state == ViewState.Busy
                            ? CircularProgressIndicator()
                            : FlatButton(
                                color: Colors.white,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {
                                  model.sendSolution(
                                    task.solution,
                                    Provider.of<User>(context, listen: false),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              // second tab screen
              Text(task.result),
              // Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

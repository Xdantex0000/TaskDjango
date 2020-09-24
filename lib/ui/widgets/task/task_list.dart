import 'package:flutter/cupertino.dart';
import 'package:tasks/core/models/task.dart';
import 'package:tasks/ui/widgets/task/tasklist_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  TaskList({this.tasks});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) => TaskListItem(
        task: tasks[index],
        onTap: () {
          Navigator.pushNamed(context, 'task', arguments: tasks[index]);
        },
      ),
    );
  }
}

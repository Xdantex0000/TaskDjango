import 'package:flutter/material.dart';
import 'package:tasks/core/models/company.dart';
import 'package:tasks/core/models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final Function onTap;
  const TaskListItem({this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  color: Color.fromARGB(80, 0, 0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              task.number.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            Text(
              task.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

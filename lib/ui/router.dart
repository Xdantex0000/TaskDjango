import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasks/core/models/task.dart';
import 'package:tasks/ui/views/comapnies_page.dart';
import 'package:tasks/ui/views/edit_view.dart';
import 'package:tasks/ui/views/login_view.dart';
import 'package:tasks/ui/views/task_view.dart';
import 'package:tasks/ui/views/tasklist_view.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => CompanyListView());
      case 'editor':
        return MaterialPageRoute(builder: (_) => EditorView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'task':
        var task = settings.arguments as Task;
        return MaterialPageRoute(
          builder: (_) => TaskView(
            task: task,
          ),
        );
      case 'task_by_company':
        String companyName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => TaskListView(
            company: companyName,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

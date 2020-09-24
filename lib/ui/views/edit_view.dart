import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/ui/shared/ui_helpers.dart';
import 'package:tasks/ui/widgets/editor/editor.dart';

class EditorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('editor'),
        // ),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UIHelper.verticalSpaceLarge(),
          Expanded(
            child: Editor(),
          ),
        ],
      ),
    )
        // Editor(),
        );
  }
}

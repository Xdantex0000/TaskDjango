import 'package:code_editor/code_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasks/core/models/task.dart';

class Editor extends StatelessWidget {
  final Task task;
  Editor(this.task);
  @override
  Widget build(BuildContext context) {
    List<String> contentOfPage1 = [
      "def main():",
      "\tpass",
      "",
      "",
      "if __name__ == '__main__':",
      "\tmain()",
    ];

    List<FileEditor> files = [
      new FileEditor(
        name: "main.py",
        language: "python",
        code: contentOfPage1.join("\n"),
      ),
    ];

    EditorModel model = new EditorModel(
      files: files,
      styleOptions: new EditorModelStyleOptions(
        fontSize: 13,
      ),
    );

    return SingleChildScrollView(
      child: CodeEditor(
        model: model,
        onSubmit: (String language, String value) {
          print("language = $language");
          print("value = '$value'");
          task.solution = value;
        },
      ),
    );
  }
}

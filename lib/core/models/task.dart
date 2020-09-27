class Task {
  int number;
  String company;
  String text;
  String difficulty;
  String solution = '';
  String result = '';

  Task({this.company, this.number, this.difficulty, this.text, this.solution});
  Task.fromJson(Map<String, dynamic> json) {
    this.company = json['company'];
    this.difficulty = json['difficulty'];
    this.number = json['number'];
    this.text = json['taskText'];
  }
}

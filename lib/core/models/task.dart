class Task {
  int number;
  String company;
  String text;
  String difficulty;

  Task({this.company, this.number, this.difficulty, this.text});
  Task.fromJson(Map<String, dynamic> json) {
    this.company = json['company'];
    this.difficulty = json['difficulty'];
    this.number = json['number'];
    this.text = json['taskText'];
  }
}

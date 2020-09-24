class Company {
  String name;

  Company({this.name});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

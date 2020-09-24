class User {
  String username;
  String acces;
  String refresh;
  User({this.username, this.acces, this.refresh});

  User.initial() : username = '';

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    acces = json['access'];
    refresh = json['refresh'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['username'] = this.username;
  //   return data;
  // }
}

import 'package:flutter/cupertino.dart';

class User {
  String username;

  User({
    @required this.username,
  });

  User.initial() : username = '';

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['username'] = this.username;
  //   return data;
  // }
}

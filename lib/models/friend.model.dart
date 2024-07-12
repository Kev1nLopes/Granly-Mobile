import 'package:intl/intl.dart';


class Friend {
  int? id;
  String? username;
  String? email;
  String? code;
  String? nativeLanguage;
  String? lastAccessToken;
  String? createdAt;
  String? updatedAt;

  Friend(
      {this.id,
      this.username,
      this.email,
      this.code,
      this.nativeLanguage,
      this.lastAccessToken,
      this.createdAt,
      this.updatedAt});

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    code = json['code'];
    nativeLanguage = json['native_language'];
    lastAccessToken = json['last_access_token'];
    createdAt = DateFormat('dd/MM/yyyy').format(DateTime.parse(json['created_at']));
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['code'] = this.code;
    data['native_language'] = this.nativeLanguage;
    data['last_access_token'] = this.lastAccessToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
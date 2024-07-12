class AuthUser {
  User? user;
  bool? pinValid;
  String? token;

  AuthUser({this.user, this.pinValid, this.token});

  AuthUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    pinValid = json['pinValid'];
    token = json['token'] ?? json['last_access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['pinValid'] = this.pinValid;
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  Null? updatedAt;

  User({this.id, this.username, this.email, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
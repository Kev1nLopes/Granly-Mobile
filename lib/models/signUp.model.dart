class SignUp {
  String? message;
  bool? hasAccount;
  String? username;

  SignUp({this.message, this.hasAccount, this.username});

  SignUp.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    hasAccount = json['hasAccount'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['hasAccount'] = this.hasAccount;
    data['username'] = this.username;
    return data;
  }
}
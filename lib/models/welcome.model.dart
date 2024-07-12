class Welcome {
  String? message;
  bool? hasAccount;
  String? username;

  Welcome({this.message, this.hasAccount, this.username});

  Welcome.fromJson(Map<String, dynamic> json) {
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
class Message {
  int? id;
  String? message;
  Null? messageTranslate;
  Null? messageTranslateLanguage;
  bool? read;
  bool? visible;
  Null? readAt;
  String? createdat;
  Author? author;
  Author? signatario;

  Message(
      {this.id,
      this.message,
      this.messageTranslate,
      this.messageTranslateLanguage,
      this.read,
      this.visible,
      this.readAt,
      this.createdat,
      this.author,
      this.signatario});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    messageTranslate = json['message_translate'];
    messageTranslateLanguage = json['message_translate_language'];
    read = json['read'];
    visible = json['visible'];
    readAt = json['read_at'];
    createdat = json['createdat'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    signatario = json['signatario'] != null
        ? new Author.fromJson(json['signatario'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['message_translate'] = this.messageTranslate;
    data['message_translate_language'] = this.messageTranslateLanguage;
    data['read'] = this.read;
    data['visible'] = this.visible;
    data['read_at'] = this.readAt;
    data['createdat'] = this.createdat;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.signatario != null) {
      data['signatario'] = this.signatario!.toJson();
    }
    return data;
  }

  Message.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    message = map['message'];
    messageTranslate = map['message_translate'];
    messageTranslateLanguage = map['message_translate_language'];
    read = map['read'];
    visible = map['visible'];
    readAt = map['read_at'];
    createdat = map['createdat'];
    author = map['author'] != null ? new Author.fromMap(map['author']) : null;
    signatario = map['signatario'] != null
        ? Author.fromMap(map['signatario'])
        : null;
  }
}

class Author {
  int? id;
  String? username;
  String? email;
  String? createdAt;

  Author({this.id, this.username, this.email, this.createdAt});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['created_at'];
  }

  Author.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    email = map['email'];
    createdAt = map['created_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    return data;
  }
}
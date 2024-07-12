


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpp/models/user.model.dart';

class UserController extends ChangeNotifier{
  String _username = "";
  String _email = "";
  AuthUser? _user;
  late SharedPreferences _prefs;
  var locale = {
    'token': ''
  };
  


  String get username => _username;
  String get email => _email;
  AuthUser? get user => _user;


  UserController(){
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

   _readLocale() async{
    final token = _prefs.getString('token') ?? '';
    print(token);
    locale['token'] = token;
    
    notifyListeners();
   }

   setLocaleToken(String token) async {
    await _prefs.clear();
    await _prefs.setString('token', token);
    await _readLocale();

   }


  void setUsername(String name){
    _username = name;
    notifyListeners();
  }


  void setEmail(String email){
    _email = email;
    notifyListeners();
  }  

  void setUser(AuthUser user) async{
    _user = user;
    await setLocaleToken(user.token!);
    notifyListeners();
  }


}
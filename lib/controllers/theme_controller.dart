import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier{
  
  static ThemeController instance = ThemeController();
  
  bool switchColor = false;
  changeTheme(){
    switchColor = !switchColor;
    notifyListeners();
  }


}
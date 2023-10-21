import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues{
  static ValueNotifier<bool> flagTheme = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagTask = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagTitle = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagCheckBox = ValueNotifier<bool>(false);
  static ValueNotifier<bool> flag_database = ValueNotifier<bool>(false);
  
  guardarValor(valor) async{
    flagTheme.value = valor;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('flagTheme', flagTheme.value);
  }

  leerValor() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    flagTheme.value = prefs.getBool('flagTheme') ?? false;
  }

  
}
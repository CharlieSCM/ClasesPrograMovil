import 'package:flutter/widgets.dart';
import 'package:login/screens/dashboard_screen.dart';

Map<String,WidgetBuilder> getRouters(){
  return{
    '/dash' : (BuildContext context) => DashboardScreen()
  };
}
import 'package:flutter/widgets.dart';

Map<String,WidgetBuilder> getRouters(){
  return{
    '/dash' : (BuildContext context) => DashboardScreen()
  };
}
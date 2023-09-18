import 'package:flutter/widgets.dart';
import 'package:login/screens/add_task.dart';
import 'package:login/screens/dashboard_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/task_scree.dart';

Map<String,WidgetBuilder> getRouters(){
  return{
    '/dash' : (BuildContext context) => DashboardScreen(),
    '/dash_log' : (BuildContext context) => LoginScreen(),
    '/task' : (BuildContext context) => TaskScreen(),
    '/add' : (BuildContext context) => AddTask()  
  };
}
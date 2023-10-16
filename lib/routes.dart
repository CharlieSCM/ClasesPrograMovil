import 'package:flutter/widgets.dart';
import 'package:login/screens/add_task.dart';
import 'package:login/screens/carrera_screen.dart';
import 'package:login/screens/dashboard_screen.dart';
import 'package:login/screens/detail_movie_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/popular_screen.dart';
import 'package:login/screens/porfesor_screen.dart';
import 'package:login/screens/provider_screen.dart';
import 'package:login/screens/task_scree.dart';
//import 'package:login/screens/calendar_screen.dart';

Map<String,WidgetBuilder> getRouters(){
  return{
    '/dash' : (BuildContext context) => DashboardScreen(),
    '/dash_log' : (BuildContext context) => LoginScreen(),
    '/task' : (BuildContext context) => TaskScreen(),
    '/add' : (BuildContext context) => AddTask(),
    '/popular' : (BuildContext context) => PopularScreen(),
    '/detail' :(BuildContext context) => DetailMovieScreenState(),
    '/prov' :(BuildContext context) => ProviderScreen(),
    '/profe' :(BuildContext context) => ProfesorScreen(),
    '/carrera' :(BuildContext context) => CarreraScreen(),
  };
}
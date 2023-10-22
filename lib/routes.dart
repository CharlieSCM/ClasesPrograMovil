import 'package:flutter/widgets.dart';
import 'package:login/screens/add_carrera.dart';
import 'package:login/screens/add_profe.dart';
import 'package:login/screens/add_task.dart';
import 'package:login/screens/calendario_screen.dart';
import 'package:login/screens/carrera_screen.dart';
import 'package:login/screens/dashboard_screen.dart';
import 'package:login/screens/detail_movie_screen.dart';
import 'package:login/screens/home.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/popular_screen.dart';
import 'package:login/screens/porfesor_screen.dart';
import 'package:login/screens/provider_screen.dart';
import 'package:login/screens/task_scree.dart';
//import 'package:login/screens/calendar_screen.dart';

Map<String,WidgetBuilder> getRouters(){
  return{
    '/dash' : (BuildContext context) => const DashboardScreen(),
    '/dash_log' : (BuildContext context) => const LoginScreen(),
    '/task' : (BuildContext context) => const TaskScreen(),
    '/add' : (BuildContext context) => AddTask(),
    '/popular' : (BuildContext context) => const PopularScreen(),
    //'/detail' :(BuildContext context) => const DetailMovieScreenState(),
    '/prov' :(BuildContext context) => const ProviderScreen(),
    '/profe' :(BuildContext context) => const ProfeScreen(),
    '/carrera' :(BuildContext context) => const CarreraScreen(),
    '/addCareer' :(BuildContext context) => AddCareerScreen(),
    '/addTeacher': (BuildContext context) => AddProfesor(),
    '/calendar': (BuildContext context) => const CalendarScreen(),
    '/hollow' : (BuildContext context) => Home(),
  };
}
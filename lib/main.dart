import 'package:concentric_transition/concentric_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/provider/test_provider.dart';
import 'package:login/assets/stylesApp.dart';
import 'package:login/card_background.dart';
import 'package:login/routes.dart';
import 'package:login/screens/dashboard_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*void main() {
  runApp(const MyApp());
  }*/

Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});
  //const MyApp({Key? key}) :super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLogged;
  bool? savedTheme;
@override
  void initState() {
    getLogginData();
    getThemeData();
    super.initState();
    //GlobalValues().leerValor();
  }

  Future getLogginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var logged = prefs.getBool('isLogged');
    setState(() {
      isLogged = logged;
    });
  }

  Future getThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('darkTheme')) {
      prefs.setBool('darkTheme', true);
    }
    var theme = prefs.getBool('darkTheme');
    setState(() {
      savedTheme = theme;
      GlobalValues.flagTheme.value = savedTheme!;
    });
  }

@override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return ChangeNotifierProvider(
          create: (context) => TestProvider(),
          child: MaterialApp(
            home:  isLogged == true 
              ? const DashboardScreen()
              : const LoginScreen(),
            routes: getRouters(),
            theme: value
            ? StylesApp.darkTheme(context)
            : StylesApp.lightTheme(context)
        
          ),
        );
      }
    );
  }
}

/*class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final data =  [
    CardBackgroundData(
      title: "Hollow Knight", 
      subtittle: "Aquel que nació del abismo y del que no se sabe nada más está destinado a salvar a 'HollowNest' De la Plaga y más conocida como 'Radiance'", 
      image: const AssetImage("assets/Hollow.png"), 
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1), 
      titleColor: Color.fromARGB(255, 0, 103, 110),//Colors.pink, 
      subtitleColor: Colors.white,//Color.fromARGB(209, 228, 77, 255),
      background: Lottie.asset("assets/animation_4.json"),
    ),

    CardBackgroundData(
      title: "Lores mantis", 
      subtittle: "Son los líderes de la tribu mantis, y sus mejores guerreros. Portan finas lanzas aguijón, y atacan con la velocidad del rayo.", 
      image: const AssetImage("assets/mantis.png"), 
      backgroundColor: Color.fromARGB(255, 0, 103, 110), 
      titleColor: Color.fromARGB(255, 53, 35, 107),//Colors.purple, 
      subtitleColor: Colors.white,//Color.fromARGB(255, 0, 0, 0),
      background: Lottie.asset("assets/animation_2.json"),
    ),

    CardBackgroundData(
      title: "Hornet", 
      subtittle: "Habilidosa protectora de las ruinas de Hallownest. Empuña una aguja e hilo.", 
      image: const AssetImage("assets/Hornet.png"), 
      backgroundColor: const Color.fromRGBO(71, 56, 117, 1), 
      titleColor: Colors.yellow, 
      subtitleColor: Colors.white,
      background: Lottie.asset("assets/animation_3.json"),
    ),
  ];

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: ConcentricPageView(
      itemCount: data.length,
      colors: data.map((e) => e.backgroundColor).toList(),
      itemBuilder: (int index) {
        return CardBackground(
          data: data[index]
        );
      },
    ),
    floatingActionButton: FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Login'), 
      onPressed: () {
        Navigator.pushNamed(context, '/dash_log');
      },
    ),
    floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerDocked
  );
}
}*/
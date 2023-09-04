import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:login/card_background.dart';
import 'package:login/routes.dart';
import 'package:login/screens/login_screen.dart';



void main()=> runApp(MyApp());

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) :super(key: key);

@override
  Widget build(BuildContext context){
    return MaterialApp(
      home: const Home(),
      routes: getRouters(),
      theme: ThemeData.dark(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  final data = const [
    CardBackgroundData(
      title: "Hollow Knight", 
      subtittle: "Hollow Knight Que nació del Abismo y No se sabe Nada mas Que El esta destinado a Salvar a 'HollowNest' De la Plaga y Más conocida como Una diosa de los Insectos a de 'HollowNest' como 'Radiance' una polilla que en culturas representa la muerte", 
      image: AssetImage("lib/assets/images/Hollow.png"), 
      backgroundColor: Color.fromRGBO(0, 10, 56, 1), 
      titleColor: Colors.pink, 
      subtitleColor: Colors.purpleAccent,
    ),

    CardBackgroundData(
      title: "Señores mantis", 
      subtittle: "Son los líderes de la tribu mantis, y sus mejores guerreros. Portan finas lanzas aguijón, y atacan con la velocidad del rayo.", 
      image: AssetImage("lib/assets/images/mantis.png"), 
      backgroundColor: Colors.white, 
      titleColor: Colors.purple, 
      subtitleColor: Color.fromRGBO(0, 10, 56, 1),
    ),

    CardBackgroundData(
      title: "Hornet", 
      subtittle: "Habilidosa protectora de las ruinas de Hallownest. Empuña una aguja e hilo.", 
      image: AssetImage("lib/assets/images/Hornet.png"), 
      backgroundColor:  Color.fromRGBO(71, 56, 117, 1), 
      titleColor: Colors.yellow, 
      subtitleColor: Colors.white,
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
    );
  }
}
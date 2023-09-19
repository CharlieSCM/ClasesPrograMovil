import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isSessionSaved =
      false; // Variable para verificar si la sesión está guardada

  @override
  void initState() {
    super.initState();
    checkSavedSession(); // Verificar si hay una sesión guardada al iniciar la aplicación
  }

  void checkSavedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? sessionSaved = prefs.getBool('sessionSaved');
    if (sessionSaved != null && sessionSaved) {
      // Si la sesión está guardada, redirige automáticamente al Dashboard
      Navigator.pushReplacementNamed(context, '/dash');
    }
  }

  void saveSession(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sessionSaved', value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    final txtUser = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    final txtPass = TextField(
      controller: txtConPass,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      obscureText: true,
    );

    final imgLogo = Container(
      width: 250,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/fr/8/88/Hollow_Knight_Logo.png'))),
    );

    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'),
      onPressed: () {
        // Guardar la sesión si el checkbox está marcado
        saveSession(isSessionSaved);

        Navigator.pushNamed(context, '/dash');
      },
    );

    final sessionCheckbox = Checkbox(
      value: isSessionSaved,
      onChanged: (value) {
        setState(() {
          isSessionSaved = value!;
        });
      },
    );

    final sessionCheckboxContainer = Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar el checkbox
        children: [
          Text('Guardar sesión'),
          SizedBox(width: 10.0),
          sessionCheckbox,
        ],
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://i.pinimg.com/564x/26/e8/c0/26e8c0495b5fd47424ab6605f2a87529.jpg'))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(71, 77, 205, 255),
                ),
                child: Column(
                  children: [
                    txtUser,
                    const SizedBox(
                      height: 10,
                    ),
                    txtPass,
                  ],
                ),
              ),
              imgLogo,
              sessionCheckboxContainer, // Contenedor con el checkbox para guardar sesión
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}
/*
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State <LoginScreen> createState() =>  LoginScreenState();
}

class  LoginScreenState extends State <LoginScreen> {
  //inicio de la practica numero 3 shared preferences hasta la linea 36 y despues vuelve en la linea
  //87
  bool isSessionSaved = false;
 
  @override
  void initState() {
    super.initState();
    checkSavedSession();
  }

  void checkSavedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? sessionSaved = prefs.getBool('sessionSaved');
    if (sessionSaved != null && sessionSaved) {
      // Si la sesión está guardada, redirige automáticamente al Dashboard
      Navigator.pushReplacementNamed(context, '/dash');
    }
  }

  void saveSession(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sessionSaved', value);
  }


  @override
  Widget build(BuildContext context) {

    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    final txtUser  = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );
    
    final txtPass  = TextField(
      controller: txtConPass,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
      obscureText: true,
    );

    final imgLogo = Container(
      width: 250,
      //height: 800,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://upload.wikimedia.org/wikipedia/fr/8/88/Hollow_Knight_Logo.png')//('https://imgs.search.brave.com/Moj2O8DWj5t2ywnqoEC_V2Lm4gJUJeId39UxkidSGk4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzU0L2M3/LzBkLzU0YzcwZDRl/NWJjMGY1NDk3ZjM5/MWQzODNjNjkwZTJi/LS1oZWFydC1naWYt/YmVhdXRpZnVsLWhl/YXJ0cy5qcGc') 
            )
          ),
        );

    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'), 
      onPressed: (){
        Navigator.pushNamed(context, '/dash');
      }
    );

    final sessionCheckbox = Checkbox(
      value: isSessionSaved,
      onChanged: (value) {
        setState(() {
          isSessionSaved = value!;
        });
      },
    );

    //aqui continua el trabajo de la practica 3 hasta la linea 98
    final sessionCheckboxContainer = Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar el checkbox
        children: [
          Text('Guardar sesión'),
          SizedBox(width: 10.0),
          sessionCheckbox,
        ],
      ),
    );
    /*
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.8,
            fit: BoxFit.cover,
            image: NetworkImage('https://i.pinimg.com/564x/26/e8/c0/26e8c0495b5fd47424ab6605f2a87529.jpg') //('https://i.pinimg.com/564x/c5/b7/23/c5b723ad8841030624ab5cd0ed9b33dc.jpg') //
              )
            ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(30),
                //color: Color.fromARGB(88, 77, 205, 255),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(71, 77, 205, 255),
                ),
                child: Column(
                  children: [
                    txtUser,
                    const SizedBox(height: 10,),
                    txtPass
                  ],
                ),
              ),
              imgLogo
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
    */
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                fit: BoxFit.cover,
                image: NetworkImage('https://i.pinimg.com/564x/26/e8/c0/26e8c0495b5fd47424ab6605f2a87529.jpg'))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(71, 77, 205, 255),
                ),
                child: Column(
                  children: [
                    txtUser,
                    const SizedBox(
                      height: 10,
                    ),
                    txtPass,
                  ],
                ),
              ),
              imgLogo,
              sessionCheckboxContainer, // Contenedor con el checkbox para guardar sesión
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}
*/
//import 'dart:html';

import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State <loginScreen> createState() =>  loginScreenState();
}

class  loginScreenState extends State <loginScreen> {
  @override
  Widget build(BuildContext context) {

    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    final txtUser  = TextField(controller: txtConUser,);
    final txtPass  = TextField(controller: txtConPass,);

    final imgFondo = Opacity(
      opacity: 1.0,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/564x/c5/b7/23/c5b723ad8841030624ab5cd0ed9b33dc.jpg') //('https://i.pinimg.com/564x/26/e8/c0/26e8c0495b5fd47424ab6605f2a87529.jpg')
              )
            ),
          ),
    );

    return Scaffold(body: Stack(
      children: [imgFondo,txtUser,txtPass],
      ),
        );
       
  }
}
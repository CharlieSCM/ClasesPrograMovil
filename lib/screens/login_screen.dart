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
      opacity: 0,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSR7sPI5GtEpNMAKR1IWXCl5C2Ugix0AFp2iQ&usqp=CAU')
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
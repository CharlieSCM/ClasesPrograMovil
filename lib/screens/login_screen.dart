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
      width: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://imgs.search.brave.com/Moj2O8DWj5t2ywnqoEC_V2Lm4gJUJeId39UxkidSGk4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzU0L2M3/LzBkLzU0YzcwZDRl/NWJjMGY1NDk3ZjM5/MWQzODNjNjkwZTJi/LS1oZWFydC1naWYt/YmVhdXRpZnVsLWhl/YXJ0cy5qcGc') // ('https://i.pinimg.com/564x/26/e8/c0/26e8c0495b5fd47424ab6605f2a87529.jpg')//
            )
          ),
        );

    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'), 
      onPressed: (){}
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.8,
            fit: BoxFit.cover,
            image: NetworkImage('https://i.pinimg.com/564x/c5/b7/23/c5b723ad8841030624ab5cd0ed9b33dc.jpg') //('https://i.pinimg.com/564x/26/e8/c0/26e8c0495b5fd47424ab6605f2a87529.jpg')
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
                  color: Color.fromARGB(88, 77, 205, 255),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: btnEntrar,
    );
       
  }
}
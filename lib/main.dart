import 'package:flutter/material.dart';
import 'package:aplicativo/TelaLogin.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  Map<String, dynamic>? dadosRegistro;

  @override
  Widget build(BuildContext context) {
    //return FutureBuilder(
    //future: _initialization,
    //builder: (context, snapshot) {
    //if (snapshot.connectionState == ConnectionState.done) {
    return MaterialApp(
      home: TelaLogin(dadosRegistro),
      // home: CadastroAplicador(dadosRegistro,
      //     title:
      //         'Página de cadastro do aplicador'), // Define que a classe inicial é o "selecao" que esta no arquivo selecao.dart
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.lightGreen[200]),
    );
    // }
    // return Container();
    // });
  }
}

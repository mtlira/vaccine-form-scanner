import 'package:flutter/material.dart';
import 'package:aplicativo/TelaLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Map<String, dynamic>? dadosRegistro;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaLogin(dadosRegistro),
      // home: CadastroAplicador(dadosRegistro,
      //     title:
      //         'Página de cadastro do aplicador'), // Define que a classe inicial é o "selecao" que esta no arquivo selecao.dart
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.lightGreen[200]),
    );
  }
}

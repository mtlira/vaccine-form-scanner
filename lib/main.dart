import 'package:aplicativo_teste/selecao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Selecao(
          title:
              'Página de Seleção'), // Define que a classe inicial é o "selecao" que esta no arquivo selecao.dart
      theme: ThemeData(
        primarySwatch: Colors.green, //Color(0xFFFFFFFF),
      ),
    );
  }
}

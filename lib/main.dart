import 'package:flutter/material.dart';
import 'package:aplicativo/TelaLogin.dart';
import 'package:aplicativo/TelaVacinador.dart';
import 'package:aplicativo/TelaFormulario.dart';
import 'package:aplicativo/TelaScan.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/TelaVacinador" : (context) => TelaVacinador(),
      "/TelaFormulario" : (context) => TelaFormulario(),
      "/TelaScan" : (context) => TelaScan(),
    },
    home: TelaLogin(),
  ));
}
import 'package:flutter/material.dart';
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

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Login",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        padding: EdgeInsets.all(89),
        color: Colors.lightGreen[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text("Ir para tela do vacinador"),
              padding: EdgeInsets.all(15),
              onPressed: (){
                Navigator.pushNamed(context, "/TelaVacinador");
              },
            )
          ],
        ),
      ),
    );
  }
}
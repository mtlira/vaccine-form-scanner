import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'TelaFormulario.dart';
import 'TelaScan.dart';


class TelaVacinador extends StatefulWidget {
  @override
  _TelaVacinadorState createState() => _TelaVacinadorState();
}

class _TelaVacinadorState extends State<TelaVacinador> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tela do Vacinador",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          // padding: EdgeInsets.all(48),
          // color: Colors.lightGreen[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                // color: Colors.blue,
                child: Text(
                  "Digitar Formulario de vacinação",
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                // padding: EdgeInsets.all(24),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaFormulario()));
                },
              ),
              ElevatedButton(
                // color: Colors.blue,
                child: Text(
                  "Escanear Formulario de vacinação",
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                // padding: EdgeInsets.all(24),
                onPressed: () {
                  Scanner_main();
                  //print('passei do scanner main');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scanner()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TelaScan extends StatefulWidget {
  @override
  _TelaScanState createState() => _TelaScanState();
}

class _TelaScanState extends State<TelaScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Scan"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Text("Escaneie o Formulário",
              style: new TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
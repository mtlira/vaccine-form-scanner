import 'package:flutter/material.dart';

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
            TextFormField(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Digite seu e-mail',
              ),
            ),
            Text(""), // Gambiarra
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Digite sua senha',
              ),
            ),
            Text(""), // Gambiarra
            RaisedButton(
              color: Colors.blue,
              child: Text("Enviar",
                style: new TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              padding: EdgeInsets.all(24),
              onPressed: (){
                Navigator.pushNamed(context, "/TelaVacinador");
              },
            ),
            /*TextFormField(
              decoration: const InputDecoration(
                hintText: 'Digite sua senha',
              ),
              validator: (String? value) (
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
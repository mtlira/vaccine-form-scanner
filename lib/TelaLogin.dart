import 'package:flutter/material.dart';
import 'TelaCadastroAplicador.dart';
import 'TelaVacinador.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin(this.dadosRegistro, {Key? key, this.title}) : super(key: key);
  final String? title;
  final Map<String, dynamic>? dadosRegistro;
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tela de Login",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Container(
          // padding: EdgeInsets.all(89),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                // color: Colors.blue,
                child: Text("Ir para tela do vacinador"),
                // padding: EdgeInsets.all(15),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TelaVacinador()));
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroAplicador(
                              widget.dadosRegistro,
                              title: 'Página de cadastro do aplicador'),
                        ));
                  },
                  child: Text('Ir para tela de cadastro do aplicador'))
            ],
          ),
        ),
      ),
    );
  }
}

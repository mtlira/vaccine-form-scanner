import 'package:aplicativo/TelaCPFCNS.dart';
import 'TelaLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'TelaFormulario.dart';
import 'TelaScan.dart';

class TelaVacinador extends StatefulWidget {
  TelaVacinador(this.dados_vacinacao, {Key? key}) : super(key: key);
  dynamic dados_vacinacao;
  @override
  _TelaVacinadorState createState() => _TelaVacinadorState();
}

class _TelaVacinadorState extends State<TelaVacinador> {
  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Tela do Vacinador",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
          actions: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(right: tamanhoDispositivo.width * 0.05),
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      textStyle:
                          TextStyle(fontSize: tamanhoDispositivo.width * .04)),
                  onPressed: () async {
                    await auth.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaLogin(null)),
                        (Route<dynamic> route) => false);
                  },
                  child: Text('DESLOGAR'),
                ))
          ]),
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
                          builder: (context) =>
                              TelaCPFCNS(widget.dados_vacinacao)));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TelaScan()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:aplicativo/TelaCPFCNS.dart';
import 'TelaLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'TelaScan.dart';
import 'dart:async';

class TelaVacinador extends StatefulWidget {
  TelaVacinador(this.dadosVacinacao, {Key? key}) : super(key: key);
  dynamic dadosVacinacao;

  @override
  _TelaVacinadorState createState() => _TelaVacinadorState();
}

class _TelaVacinadorState extends State<TelaVacinador> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Sair do app'),
            content:
                new Text('Você tem certeza que deseja sair do aplicativo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Sim'),
              ),
            ],
          ),
        )) ??
        false;
  }

  FutureBuilder _ativarCamera() {
    return FutureBuilder(
        future: Scanner_main(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          else
            return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                          textStyle: TextStyle(
                              fontSize: tamanhoDispositivo.width * .04)),
                      onPressed: () async {
                        await auth.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaLogin({})),
                            (Route<dynamic> route) => false);
                      },
                      child: Text('DESLOGAR'), // TODO: Colocar o tamanho bom
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
                      print(aplicador);
                      // widget.dadosVacinacao['Aplicador'] = widget.nomeAplicador;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaCPFCNS(
                                    widget.dadosVacinacao,
                                  )));
                    },
                  ),
                  // padding: EdgeInsets.all(24),

                  ElevatedButton(
                    // color: Colors.blue,
                    child: Text(
                      "Escanear Formulario de vacinação",
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // padding: EdgeInsets.all(24),
                    onPressed: () async {
                      print('apertou');

                      // Scanner_main();
                      //print('passei do scanner main');
                      // if (ativouCamera)
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Scanner()));
                      // else
                      //   Future.delayed(const Duration(milliseconds: 2000), () {
                      //     ativouCamera = true;
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => Scanner()));
                      //   });
                    },
                  ),
                  _ativarCamera()
                ],
              ),
            ),
          ),
        ));
  }
}

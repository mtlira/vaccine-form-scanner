import 'package:flutter/material.dart';

class Selecao extends StatefulWidget {
  Selecao({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SelecaoState createState() => SelecaoState();
}

class SelecaoState extends State<Selecao> {
  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text("Escanear"),
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: (tamanhoDispositivo.width * .2)),
              ),
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.green,
                            Colors.lightGreen,
                            Colors.greenAccent
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle:
                          TextStyle(fontSize: tamanhoDispositivo.width * .1),
                    ),
                    onPressed: () {},
                    child: Text('Digitar'),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'TelaCadastroAplicador.dart';

class TelaAdministrador extends StatefulWidget {
  const TelaAdministrador({Key? key}) : super(key: key);

  @override
  _TelaAdministradorState createState() => _TelaAdministradorState();
}

class _TelaAdministradorState extends State<TelaAdministrador> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green.shade400),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => CadastroAplicador()),
              // );
            },
            child: const Text('  Cadastrar aplicador  '),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green.shade400),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => GerenciarAplicadores()),
              // );
            },
            child: const Text('Gerenciar aplicadores'),
          ),
        ],
      ),
    );
  }
}

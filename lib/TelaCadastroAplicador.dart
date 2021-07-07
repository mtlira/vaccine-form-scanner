import 'package:aplicativo/auth.dart';
import 'package:flutter/material.dart';
import 'conexaoFirestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TelaLogin.dart';

class CadastroAplicador extends StatefulWidget {
  const CadastroAplicador(this.aplicador, {Key? key, this.title})
      : super(key: key);
  final String? title;
  final Map<String, dynamic> aplicador;
  @override
  _CadastroAplicadorState createState() => _CadastroAplicadorState();
}

class _CadastroAplicadorState extends State<CadastroAplicador> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscureText2 = true;
  String? nome;
  String email = '';
  String password = '';
  String token = '';
  String error = '';
  bool achou = false;
  Widget _campoInput(String variavelDesejada, Size tamanhoDispositivo) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      validator: (val) => val!.isEmpty ? 'Digite seu $variavelDesejada.' : null,
      decoration: InputDecoration(
        hintText: "Digite seu $variavelDesejada.",
        hintStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontSize: tamanhoDispositivo.width * .05),
      ),
      onChanged: (val) => setState(
          () => /*widget.dadosRegistro![variavelDesejada]*/ nome = val),
    );
  }

  String? _validarEmail(String? email) {
    if (email!.isEmpty) return "Digite um email";
    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) return "O email digitado não é válido";
    return null;
  }

  String? _validarSenha(String? senha) {
    if (senha!.isEmpty) return "Digite uma senha";
    if (senha.length < 6) return "A senha é muito curta.";
    return null;
  }

  String? _validarToken(String? token) {
    dynamic db = FirebaseFirestore.instance
        .collection('tokens')
        .get(); //FirebaseDatabase.instance.reference().child("tokens");

    db.then((snapshot) {
      List data = snapshot.docs;
      for (var valor in data) {
        print(valor.data()['token']);
        if (valor.data()['token'] == token) {
          achou = true;
          print(achou);
          return null;
        }
      }
      print(achou);
      // data.any((valores) {
      //   print(valores.data());
      //   if (token == valores.data()['token']) {
      //     achou = true;
      //     // print(achou);
      //   }
      //   return achou;
      // });
    });
    if (!achou) {
      print(achou);
      print("entrou");
      return "Token invalido";
    }

    return achou ? null : "Token invalido";
  }

  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title!)),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: tamanhoDispositivo.width * .8,
            height: tamanhoDispositivo.height * .75,
            //decoration: BoxDecoration(border: Border.all()),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "Nome"),
                      validator: (input) =>
                          input!.isEmpty ? 'Digite o nome' : null,
                      onChanged: (input) => widget.aplicador['Nome'] = input),
                  Spacer(),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "CPF"),
                      validator: (input) =>
                          input!.isEmpty ? 'Digite o CPF' : null,
                      onChanged: (input) => widget.aplicador['CPF'] = input),
                  Spacer(),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "Coren"),
                      validator: (input) =>
                          input!.isEmpty ? 'Digite o Coren' : null,
                      onChanged: (input) => widget.aplicador['Coren'] = input),
                  Spacer(),

                  TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => _validarEmail(
                          val), //val!.isEmpty ? 'Digite algo.' : null,
                      decoration: InputDecoration(
                        hintText: "Digite seu email",

                        //
                      ),
                      onChanged: (val) {
                        setState(() => email = val);
                        widget.aplicador['Email'] = val;
                      }),

                  Spacer(),

                  // Senha e token talvez serão separados, vamos ver isso depois.
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (val) => _validarSenha(
                        val), //val!.isEmpty ? 'Digite algo.' : null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () => setState(() {
                                _obscureText = !_obscureText;
                                print('teste');
                              })),
                      hintText: "Digite sua senha.",

                      //
                    ),
                    obscureText: _obscureText,
                    onChanged: (val) => setState(() => password = val),
                  ),
                  Spacer(),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (val) => _validarToken(
                        val), //val!.isEmpty ? 'Digite algo.' : null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_obscureText2
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () => setState(() {
                                _obscureText2 = !_obscureText2;
                                print('teste');
                              })),
                      hintText: "Digite o token.",

                      //
                    ),
                    obscureText: _obscureText2,
                    onChanged: (val) => setState(() => token = val),
                  ),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        setState(() async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error = 'email inválido');
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TelaLogin(widget.aplicador)),
                                  (Route<dynamic> route) => false);
                              registroAplicador(widget.aplicador);
                            }
                          }
                        });
                      },
                      child: Text('Registrar')),

                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: (14.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

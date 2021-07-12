import 'package:aplicativo/TelaAdmnistrador.dart';
import 'package:aplicativo/TelaFormularioVacina.dart';
import 'package:aplicativo/auth.dart';
import 'package:flutter/material.dart';
import 'TelaCadastroAplicador.dart';
import 'TelaVacinador.dart';
import 'conexaoFirestore.dart';
import 'package:flutter/scheduler.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin(this.dadosRegistro, {Key? key, this.title}) : super(key: key);
  final String? title;
  final Map<String, dynamic> dadosRegistro;
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

final AuthService auth = AuthService();
dynamic aplicador;

class _TelaLoginState extends State<TelaLogin> {
  final _formkey = GlobalKey<FormState>();
  bool apertado = false;
  bool passar = false;
  String email = '';
  String password = '';
  String error = '';
  bool _obscureText = true;

  FutureBuilder _dadosVacinas() {
    return FutureBuilder(
        future: Future.wait([pegarDadosVacinas(), pegarDadosAplicador(email)]),
        builder: (context, snapshot) {
          dynamic dados_vacinacao = [];
          if (apertado) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            if (snapshot.connectionState == ConnectionState.done) {
              snapshot.data[0].docs
                  .forEach((doc) => {dados_vacinacao.add(doc.data())});
              print(dados_vacinacao);
              print(passar);
              aplicador = snapshot.data[1].data();
              print(aplicador);
              if (passar) {
                passar = false;
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaVacinador(dados_vacinacao)),
                      (Route<dynamic> route) => false);
                });
              }
            }
            if (snapshot.hasError) {
              print("Erro: ${snapshot.error}");
            }
            return Container();
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tela de Login",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          height: tamanhoDispositivo.height * .8,
          width: tamanhoDispositivo.width * .8,
          // decoration: BoxDecoration(border: Border.all()),
          // padding: EdgeInsets.all(89),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 2),
              Form(
                  key: _formkey,
                  child: Column(children: [
                    TextFormField(
                        decoration: InputDecoration(hintText: "Email"),
                        validator: (val) =>
                            val!.isEmpty ? 'Digite o email.' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Senha",
                          suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => setState(() {
                                    _obscureText = !_obscureText;
                                    print('teste');
                                  })),
                        ),
                        obscureText: _obscureText,
                        validator: (val) =>
                            val!.isEmpty ? 'Digite a senha.' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        })
                  ])),
              Spacer(),
              ElevatedButton(
                child: Text("Logar"),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    dynamic result =
                        await auth.signInWithEmailAndPassword(email, password);

                    if (result == null) {
                      print("Senha ou email incorreto");
                      setState(() => error = 'Senha ou email incorreto');
                    } else {
                      setState(() {
                        apertado = true;
                        passar = true;
                      });
                      print("Logado com sucesso");
                    }
                  }
                },
              ),
              Text(
                error,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: tamanhoDispositivo.width * .05),
              ),
              _dadosVacinas(),
              Spacer(),
              //Spacer(),
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
                  child: Text('Ir para tela de cadastro do aplicador')),
            ],
          ),
        ),
      ),
    );
  }
}

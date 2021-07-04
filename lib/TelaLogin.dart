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
  final Map<String, dynamic>? dadosRegistro;
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool apertado = false;
  bool passar = false;
  String email = '';
  String password = '';
  String error = '';

  FutureBuilder _dadosVacinas(){
    return FutureBuilder(
      future: pegarDadosVacinas(),
      builder: (context, snapshot) {
        dynamic dados_vacinacao = [];
        if (apertado) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.connectionState == ConnectionState.done){
            snapshot.data.docs.forEach((doc) => {dados_vacinacao.add(doc.data())});
            print(dados_vacinacao);
            print(passar);
            if (passar) {
              passar = false;
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaVacinador(dados_vacinacao)));
                  });
            }
          }
          if (snapshot.hasError){
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
                  decoration: InputDecoration(hintText: "Login (Email)"),                      
                  validator: (val) =>val!.isEmpty ? 'Digite o email.' : null,
                  onChanged: (val) {
                    setState(()=>email=val);
                  }
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Senha"),
                  validator: (val) =>val!.isEmpty ? 'Digite a senha.' : null,
                  onChanged: (val) {
                    setState(()=>password=val);
                  }
                )
              ])),
              Spacer(),
              ElevatedButton (
                child: Text ("Logar"),
                onPressed: () async{
                  if (_formkey.currentState!.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null){
                      print ("Senha ou email incorreto");
                      setState(()=>error = 'Senha ou email incorreto');
                    }
                    else {
                      print ("Logado com sucesso");
                    }
                  }
                },

              ),
              ElevatedButton(
                // color: Colors.blue,
                child: Text("Ir para tela do vacinador"),
                // padding: EdgeInsets.all(15),
                onPressed: () {
                  setState(() {
                  apertado = true;
                  passar = true;
                  });
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => TelaVacinador()));
                },
              ),
              _dadosVacinas(),
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaAdministrador()));
                  },
                  child: Text('Ir para tela do administrador'))
            ],
          ),
        ),
      ),
    );
  }
}

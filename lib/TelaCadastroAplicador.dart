import 'package:flutter/material.dart';
import 'conexaoFirestore.dart';

class CadastroAplicador extends StatefulWidget {
  const CadastroAplicador(this.dadosRegistro, {Key? key, this.title})
      : super(key: key);
  final String? title;
  final Map<String, dynamic>? dadosRegistro;
  @override
  _CadastroAplicadorState createState() => _CadastroAplicadorState();
}

class _CadastroAplicadorState extends State<CadastroAplicador> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String? nome;
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
                  _campoInput('nome', tamanhoDispositivo),
                  Spacer(),
                  _campoInput('CPF', tamanhoDispositivo),
                  Spacer(),
                  _campoInput('endereço completo', tamanhoDispositivo),
                  Spacer(),
                  _campoInput('nº do COREN', tamanhoDispositivo),
                  Spacer(),
                  _campoInput('telefone', tamanhoDispositivo),
                  Spacer(),
                  _campoInput('email', tamanhoDispositivo),
                  Spacer(),
                  // Senha e token talvez serão separados, vamos ver isso depois.
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (val) => val!.isEmpty ? 'Digite algo.' : null,
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
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: tamanhoDispositivo.width * .05),
                      //
                    ),
                    obscureText: _obscureText,
                    onChanged: (val) =>
                        setState(() => widget.dadosRegistro!['senha'] = val),
                  ),
                  Spacer(),
                  _campoInput('token de registro', tamanhoDispositivo),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() => _formKey.currentState!.validate());
                        registroVacinado(nome);
                        print(nome);
                      },
                      child: Text('Testar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:aplicativo/TelaFormulario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:select_form_field/select_form_field.dart';
import 'conexaoFirestore.dart';
import 'TelaFormularioVacina.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/scheduler.dart';

class TelaCPFCNS extends StatefulWidget {
  TelaCPFCNS(this.dados_vacinacao, {Key? key}) : super(key: key);
  dynamic dados_vacinacao;
  @override
  _TelaCPFCNSState createState() => _TelaCPFCNSState();
}

class _TelaCPFCNSState extends State<TelaCPFCNS> {
  final _formKey = GlobalKey<FormState>();
  bool botao = false;
  Map<String, dynamic> vacinado = {};
  bool apertado = false;
  bool passar = false;

  String? _validarCPFCNS(String? input) {
    if (input == null) return "Digite o ${botao ? 'CPF' : 'CNS'}";
    if (botao) {
      if (input.length != 11)
        return "Digite o CPF completo.";
      else {
        int soma = 0;
        for (int i = 0; i < 9; i++) {
          soma += int.parse(input[i]) * (10 - i);
        }
        int digito1;
        int resto = (soma % 11);
        if (resto < 2) {
          digito1 = 0;
        } else
          digito1 = 11 - resto;
        if (digito1 != int.parse(input[9])) return "CPF inválido.";

        int digito2;
        soma = 0;
        for (int i = 0; i < 9; i++) {
          soma += int.parse(input[i]) * (11 - i);
        }
        soma += digito1 * 2;
        resto = (soma % 11);
        if (resto < 2) {
          digito2 = 0;
        } else
          digito2 = 11 - resto;
        print(digito2);
        if (digito2 != int.parse(input[10])) return "CPF inválido.";
        return null;
      }
    }
    if (!botao) if (input.length != 15) return "Digite o CNS completo.";
  }

  void _mapearVacinado(Map<String, dynamic> json) {
    vacinado['Nome'] = json['nome'];
    vacinado['Email'] = json['email'];
    vacinado['CPF'] = json['CPF'];
    vacinado['CNS'] = json['CNS'];
    vacinado['Telefone'] = json['Telefone'];
    vacinado['Sexo'] = json['Sexo'];
    vacinado['Endereço'] = json['Endereco'];
    vacinado['Nascimento'] = json['Data de nascimento'].toDate();
    // vacinado['Dose'] = json['1a dose'];
    vacinado['Grupo'] = json['Grupo'];
  }

  FutureBuilder _pegarDados(String? cpfCns) {
    return FutureBuilder(
        future: pegarDadosVacinado(cpfCns, botao),
        builder: (context, snapshot) {
          if (apertado) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              dynamic json = snapshot.data.data();
              print(json);
              if (json != null) _mapearVacinado(json);
              vacinado['botao'] = botao;
              print(vacinado);
              if (passar) {
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  passar = false;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaFormulario(
                              vacinado, widget.dados_vacinacao)));
                });
              }
              return Text('aaa');

              // Chegaram erros
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}.');
            } else {
              return Text('.');
            }
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de CPF ou CNS'),
      ),
      body: Stack(
        children: [
          // Center(
          //     child: Container(
          //   width: tamanhoDispositivo.width * .1,
          //   decoration: BoxDecoration(
          //     border: Border.all(),
          //     color: Colors.white,
          //   ),
          //   child: FittedBox(
          //       fit: BoxFit.fitWidth,
          //       child: _pegarDados(
          //           vacinado[botao ? 'CPF' : 'CNS'], botao, apertado)),
          // )),
          Center(
            child: Container(
              width: tamanhoDispositivo.width * .8,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),
                    Row(children: [
                      Spacer(),
                      Text('Usar CNS'),
                      Switch(
                          value: botao,
                          onChanged: (_) => setState(() {
                                botao = !botao;
                              })),
                      Text('Usar CPF'),
                      Spacer(),
                    ]),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                    botao ? 11 : 15),
                                //(botao ? maskFormatterCPF : maskFormatterCNS)
                              ],
                              decoration: InputDecoration(
                                  hintText: botao ? 'CPF' : 'CNS'),
                              validator: (input) => _validarCPFCNS(input),
                              /*input!.isEmpty
                                  ? 'Digite seu ${botao ? 'CPF' : 'CNS'}.'
                                  : null, //_validarCPFCNS*/
                              onChanged: (input) =>
                                  vacinado[botao ? 'CPF' : 'CNS'] = input,
                              keyboardType: TextInputType.number),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: tamanhoDispositivo.height * .05,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            if (_formKey.currentState!.validate())
                              apertado = true;
                            passar = true;
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             TelaFormulario(vacinado)));
                          });
                        },
                        child: Text('Próximo')),
                    SizedBox(
                      height: tamanhoDispositivo.height * .05,
                    ),
                    _pegarDados(vacinado[botao ? 'CPF' : 'CNS']),
                    Spacer(),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

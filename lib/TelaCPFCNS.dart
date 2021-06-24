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

class TelaCPFCNS extends StatefulWidget {
  const TelaCPFCNS({Key? key}) : super(key: key);

  @override
  _TelaCPFCNSState createState() => _TelaCPFCNSState();
}

class _TelaCPFCNSState extends State<TelaCPFCNS> {
  final _formKey = GlobalKey<FormState>();
  bool botao = false;
  Map<String, dynamic> vacinado = {};

  String? _validarCPFCNS(String? input) {}

  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de CPF ou CNS'),
      ),
      body: Center(
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
                            LengthLimitingTextInputFormatter(botao ? 11 : 15),
                            //(botao ? maskFormatterCPF : maskFormatterCNS)
                          ],
                          decoration:
                              InputDecoration(hintText: botao ? 'CPF' : 'CNS'),
                          validator: (input) => input!.isEmpty
                              ? 'Digite seu ${botao ? 'CPF' : 'CNS'}.'
                              : null, //_validarCPFCNS
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
                        vacinado['botao'] = botao;
                        if (_formKey.currentState!.validate())
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TelaFormulario(vacinado)));
                      });
                    },
                    child: Text('Próximo')),
                Spacer()
              ]),
        ),
      ),
    );
  }
}

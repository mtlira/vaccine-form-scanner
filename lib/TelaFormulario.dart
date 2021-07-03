import 'package:aplicativo/TelaFormularioVacina.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:select_form_field/select_form_field.dart';
import 'conexaoFirestore.dart';
import 'TelaFormularioVacina.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaFormulario extends StatefulWidget {
  TelaFormulario(this.vacinado, this.dados_vacinacao, {Key? key}) : super(key: key);
  Map<String, dynamic> vacinado;
  dynamic dados_vacinacao;
  @override
  _TelaFormularioState createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final _formKey = GlobalKey<FormState>();

  String? dropdownValue;
  var maskFormatterCPF = MaskTextInputFormatter(mask: '###.###.###-##');

  var maskFormatterCNS = MaskTextInputFormatter(mask: '### #### #### ####');

  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    final format = DateFormat("dd/MM/yyyy");
    dropdownValue = widget.vacinado['Sexo'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Formulário - Paciente"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          height: tamanhoDispositivo.height * 0.85,
          width: tamanhoDispositivo.height * 0.8,
          // decoration: BoxDecoration(border: Border.all()),
          padding: EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Nome"),
                    validator: (input) =>
                        input!.isEmpty ? 'Digite o nome.' : null,
                    onChanged: (input) => widget.vacinado['Nome'] = input,
                    initialValue: widget.vacinado['Nome'],
                  ),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (input) =>
                          input!.isEmpty ? 'Digite o email.' : null,
                      onChanged: (input) => widget.vacinado['Email'] = input,
                      initialValue: widget.vacinado['Email']),
                  TextFormField(
                    enabled: false,
                    inputFormatters: [
                      widget.vacinado['botao']
                          ? maskFormatterCPF
                          : maskFormatterCNS
                    ],
                    initialValue: widget.vacinado['botao']
                        ? widget.vacinado['CPF']
                        : widget.vacinado['CNS'],
                  ),
                  TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Telefone"),
                    validator: (input) =>
                        input!.isEmpty ? 'Digite o telefone.' : null,
                    onChanged: (input) => widget.vacinado['Telefone'] = input,
                    keyboardType: TextInputType.number,
                    initialValue: widget.vacinado['Telefone'],
                  ),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "Endereço"),
                      validator: (input) =>
                          input!.isEmpty ? 'Digite o endereço.' : null,
                      onChanged: (input) => widget.vacinado['Endereço'] = input,
                      initialValue: widget.vacinado['Endereço']),
                  DateTimeField(
                      decoration:
                          InputDecoration(hintText: "Data de Nascimento"),
                      onChanged: (input) =>
                          widget.vacinado['Nascimento'] = input,
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2022));
                      },
                      initialValue: widget.vacinado['Nascimento']),
                  DropdownButtonFormField<String>(
                    validator: (value) =>
                        value == null ? 'Preencha o sexo.' : null,
                    value: dropdownValue,
                    hint: Text('Selecione o sexo'),
                    dropdownColor: Colors.lightGreen[100],
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        widget.vacinado['Sexo'] = dropdownValue;
                      });
                    },
                    items: <String>['Masculino', 'Feminino']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: tamanhoDispositivo.height * .05,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        widget.vacinado['numeroDose'] = '1';
                        setState(() {
                          widget.vacinado['Data'] = DateTime.now();
                          if (_formKey.currentState!.validate())
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TelaVacina(widget.vacinado, widget.dados_vacinacao)));
                        });
                      },
                      child: Text('Próximo'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:aplicativo/TelaFormularioVacina.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:select_form_field/select_form_field.dart';
import 'conexaoFirestore.dart';
import 'TelaFormularioVacina.dart';

class TelaFormulario extends StatefulWidget {
  @override
  _TelaFormularioState createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
    },
  ];
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> vacinado = {};
  String? dropdownValue;
  bool botao = false;
  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    final format = DateFormat("yyyy-MM-dd");
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
                  Row(
                    children: [
                      Spacer(),
                      Text('Usar CNS'),
                      Switch(
                          value: botao,
                          onChanged: (_) => setState(() {
                                botao = !botao;
                              })),
                      Text('Usar CPF'),
                      Spacer(),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Nome"),
                    validator: (input) =>
                        input!.isEmpty ? 'Digite seu nome.' : null,
                    onChanged: (input) => vacinado['Nome'] = input,
                    initialValue: vacinado['Nome'],
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "email"),
                    validator: (input) =>
                        input!.isEmpty ? 'Digite seu email.' : null,
                    onChanged: (input) => vacinado['Email'] = input,
                  ),
                  TextFormField(
                      decoration:
                          InputDecoration(hintText: botao ? 'CPF' : 'CNS'),
                      validator: (input) => input!.isEmpty
                          ? 'Digite seu ${botao ? 'CPF' : 'CNS'}.'
                          : null,
                      onChanged: (input) =>
                          vacinado[botao ? 'CPF' : 'CNS'] = input,
                      keyboardType: TextInputType.number),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Telefone"),
                    validator: (input) =>
                        input!.isEmpty ? 'Digite seu telefone.' : null,
                    onChanged: (input) => vacinado['Telefone'] = input,
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Endereço"),
                    validator: (input) =>
                        input!.isEmpty ? 'Digite seu endereço.' : null,
                    onChanged: (input) => vacinado['Endereço'] = input,
                  ),
                  DateTimeField(
                    decoration: InputDecoration(hintText: "Data de Nascimento"),
                    onChanged: (input) => vacinado['Nascimento'] = input,
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2022));
                    },
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    hint: Text('Selecione seu sexo'),
                    dropdownColor: Colors.lightGreen[200],
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        vacinado['Sexo'] = dropdownValue;
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
                  ElevatedButton(
                      onPressed: () async {
                        print(vacinado);
                        setState(() {
                          final now = new DateTime.now();
                          vacinado['Data'] = DateFormat('yMd').format(now);
                          //if (_formKey.currentState!.validate())
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TelaVacina(vacinado)));
                          //registroVacinado(vacinado);
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

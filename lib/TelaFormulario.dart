import 'package:aplicativo/TelaFormularioVacina.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:select_form_field/select_form_field.dart';
import 'conexaoFirestore.dart';
import 'TelaFormularioVacina.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TelaFormulario extends StatefulWidget {
  TelaFormulario(this.vacinado, this.dados_vacinacao, {Key? key})
      : super(key: key);
  Map<String, dynamic> vacinado;
  dynamic dados_vacinacao;
  @override
  _TelaFormularioState createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final _formKey = GlobalKey<FormState>();

  String? dropdownValueSexo, dropdownValueRaca;
  var maskFormatterCPF = MaskTextInputFormatter(mask: '###.###.###-##');

  var maskFormatterCNS = MaskTextInputFormatter(mask: '### #### #### ####');

  int _gestantePuerpera() {
    if (widget.vacinado['Condicao'] == 'Gestante')
      return 0;
    else if (widget.vacinado['Condicao'] == 'N.A.')
      return 1;
    else if (widget.vacinado['Condicao'] == 'Puérpera') return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    final format = DateFormat("dd/MM/yyyy");
    dropdownValueSexo = widget.vacinado['Sexo'];
    dropdownValueRaca = widget.vacinado['Raça'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Formulário - Paciente"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          height: tamanhoDispositivo.height * 0.85,
          width: tamanhoDispositivo.height * 0.8,
          padding:
              EdgeInsets.symmetric(horizontal: tamanhoDispositivo.width * .05),
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
                    decoration: InputDecoration(hintText: "Nome da mãe"),
                    validator: (input) =>
                        input!.isEmpty ? 'Digite o nome da mãe.' : null,
                    onChanged: (input) =>
                        widget.vacinado['Nome da mãe'] = input,
                    initialValue: widget.vacinado['Nome da mãe'],
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Nome social"),
                    onChanged: (input) =>
                        widget.vacinado['Nome social'] = input,
                    initialValue: widget.vacinado['Nome social'],
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
                    value: dropdownValueSexo,
                    hint: Text('Selecione o sexo'),
                    dropdownColor: Colors.lightGreen[100],
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueSexo = newValue!;
                        widget.vacinado['Sexo'] = dropdownValueSexo;
                      });
                    },
                    items: <String>['Masculino', 'Feminino', 'Ignorado']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField<String>(
                    validator: (value) =>
                        value == null ? 'Preencha a raça.' : null,
                    value: dropdownValueRaca,
                    hint: Text('Selecione a raça'),
                    dropdownColor: Colors.lightGreen[100],
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueRaca = newValue!;
                        widget.vacinado['Raça'] = dropdownValueRaca;
                      });
                    },
                    items: <String>[
                      'Amarela',
                      'Branca',
                      'Indígena',
                      'Não informada',
                      'Parda',
                      'Preta'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: tamanhoDispositivo.height * .05,
                  ),
                  ToggleSwitch(
                    totalSwitches: 3,
                    labels: ['Gestante', 'N.A.', 'Puérpera'],
                    initialLabelIndex: _gestantePuerpera(),
                    onToggle: (index) {
                      (index == 0)
                          ? widget.vacinado['Condicao'] = 'Gestante'
                          : (index == 1)
                              ? widget.vacinado['Condicao'] = 'N.A.'
                              : (index == 2)
                                  ? widget.vacinado['Condicao'] = 'Puérpera'
                                  : widget.vacinado['Condicao'] = null;
                    },
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
                                    builder: (context) => TelaVacina(
                                        widget.vacinado,
                                        widget.dados_vacinacao)));
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

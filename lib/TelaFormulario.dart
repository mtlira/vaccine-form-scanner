import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:select_form_field/select_form_field.dart';


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
  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    final format = DateFormat("yyyy-MM-dd");
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Formulário"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          height: tamanhoDispositivo.height*0.85,
          width: tamanhoDispositivo.height*0.8,
          decoration: BoxDecoration(border: Border.all()),
          padding: EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                          child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Nome"  
                    )
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "email"  
                    )
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "CPF"  
                    )
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Telefone"  
                    )
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Sexo"  
                    )
                  ),
                  
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Endereço"  
                    )
                  ),
                  DateTimeField(
                    decoration: InputDecoration(
                      hintText: "Data de Nascimento"  
                    ),
                  format: format,
                  onShowPicker: (context, currentValue) {
                  return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2022));
        },
      ),
                  ElevatedButton(
                        onPressed: () async {
                          setState(() => _formKey.currentState!.validate());
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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> registroVacinado(Map<String, dynamic> vacinado) async {
  try {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('vacinados')
        .doc(_cpfOuCns(vacinado))
        .set({
      'nome': vacinado['Nome'],
      'email': vacinado['Email'],
      'CPF': vacinado['CPF'],
      'CNS': vacinado['CNS'],
      'Telefone': vacinado['Telefone'],
      'Sexo': vacinado['Sexo'],
      'Endereco': vacinado['Endereço'],
      'Data de nascimento': vacinado['Data']
    });
  } catch (e) {
    print("pegou " + e.toString());
  }
}

String _cpfOuCns(Map<String, dynamic> vacinado) {
  if (vacinado['CPF'] == null) return vacinado['CNS'];
  return vacinado['CPF'];
}

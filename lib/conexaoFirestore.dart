import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> registroVacinado(String? nome) async {
  try {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('vacinados')
        .doc(nome)
        .set({'nome': nome});
  } catch (e) {
    print("pegou " + e.toString());
  }
}

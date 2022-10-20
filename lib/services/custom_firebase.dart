import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leitor_qrcode/models/cupom.dart';

class FirebaseValidade {
  final CollectionReference clienteCollection =
      FirebaseFirestore.instance.collection('Clientes');

  Future<Cupom> getValidade(String key) async {
    DocumentSnapshot documentSnapshot = await clienteCollection.doc(key).get();

    Map<String, dynamic> cupomMap =
        documentSnapshot.data() as Map<String, dynamic>;
    Cupom cupom = Cupom.fromJson(cupomMap);

    return cupom;
  }

  updateValidade(String key) async {
    clienteCollection.doc(key).update({
      "validade": true,
    });
  }
}

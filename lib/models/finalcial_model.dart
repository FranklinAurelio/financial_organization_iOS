import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final String collection_entrada = 'Entradas';
final String collection_despesas = 'Despesas';

class EntradaModel {
  int? valorEntrada;
  String? descricaoEntrada;

  EntradaModel({this.valorEntrada, this.descricaoEntrada});

  EntradaModel.fromJson(Map<String, dynamic> json) {
    valorEntrada = json['valor_entrada'];
    descricaoEntrada = json['descricao_entrada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['valor_entrada'] = valorEntrada;
    data['descricao_entrada'] = descricaoEntrada;
    return data;
  }

  save() async {
    await Firebase.initializeApp();
    var ref = FirebaseFirestore.instance.collection(collection_entrada);
    //await ref.(this.rfId).setData(this.toJson());

    //await ref.add({'descricao_entrada': descricaoEntrada});
    await ref.doc(descricaoEntrada).set(
      {
        'valor_entrada': valorEntrada,
        'descricao_entrada': descricaoEntrada,
      },
    );
    //await ref.doc(descricaoEntrada).update(toJson());
  }
}

class DespesaModel {
  int? valorDespesa;
  String? descricaoDespesa;

  DespesaModel({this.valorDespesa, this.descricaoDespesa});

  DespesaModel.fromJson(Map<String, dynamic> json) {
    valorDespesa = json['valor_despesa'];
    descricaoDespesa = json['descricao_despesa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valor_despesa'] = valorDespesa;
    data['descricao_despesa'] = descricaoDespesa;

    return data;
  }

  save() async {
    await Firebase.initializeApp();
    var ref = FirebaseFirestore.instance.collection(collection_despesas);
    //await ref.(this.rfId).setData(this.toJson());

    //await ref.add({'descricao_entrada': descricaoEntrada});
    await ref.doc(descricaoDespesa).set(
      {
        'valor_despesa': valorDespesa,
        'descricao_despesa': descricaoDespesa,
      },
    );
    //await ref.doc(descricaoEntrada).update(toJson());
  }
}

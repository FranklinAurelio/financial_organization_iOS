import 'package:financial_organization/core/local_storage.dart';
import 'package:financial_organization/models/finalcial_model.dart';
import 'package:financial_organization/modules/home_page/home_messages.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

import '../../home_page/home_screen.dart';

class PopUp extends StatefulWidget {
  bool? isDespesa;

  PopUp({Key? key, this.isDespesa}) : super(key: key);
  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  TextEditingController description = TextEditingController();
  TextEditingController value = TextEditingController();
  String error = '';

  /*void updateDespesa() async {
    var value1;
    var saldo;
    int somaSaldo;
    int soma;
    value1 = await getData('despesa', 4);
    if (value1 != null) {
      soma = int.parse(value1[1]);
      soma = (soma + int.parse(value.text));
      putData([description.text, soma.toString()], 'despesa', 4);
    } else {
      putData([description.text, value.text], 'despesa', 4);
    }

    saldo = await getData('balance', 0);
    if (saldo != null) {
      somaSaldo = int.parse(saldo.toString()) - int.parse(value.text);
      putData(somaSaldo, 'balance', 0);
    } else {
      putData(int.parse(value.text), 'balance', 0);
    }
  }*/

  /*void updateEntrada() async {
    var value1;
    var saldo;
    int somaSaldo;
    int soma;
    value1 = await getData('entrada', 4);
    if (value1 != null) {
      soma = int.parse(value1[1]);
      soma = (soma + int.parse(value.text));
      putData([description.text, soma.toString()], 'entrada', 4);
    } else {
      putData([description.text, value.text], 'entrada', 4);
    }
    saldo = await getData('balance', 0);
    if (saldo != null) {
      somaSaldo = int.parse(saldo.toString()) + int.parse(value.text);
      putData(somaSaldo, 'balance', 0);
    } else {
      putData(int.parse(value.text), 'balance', 0);
    }
  }*/

  void newUpdateEntrada() async {
    EntradaModel _entrada;
    _entrada = EntradaModel(
      valorEntrada: int.parse(value.text),
      descricaoEntrada: description.text,
    );
    _entrada.save();
  }

  void newUpdateDespesa() async {
    DespesaModel _despesa;
    _despesa = DespesaModel(
      valorDespesa: int.parse(value.text),
      descricaoDespesa: description.text,
    );
    _despesa.save();
  }

  void save() {
    if (description.text.isEmpty) {
      setState(() {
        error = 'Preencha o campo de descrição';
      });
    } else if (value.text.isEmpty) {
      setState(() {
        error = 'Preencha o valor';
      });
    } else {
      widget.isDespesa == true ? newUpdateDespesa() : newUpdateEntrada();
      //Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
          (route) => false);
      //Modular.to.pushNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColorSave(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return widget.isDespesa == true ? Colors.red : Colors.indigo;
    }

    Color getColorCancel(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.amber;
    }

    return AlertDialog(
      backgroundColor: Colors.blue[100],
      title: Text(
        widget.isDespesa == true ? HomeMessages.expense : HomeMessages.incoming,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: widget.isDespesa == true ? Colors.red : Colors.blue[800]),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            TextFormField(
              controller: description,
              keyboardType: TextInputType.emailAddress,
              maxLines: 2,
              cursorColor: widget.isDespesa == true ? Colors.red : Colors.blue,
              decoration: const InputDecoration(
                labelText: HomeMessages.description,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: value,
              keyboardType: TextInputType.number,
              maxLines: 1,
              cursorColor: widget.isDespesa == true ? Colors.red : Colors.blue,
              decoration: const InputDecoration(
                  labelText: HomeMessages.value,
                  prefixText: HomeMessages.dollar_sign),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(getColorSave)),
          //color: Colors.green[800],
          child: const Text(
            "Salvar",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          onPressed: () async {
            save();
          },
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith(getColorCancel)),
          child: const Text(
            "Cancelar",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

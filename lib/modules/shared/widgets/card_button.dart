import 'package:financial_organization/modules/shared/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardButton extends StatefulWidget {
  String? navegation;
  String? buttonText;
  bool? isdespesa;

  CardButton({Key? key, this.navegation, this.buttonText, this.isdespesa})
      : super(key: key);
  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopUp(
                isDespesa: widget.isdespesa,
              );
            });
      },
      /*onTap: (() {
        widget.navegation != null
            ? Modular.to.pushNamed(widget.navegation!)
            : Modular.to.pushNamed('/home/');
      }),*/
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          height: 40,
          child: Center(
            child: Text(
              widget.buttonText ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

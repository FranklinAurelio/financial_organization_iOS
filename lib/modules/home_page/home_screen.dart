import 'package:financial_organization/core/local_storage.dart';
import 'package:financial_organization/modules/home_page/home_messages.dart';
import 'package:financial_organization/modules/shared/widgets/card_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String collection_entrada = 'Entradas';
  final String collection_despesas = 'Despesas';
  int input = 0;
  int out = 0;
  //var money;
  int balance = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getBalance();
    });
  }

  getBalance() async {
    await getIn();
    await getOut();
    setState(() {
      balance = input - out;
    });
  }

  getIn() async {
    await Firebase.initializeApp();
    var ref = FirebaseFirestore.instance.collection(collection_entrada);

    final snapshot = await ref.get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      setState(() {
        input =
            input + int.parse(snapshot.docs[i].data().values.last.toString());
      });
    }

    print(input);
  }

  getOut() async {
    await Firebase.initializeApp();
    var ref = FirebaseFirestore.instance.collection(collection_despesas);
    final snapshot = await ref.get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      setState(() {
        out = out + int.parse(snapshot.docs[i].data().values.last.toString());
      });
    }

    print(out);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.blue,
            ],
          )),
        ),
        Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    //shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/home2.png'),
                    ),
                  ),
                ),
              ),
              const Text(
                HomeMessages.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CardButton(
                buttonText: HomeMessages.input,
                isdespesa: false,
              ),
              const SizedBox(
                height: 15,
              ),
              CardButton(
                buttonText: HomeMessages.out,
                isdespesa: true,
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                HomeMessages.saldo,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    balance.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: balance >= 500
                            ? Colors.green
                            : balance >= 10 && balance < 500
                                ? Colors.amber
                                : Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

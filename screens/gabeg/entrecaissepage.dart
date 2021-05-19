import 'package:flutter/material.dart';

class EntreCaissePage extends StatefulWidget{
  const EntreCaissePage({Key key}) : super(key: key);

  @override 
  _EntreCaissePage createState() => _EntreCaissePage();

}

class _EntreCaissePage extends State<EntreCaissePage> {

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text('Paiement'),
      ),
    );
  }
}
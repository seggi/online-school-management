import 'package:flutter/material.dart';

class SoldeCaissePage extends StatefulWidget{
  const SoldeCaissePage({Key key}) : super(key: key);

  @override 
  _SoldeCaissePage createState() => _SoldeCaissePage();

}

class _SoldeCaissePage extends State<SoldeCaissePage> {

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text('Solde'),
      ),
    );
  }
}
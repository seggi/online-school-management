import 'package:flutter/material.dart';

class AutresPaiement extends StatefulWidget{
  const AutresPaiement({Key key}) : super(key: key);

  @override 
  _AutresPaiement createState() => _AutresPaiement();

}

class _AutresPaiement extends State<AutresPaiement>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child:  Text("Autres Paiements")
      )
    ,
    );
  }
}
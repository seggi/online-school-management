
import 'package:flutter/material.dart';

class StaffPaiement extends StatefulWidget{
  const StaffPaiement({Key key}) :  super(key : key);

  @override 
  _StaffPaiement createState() => _StaffPaiement();
  
}

class _StaffPaiement extends State<StaffPaiement> {
@override  
Widget build(BuildContext context){
  return Scaffold(
    body: Container(
      child: ListView(
        children: <Widget>[  
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container( 
                height: 20,
                alignment: Alignment.centerRight,
                child:  Padding(
                  padding:  EdgeInsets.only(right: 20.0),
                child: Text('Mai 2020', textAlign: TextAlign.right, 
                    style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18.0)),
                ), 
              ),

              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Directeur ', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
                ),
              ),
      
    
              Container(
                height: 60.0,
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[ 
                        Text('Salaire: 500', textAlign: TextAlign.left,),
                        Text('Avance: 100', textAlign: TextAlign.left,),
                        Text('Reste: 400', textAlign: TextAlign.left,),
                      ],
                  )
                )
              )
            ],
          ),
          Divider()
        ]
      )
    )
  );
}
}



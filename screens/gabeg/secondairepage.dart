
import 'package:flutter/material.dart';

class SecondairePaiement extends StatefulWidget{
  const SecondairePaiement({Key key}) :  super(key : key);

  @override 
  _SecondairePaiement createState() => _SecondairePaiement();
  
}

class _SecondairePaiement extends State<SecondairePaiement> {
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
                  child: Text('Tout les eleves ', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
                ),
              ),
    
              Container(
                height: 60.0,
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[ 
                        Text('Total: 500', textAlign: TextAlign.left,),
                        Text('Fille: 200', textAlign: TextAlign.left,),
                        Text('Garcon: 300', textAlign: TextAlign.left,),
                        
                        
                      ],
                  )
                )
              ),

              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Paiement', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
                ),
              ),
    
              Container(
                height: 60.0,
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[ 
                        Text('ELeves qui ont deja solde: 305', textAlign: TextAlign.left,),
                        Text('Eleves insolvable: 100', textAlign: TextAlign.left,),
                        Text('Eleves no pas encore solde : 123', textAlign: TextAlign.left,),
                        
                      ],
                  )
                )
              ),

              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Montant percu : 10000', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
                ),
              ),

            ],
          ),
          Divider()
        ]
      )
    )
  );
}
}
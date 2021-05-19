
import 'package:flutter/material.dart';

class PrimairePaiement extends StatefulWidget{
  const PrimairePaiement({Key key}) :  super(key : key);

  @override 
  _PrimairePaiement createState() => _PrimairePaiement();
  
}

class _PrimairePaiement extends State<PrimairePaiement> {
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
                        Text('Total: 90', textAlign: TextAlign.left,),
                        Text('Fille: 30', textAlign: TextAlign.left,),
                        Text('Garcon: 60', textAlign: TextAlign.left,),
                        
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
                        Text('ELeves qui ont deja solde: 50', textAlign: TextAlign.left,),
                        Text('Eleves insolvable: 20', textAlign: TextAlign.left,),
                        Text('Eleves no pas encore solde : 40', textAlign: TextAlign.left,),
                        
                        
                      ],
                  )
                )
              ),

              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Montant percu : 1500', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
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
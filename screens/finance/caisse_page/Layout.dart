import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nankim_s/models/livre_caisse/modules.dart';
// import 'package:nankim_s/screens/finance/caisse_page/rapjour.dart';
import 'dart:convert';

import 'package:sqflite/sql.dart';

class RapVoirTout extends StatefulWidget{
  const  RapVoirTout({Key key}) : super(key: key);

  @override 
  _RapVoirTout createState() =>  _RapVoirTout();
}

class _RapVoirTout extends State<RapVoirTout> {
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

  double _solde;
  int _debit;
  int _credit;
  List<ModuleVoirTout> _moduleVoirTout;
  ModuleVoirTout _voirTout;
  final ViewLivreCaisse _viewLivreCaisse = ViewLivreCaisse();
  
  @override 
  void initState(){
    super.initState();
    _moduleVoirTout = [];
    _getLivreCaisse();
  }

  // Get livre de caisse data  From Json (Future function)
  _getLivreCaisse() {
    //_showProgress('Chargement des donnees');
    _viewLivreCaisse.getLivreCaisse().then((journal){
      setState((){
         _moduleVoirTout = journal;
      });
    });
  }

  _calcule(var debit, var credit){
    double result = debit.toDouble() - credit.toDouble();
    return result.toString();
  }

  // Get some computation montant.debits - montant.credits
  Widget showSolde(){
    return FutureBuilder(
      future: _viewLivreCaisse.getLivreCaisse(),
      builder: (BuildContext context, AsyncSnapshot snpashot){
        if(snpashot.hasData){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snpashot.data.length,
            itemBuilder:(BuildContext context, index){
              _voirTout = snpashot.data[index];
              //var value =  _calcule(2, 3);
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                      Text("Entree: 20000.0", style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("Sortie: 12000.0", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Solde:  8000.0", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              );
            } 
          );
        }
        return CircularProgressIndicator();
       }
    );
  }



  @override
  Widget build(BuildContext context){
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
          child: Column(
            children: <Widget>[
              Container(
                height: 52.0,
                color: Colors.lightBlue.shade50,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: showSolde(),

                )
              ),
              Container(
                height: _height/1.47,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    dragStartBehavior: DragStartBehavior.start,
                    child: DataTable(
                      sortColumnIndex: 0,
                      sortAscending: true,
                      columns: [
                        DataColumn(label: Text('Date', style: TextStyle(fontWeight:  FontWeight.bold
                                  ,fontSize: 16.0)), numeric: false, ),
                        DataColumn(label: Text('Designation', style: TextStyle(fontWeight:  FontWeight.bold
                                  ,fontSize: 16.0)), numeric: false, ),
                        DataColumn(label: Text('Piece', style: TextStyle(fontWeight:  FontWeight.bold
                                  ,fontSize: 16.0)), numeric: false, ),
                        DataColumn(label: Text('Debit', style: TextStyle(fontWeight:  FontWeight.bold
                                  ,fontSize: 16.0)), numeric: false, ),
                        DataColumn(label: Text('Credit',style: TextStyle(fontWeight:  FontWeight.bold
                                  ,fontSize: 16.0)), numeric: false, ),
                        DataColumn(label: Text('Balance', style: TextStyle(fontWeight:  FontWeight.bold
                                  ,fontSize: 16.0)), numeric: false, )
                      ],
                      rows: _moduleVoirTout.map(
                        (journal) => DataRow(
                          cells: [
                            DataCell(Text(journal.date)),
                            DataCell(Text(journal.libel, textAlign: TextAlign.left,)),
                            DataCell(Text(journal.piece)),
                            DataCell(Text(journal.debits)),
                            DataCell(Text(journal.credits)),
                            DataCell(Text(journal.balance)),
                          ]
                        )
                      ).toList(),
                    )
                  )
                )
              )
            ],
          ),
        ),
    );
  }
}


// Fetch Caisse Data
class ModuleVoirTout {
  // This class combine incomming & outgoing money
  String date;
  String libel;
  String piece;
  String debits;
  String credits;
  String balance;
  

  ModuleVoirTout({this.date, this.libel, this.piece, 
                  this.debits, this.credits, this.balance});

  factory ModuleVoirTout.fromJson(Map<String, dynamic> json){
    return ModuleVoirTout(
      date: json['date'],
      libel: json['libel'],
      piece: json['piece'],
      debits: json['debits'],
      credits: json['credits'],
      balance: json['balance'],
    );
  }

   Map<String, dynamic> toMap() => {
    'date': date,
    'libel': libel,
    'piece': piece,
    'debits': debits,
    'credits': credits,
    'balance': balance,
   };
}

List<ModuleVoirTout> moduleVoirToutFromJson(String str) =>
                    List<ModuleVoirTout>.from(json.decode(str).map((x) => 
                    ModuleVoirTout.fromJson(x)));


class ViewLivreCaisse{
  Future<List<ModuleVoirTout>> getLivreCaisse() async {
    // String url ="http://10.0.2.2/nankim_s_server/livrecaisse.php";
    String url ="http://127.0.0.1/nankim_s_server/livrecaisse.php";
    final response = await http.get(url);
    return moduleVoirToutFromJson(response.body);
  }

}


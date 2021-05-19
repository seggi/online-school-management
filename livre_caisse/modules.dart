import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Fetch Caisse Data
class ModuleVoirTout {
  // This class combine incomming & outgoing money
  String date;
  String libel;
  String piece;
  String montant;
  String  type;
  

  ModuleVoirTout({this.date, this.libel, this.piece, this.montant, this.type});

  factory ModuleVoirTout.fromJson(Map<String, dynamic> json){
    return ModuleVoirTout(
      date: json['date'],
      libel: json['libel'],
      piece: json['piece'],
      montant: json['montant'],
      type: json['type'],
    );
  }

   Map<String, dynamic> toMap() => {
    'date': date,
    'libel': libel,
    'piece': piece,
    'montant': montant,
    'type': type,
   };
}

// List<ModuleVoirTout> moduleVoirToutFromJson(String str) =>
//                     List<ModuleVoirTout>.from(json.decode(str).map((x) => 
//                     ModuleVoirTout.fromJson(x)));


// class ViewLivreCaisse{
//   Future<List<ModuleVoirTout>> getLivreCaisse() async {
//     String url ="http://localhost/nankim_s_server/livrecaisse.php";
//     final response = await http.get(url);
//     return moduleVoirToutFromJson(response.body);
//   }

// }

  Future<List<ModuleVoirTout>>  getLivreCaisse() async {
    String url ="http://localhost/nankim_s_server/livrecaisse.php";
    var response = await http.get(url);
    if(response.statusCode == 200){
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      
      List<ModuleVoirTout> moduleVoirToutFromJson = items.map<ModuleVoirTout>((json){
        return ModuleVoirTout.fromJson(json);
      }).toList();
      return moduleVoirToutFromJson;
    }
    else{
      throw Exception('Failed to load data.');
    }
  }

getCalcule(var data){
  int solde;
  int debits;
  int credits;

  if (data.type == '0'){
     var credit = 0;
      var debit = int.parse(data.montant);
      debits ??= debit; // column one top montant
      credits = credit; // column two top 0

      solde ??= debit;
      solde += debit;
      
  }

  if(data.type == '1'){
    var debit = 0;
    var credit = int.parse(data.montant);
    debits ??= debit; // column one down 0
    credits = credit; // column two montant 

    solde ??= debit;
    solde -= credit;

    
  }
 
  
 print('$debits,  =>  $credits ,  : $solde');
  // switch (data.type){

  //   case '0': 
  //     double debit = double.parse(data.montant); double credit=0;
  //     debits ??= debit;
  //     credits ??= credit;
  //     solde = 12-debit;
  //     break;

  //   case '1': 
  //     double debit= 0; double credit= double.parse(data.montant);
      
  //     debits ??= debit;
  //     credits ??= credit;
    
  //     //print('${data.montant}');
  //     break;

    

  //   default: print('No amount found');
    
  // }
  // print('${debits}, ${credits}, ${solde}');
}

getrun() async{
 await getLivreCaisse().then((value) => 
        value.forEach((data) { 
           getCalcule(data);
           //makeComputation(data);

          }));
}





main(List<String> args) {
  getrun();
  
  
      
}
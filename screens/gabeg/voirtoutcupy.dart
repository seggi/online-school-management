
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:nankim_s/screens/api.dart';



class RapportCaisse extends StatefulWidget {
  const RapportCaisse({Key key}) : super(key: key);

  @override 
  _RapportCaisse createState() => _RapportCaisse();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});
  run (VoidCallback action) {
    if(null != _timer) {
      _timer.cancel();
    }

    _timer = Timer(Duration(microseconds: milliseconds), action);
  }
}


class _RapportCaisse extends State<RapportCaisse> {
  final _debouncer = Debouncer(milliseconds: 2000);
  // Declare a variable of type the class that's bind to api fetch address
  ModuleSumRapportCaisse _gettot;
  List<ModuleRapportCaisse> _moduleRapportCaisse;
  List<ModuleSumRapportCaisse> _moduleSumRapportCaisse;
  List<ModuleRapportCaisse> _filterRapportCaisse;
  final AccessRapportCaisse _accessRapportCaisse = AccessRapportCaisse();

  @override
  void initState() {
    super.initState();
    _filterRapportCaisse = [];
    _moduleRapportCaisse = [];
    _moduleSumRapportCaisse = [];
    _getRapportCaisse();
    _getSumRapportCaisse();
  }


  // Get rapport de caisse data from rest api

  _getRapportCaisse() {
    _accessRapportCaisse.getRapportCaisse().then((jounal) {
      setState(() {
        // _moduleRapportCaisse = jounal;
        // _filterRapportCaisse = jounal;
      });
    });
  }

  _getSumRapportCaisse() {
    _accessRapportCaisse.getSumRapportCaisse().then((journal) {
      setState(() {
        _moduleSumRapportCaisse = journal;
      });
    });
  }

  searchField() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: "Filtre dans le tableau..."
        ),
        onChanged: (string) {
          _debouncer.run(() {
            _filterRapportCaisse = _moduleRapportCaisse.where((u) => 
              (u.date.toLowerCase().contains(string.toLowerCase()) || 
              u.designation.toLowerCase().contains(string.toLowerCase()))
              ).toList();
          });
        },
      ),
    );
  }

  List<Map> getDailySum(gettotamount) {
    if (gettotamount.debits == null && gettotamount.credits == null){
      return [{'error': 'Aucune operation disponible...'}];
    }

    var tot = double.parse(gettotamount.debits) - double.parse(gettotamount.credits);
    return [{'tot': tot}];
  }

  Widget showBalance() {
    return FutureBuilder(
      future: _accessRapportCaisse.getSumRapportCaisse(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              _gettot = snapshot.data[index];
              // var credits = _gettot.credits != '0' ? _gettot.credits : _gettot.debits;
              // var debits = _gettot.credits == '0' ?  _gettot.debits : _gettot.credits ;

              // var tot =  double.parse(_gettot.debits) - double.parse(_gettot.credits)  ;
              // var tot = double.parse(debits) - double.parse(credits);
              // double.parse(debits) -

              if (_gettot.debits == 'null' && _gettot.credits == 'null') {
                return Center(
                  child: Column(
                    children: <Widget> [
                      SizedBox(height: 20.0),
                      Text("Aucune operation disponible...")
                    ]
                  ),
                );
              }

              else if (_gettot.debits != 'null' && _gettot.credits != 'null') {

                if (_gettot.debits != '0' && _gettot.credits == '0'){
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        
                            Text("Entré: ${_gettot.debits} ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0), 
                                textAlign: TextAlign.left,),
                            // Text("Sortie:${_gettot.credits} ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0),
                            //       textAlign: TextAlign.left),
                            // Text("Solde: $tot", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0),
                            //     textAlign: TextAlign.left),
                          
                
                      ],
                    )
                  ); 
                }

                else if (_gettot.debits == '0' && _gettot.credits != '0'){
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        
                            // Text("Entré: ${_gettot.debits} ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0), 
                            //     textAlign: TextAlign.left,),
                            Text("Sortie:${_gettot.credits} ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0),
                                  textAlign: TextAlign.left),
                            // Text("Solde: $tot", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0),
                            //     textAlign: TextAlign.left),
                          
                
                      ],
                    )
                  ); 
                }

                // else if (_gettot.debits == '0' && _gettot.debits != '0' && _gettot.credits == '0' && _gettot.credits != '0'){
                //   var tot =  double.parse(_gettot.debits) - double.parse(_gettot.credits);
                //   return Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget> [
                        
                //             // Text("Entré: ${_gettot.debits} ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0), 
                //             //     textAlign: TextAlign.left,),
                //             // Text("Sortie:${_gettot.credits} ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0),
                //             //       textAlign: TextAlign.left),
                //             Text("Solde: $tot", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30.0),
                //                 textAlign: TextAlign.left),
                          
                
                //       ],
                //     )
                //   ); 
                // }
              }
              else {
                return Center(child: CircularProgressIndicator(),);
              }

            }
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  @override 
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return Scaffold(
       appBar: AppBar(
        title: Text('Détails'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: () {
              _getRapportCaisse();
              _getSumRapportCaisse();
            })
        ],
      ),
      body: Container(
        width: _width,
        height: _height,
        child: ListView( 
          scrollDirection: Axis.vertical,
          children: <Widget>[
              // Container( 
              //   height: 100.0,
              //   child: Padding(
              //     padding: EdgeInsets.all(5.0),
              //     child: showBalance(),
              //   ),
              // ),

              searchField(),

              // Container(
              //   height: _height,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.vertical,
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       dragStartBehavior: DragStartBehavior.start,
              //       child: DataTable(
              //         sortColumnIndex: 0,
              //         sortAscending: true,
              //         columns: [
              //           DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold,
              //                     fontSize: 16.0)), numeric: false, ),
              //           DataColumn(label: Text('Désignation', style: TextStyle(fontWeight: FontWeight.bold, 
              //                     fontSize: 16.0),), numeric: false),
              //           DataColumn(label: Text('Entré', style: TextStyle(fontWeight: FontWeight.bold,
              //                     fontSize: 16.0),), numeric: false),
              //           DataColumn(label: Text('Sortie', style: TextStyle(fontWeight: FontWeight.bold, 
              //                     fontSize: 16.0),), numeric: false),
              //           DataColumn(label: Text('Solde', style: TextStyle(fontWeight: FontWeight.bold, 
              //                    fontSize: 16.0)), numeric: false,),
              //         ],
                      
              //         rows: _filterRapportCaisse.map(
              //           (journal) =>  DataRow(
              //             cells: [
              //               DataCell(Text("${journal.date}")),
              //               DataCell(Text("${journal.designation}", textAlign: TextAlign.left)),
              //               DataCell(Text("${journal.debits}")),
              //               DataCell(Text("${journal.credits}")),
              //               // DataCell(Text("${journal.balance}")),
              //             ]
              //           )
              //         ).toList(),
              //       ),
              //     ),
              //   ),
              // )


              Container(
                height: _height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    dragStartBehavior: DragStartBehavior.start,
                    child: DataTable(
                      sortColumnIndex: 0,
                      sortAscending: true,
                      columns: [
                        DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 16.0)), numeric: false, ),
                        DataColumn(label: Text('Désignation', style: TextStyle(fontWeight: FontWeight.bold, 
                                  fontSize: 16.0),), numeric: false),
                        DataColumn(label: Text('Entré', style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 16.0),), numeric: false),
                        DataColumn(label: Text('Sortie', style: TextStyle(fontWeight: FontWeight.bold, 
                                  fontSize: 16.0),), numeric: false),
                        DataColumn(label: Text('Solde', style: TextStyle(fontWeight: FontWeight.bold, 
                                 fontSize: 16.0)), numeric: false,),
                      ],
                      
                      rows: _filterRapportCaisse.map(
                        (journal) =>  DataRow(
                          cells: [
                            DataCell(Text("${journal.date}")),
                            DataCell(Text("${journal.designation}", textAlign: TextAlign.left)),
                            DataCell(Text("${journal.debits}")),
                            DataCell(Text("${journal.credits}")),
                            DataCell(Text("${journal.balance}")),
                          ]
                        )
                      ).toList(),
                    ),
                  ),
                ),
              )
          ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.attach_money),
        onPressed: () => showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: showBalance(),
              actions: <Widget>[
                FlatButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context)),
              ],
            );   
        },
       )
      )
    );
  }

}

// Fetch data From Api(Django) "Rapport de caisse"

class ModuleRapportCaisse {
  String designation;
  String debits;
  String credits;
  String balance;
  // String piece;
  String date;

  ModuleRapportCaisse({this.designation, this.debits, this.credits, this.balance, this.date});

  factory ModuleRapportCaisse.fromJson(Map<String, dynamic> json) {
    return ModuleRapportCaisse(
      // designation: json["libel"],
      // debits: json["debit"].toString(),
      // credits: json["credit"].toString(),
      // // balance: json["balance"].toString(),
      // date: json["date"]
      date: json['date'],
      designation: json['libel'],
      debits: json['debit'],
      credits: json['credit'],
      balance: json['piece'],

    );
  }

  Map<String, dynamic> toMap() => {
    "designation": designation,
    "debit": debits,
    "credit": credits,
    "balance": balance,
    "date": date,
  };

}

class ModuleSumRapportCaisse {
  String debits;
  String credits;

  ModuleSumRapportCaisse({this.debits, this.credits});

  factory ModuleSumRapportCaisse.fromJson(Map<String, dynamic> json) {
    return ModuleSumRapportCaisse(
      debits: json["debit"].toString(),
      credits: json["credit"].toString(),

    );
  }

  Map<String, dynamic> toMap() => {
    "debit": debits,
    "credit": credits,
  };

}


List<ModuleRapportCaisse> moduleRapportCaisseFromJson(String str) => 
                        List<ModuleRapportCaisse>.from(json.decode(str).map((x) => 
                        ModuleRapportCaisse.fromJson(x)));

List<ModuleSumRapportCaisse> moduleSumRapportCaisseFromJson(String str) => 
                        List<ModuleSumRapportCaisse>.from(json.decode(str).map((x) => 
                        ModuleSumRapportCaisse.fromJson(x)));

class AccessRapportCaisse {
  Future<List<ModuleRapportCaisse>> getRapportCaisse() async {
    // String url = emUrl + "bulletinizer/api/rapports.php";
    // String url = "https://cslerocher.com/app/api/rapports";
    String url = emUrl + "rapports";
    final response = await http.get(url);
    return moduleRapportCaisseFromJson(response.body);
  }

   Future<List<ModuleSumRapportCaisse>> getSumRapportCaisse() async {
    // String url = emUrl + "bulletinizer/api/rapports?state=check_out_sum";
    // String url = emUrl + "rapports?state=check_out_sum";
    String url = "https://cslerocher.com/app/api/rapports";
    final response = await http.get(url);
    return moduleSumRapportCaisseFromJson(response.body);
  }
}






// class AccessRapportCaisse {
//   Future<List<ModuleRapportCaisse>> getRapportCaisse() async {
//     // String url = emUrl + "bulletinizer/api/rapports.php";
//     // String url = "https://cslerocher.com/app/api/rapports";
//     // String url = emUrl + "rapports";
//     // final url = 'http://webpac.ksml.edu.tw/maintain/bookDetailAssdataAjax.do?id=1283659&viewDetailType=Details';
//     // final client = new HttpClient();
//     // final request = await client.getUrl(Uri.parse(url));
//     // final response = await request.close();
//     // print(response.statusCode);

//     String url = "https://cslerocher.com/app/api/rapports";
//     final response = await http.post(url);
//     return moduleRapportCaisseFromJson(response.body);
  
//     // return moduleRapportCaisseFromJson(response.body);
  
//     // http.Response response =  await http.get(
//     //    Uri.encodeFull('https://cslerocher.com/app/api/rapports'),
//     //    headers: {
//     //      "accept": "Application/json"
//     //    }
//     //    );
//     // return moduleRapportCaisseFromJson(response.body);
//   }

//    Future<List<ModuleSumRapportCaisse>> getSumRapportCaisse() async {
//     // String url = emUrl + "bulletinizer/api/rapports?state=check_out_sum";
//     // String url = emUrl + "rapports?state=check_out_sum";
//     String url = "https://cslerocher.com/app/api/rapports";
//     final response = await http.post(url);
//     return moduleSumRapportCaisseFromJson(response.body);
//   }
// }









// // import 'dart:async';
// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // Future<Album> fetchAlbum() async {
// //   final response =
// //       await http.get('https://cslerocher.com/app/api/rapports');
// //   print("****************${json.decode(response.body)}**************");

// //   if (response.statusCode == 200) {
// //     // If the server did return a 200 OK response,
// //     // then parse the JSON.
// //     return Album.fromJson(json.decode(response.body));
// //   } else {
// //     // If the server did not return a 200 OK response,
// //     // then throw an exception.
// //     throw Exception('Failed to load album');
// //   }
// // }

// // class Album {
// //   final int userId;
// //   final int id;
// //   final String title;

// //   Album({this.userId, this.id, this.title});

// //   factory Album.fromJson(Map<String, dynamic> json) {
// //     return Album(
// //       userId: json['userId'],
// //       id: json['id'],
// //       title: json['title'],
// //     );
// //   }
// // }


// // class RapportCaisse extends StatefulWidget {
// //   RapportCaisse({Key key}) : super(key: key);

// //   @override
// //   _RapportCaisseState createState() => _RapportCaisseState();
// // }

// // class _RapportCaisseState extends State<RapportCaisse> {
// //   Future<Album> futureAlbum;

// //   @override
// //   void initState() {
// //     super.initState();
// //     futureAlbum = fetchAlbum();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Fetch Data Example',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Fetch Data Example'),
// //         ),
// //         body: Center(
// //           child: FutureBuilder<Album>(
// //             future: futureAlbum,
// //             builder: (context, snapshot) {
// //               if (snapshot.hasData) {
// //                 return Text(snapshot.data.title);
// //               } else if (snapshot.hasError) {
// //                 return Text("${snapshot.error}");
// //               }

// //               // By default, show a loading spinner.
// //               return CircularProgressIndicator();
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

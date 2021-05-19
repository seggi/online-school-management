import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:nankim_s/screens/api.dart';
import 'package:nankim_s/screens/finance/caisse_page/datePicker.dart';




class RapSold extends StatefulWidget {
  const RapSold({Key key}) :  super(key: key);

  @override 
  _RapSold createState() => _RapSold();

}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});
  run (VoidCallback action) {
    if(null != _timer) {
      _timer.cancel(); // When the user is continuosly typing
    }

    // Then we will start a new timer looking for rhe user to stop
    _timer = Timer(Duration(microseconds:  milliseconds), action);
  }

}


class _RapSold extends State<RapSold> {
  final _debouncer = Debouncer(milliseconds: 2000);

  List<ModuleRapSold> _filterRapSold;
  List<ModuleRapSold> _moduleRapSold;
  final FetchingSingleUrl _fetchingSingleUrl = FetchingSingleUrl();


  @override  
  void initState() {
    super.initState();
      _filterRapSold = [];
      _moduleRapSold = [];
      _getRapSold();
  }

  _getRapSold() {
    _fetchingSingleUrl.getRapSold().then((journal) {
      setState(() {
        _moduleRapSold = journal;
        _filterRapSold = journal;
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
            _filterRapSold = _moduleRapSold.where((u) => 
              (u.date.toLowerCase().contains(string.toLowerCase()) ||
              u.designation.toLowerCase().contains(string.toLowerCase()))
              ).toList();
          });
        },
      ),
    );
  }
  @override 
  Widget build(BuildContext context){
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vente'),
         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: () {
              _getRapSold();
            })
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              searchField(),
              Container(
                height: _height,
                width: _width,
                child: ListView (
                  scrollDirection: Axis.vertical,
                  children: <Widget>[ 
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
                                  fontSize: 16.0)), numeric: false),
                                DataColumn(label: Text('Designation', style: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 16.0),), numeric: false),
                                DataColumn(label: Text('Montant', style: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 16.0),), numeric: false),
                                DataColumn(label: Text('Paiement', style: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 16.0),), numeric: false),
                            ],

                            rows: _filterRapSold.map(
                              (journal) => 
                              
                              // if(journal != null){
                                  DataRow(
                                  cells: [
                                    DataCell(Text(journal.date)),
                                    DataCell(Text(journal.designation, textAlign: TextAlign.left,)),
                                    DataCell(Text(journal.amount)),
                                    DataCell(Text(journal.type))
                                  ]
                                )
                              // }

                              // CircularProgressIndicator();
                              
                            ).toList(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),


      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      // backgroundColor: Colors.blue.shade200,
      // child: Icon(Icons.date_range),
      //   onPressed: () {
      //     Navigator.push(
      //       context, 
      //       MaterialPageRoute(
      //         builder: (context) => ProductSoldSeleteDate()
      //       )
      //     );
      //   },
      // ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.date_range),
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => ProductSoldSeleteDate()
            )
          );
        },
      ),

    );
  }
}


class ModuleRapSold {
  String designation;
  String amount;
  String date;
  String type;

  ModuleRapSold({this.designation, this.amount, this.date, this.type});

  factory ModuleRapSold.fromJson(Map<String, dynamic> json) {
    return ModuleRapSold(
      designation: json['designation'],
      amount: json['amount'].toString(),
      date:  json['date'],
      type: json['type'],
    );
  }

  Map<String, dynamic>  toMap() => {
    "designation": designation,
    "amount": amount,
    "date": date,
    "type": type,
  };
}


List<ModuleRapSold> moduleRapSold(String str) => 
    List<ModuleRapSold>.from(json.decode(str).map((x) => 
    ModuleRapSold.fromJson(x)));

class FetchingSingleUrl {
  Future<List<ModuleRapSold>> getRapSold() async {
    // String url ="http://10.0.2.2:8000/shule/api/detail/rapport_sold/";
    // String url ="http://127.0.0.1:8000/shule/api/detail/rapport_sold/";
    // String url = "http://192.168.43.53/bulletinizer/api/rapports?state=sell_check_out";

    // String url = emUrl + "bulletinizer/api/rapports?state=sold_details";
    String url = emUrl + "rapports?state=sold_details";
    final response = await http.post(url);
    return moduleRapSold(response.body);
  }
}


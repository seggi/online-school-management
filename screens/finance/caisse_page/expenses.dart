import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:nankim_s/screens/api.dart';
import 'package:nankim_s/screens/finance/caisse_page/datePicker.dart';




class RapExpenses extends StatefulWidget {
  const RapExpenses({Key key}) :  super(key: key);

  @override 
  _RapExpenses createState() => _RapExpenses();

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


class _RapExpenses extends State<RapExpenses> {
  final _debouncer = Debouncer(milliseconds: 2000);

  List<ModuleRapExpenses> _filterRapExpenses;
  List<ModuleRapExpenses> _moduleRapExpenses;
  final FetchingSingleUrl _fetchingSingleUrl = FetchingSingleUrl();


  @override  
  void initState() {
    super.initState();
      _filterRapExpenses = [];
      _moduleRapExpenses = [];
      _getRapExpenses();
  }

  _getRapExpenses() {
    _fetchingSingleUrl.getRapExpenses().then((journal) {
      setState(() {
        _moduleRapExpenses = journal;
        _filterRapExpenses = journal;
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
            _filterRapExpenses = _moduleRapExpenses.where((u) => 
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
        title: Text('Dépenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: () {
              _getRapExpenses();
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
                            ],

                            rows: _filterRapExpenses.map(
                              (journal) => 
                    
                                  DataRow(
                                  cells: [
                                    DataCell(Text(journal.date)),
                                    DataCell(Text(journal.designation, textAlign: TextAlign.left,)),
                                    DataCell(Text(journal.amount)),
                                  ]
                                )
                          
                              
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
      //         builder: (context) => ExpensesSelectDate()
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
              builder: (context) => ExpensesSelectDate()
            )
          );
        },
      ),
    );
  }
}


class ModuleRapExpenses {
  String designation;
  String amount;
  String date;
  String type;

  ModuleRapExpenses({this.designation, this.amount, this.date, this.type});

  factory ModuleRapExpenses.fromJson(Map<String, dynamic> json) {
    return ModuleRapExpenses(
      designation: json['designation'],
      amount: json['amount'].toString(),
      date:  json['date'],

    );
  }

  Map<String, dynamic>  toMap() => {
    "designation": designation,
    "amount": amount,
    "date": date,
    
  };
}


List<ModuleRapExpenses> moduleRapExpenses(String str) => 
    List<ModuleRapExpenses>.from(json.decode(str).map((x) => 
    ModuleRapExpenses.fromJson(x)));

class FetchingSingleUrl {
  Future<List<ModuleRapExpenses>> getRapExpenses() async {
    // String url = emUrl + "bulletinizer/api/rapports?state=expenses_details";
    String url = emUrl + "rapports?state=expenses_details";
    final response = await http.post(url);
    return moduleRapExpenses(response.body);
  }
}


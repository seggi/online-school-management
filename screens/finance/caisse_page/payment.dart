import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nankim_s/screens/api.dart';
import 'package:nankim_s/screens/finance/caisse_page/datePicker.dart';
import 'dart:async';

import 'package:nankim_s/screens/finance/caisse_page/sold.dart';

class StudentPayment extends StatefulWidget {
  const StudentPayment({Key key}) :  super(key: key);

  @override 
  _StudentPayment createState() => _StudentPayment();

}


// Now we will write a class that will help in searching.


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

class _StudentPayment extends State<StudentPayment> {
  // This list will hold the filter 
  List<ModuleStudentPayment> _filterPayment;

  List<ModuleStudentPayment>  _moduleStudentPayment;
  final FetchingSingleUrl _fetchingSingleUrl = FetchingSingleUrl();

  // This will wait for 500 milliseconds after the user has stopped typing
  final  _debouncer = Debouncer(milliseconds: 2000);

  // DateTime _currentdate = new DateTime.now();

  // DateTime _currentdate1 = new DateTime.now();


  
  @override
  void initState(){
    super.initState();
    _filterPayment= [];
    _moduleStudentPayment = [];
    _getStudentPayment();
  }

  _getStudentPayment() {
    _fetchingSingleUrl.getRapportCaisse().then((jounal){
      setState(() {
        _moduleStudentPayment = jounal;
        // Initialize to the list from Server when reloading...
        _filterPayment = jounal;
      });
    });
  }

  // searchfield to search in DataTable
  searchField() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: "Filtre dans le tableau..."
        ),
        onChanged: (string) {
          // start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          setState(() { 
            _debouncer.run(() {
              _filterPayment = _moduleStudentPayment.where((u) => 
                (u.date.toLowerCase().contains(string.toLowerCase()) || 
                u.designation.toLowerCase().contains(string.toLowerCase()))
              ).toList();
            });
          });
        },
      ),
    );
  }

  Future<ModuleStudentPayment> fetchPayment()  async {
    final response = await http.get('');
    
    if (response.statusCode == 200) {
      return ModuleStudentPayment.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load data');
    }
  }



  @override 
  Widget build(BuildContext context){
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.height;
    // String _formatdate =  new DateFormat.yMMMd().format(_currentdate);
    // String _formatdate1 = new DateFormat.yMMMd().format(_currentdate1);

    return Scaffold(
      appBar: AppBar(
        title: Text('Paiement des élèves'),
         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: () {
              _getStudentPayment();
            }),
          
          // IconButton(
          //   icon: Icon(Icons.date_range),
          //   onPressed: () {
              
          //   },
          // )

          ],
        ),
      body: SafeArea(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[

              searchField(),
              // Center(child: Text("Date: $_formatdate"),),

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
                            // The list should show the filtered list now 

                            rows: _filterPayment.map(
                            
                              (journal) => DataRow(
                                cells: [
                                  DataCell(Text(journal.date)),
                                  DataCell(Text(journal.designation, textAlign: TextAlign.left,)),
                                  DataCell(Text(journal.amount))
                                ]
                              )
                            ).toList(),
                          ),
                        ),
                      ),
                    )
                  ]
                )
              )
            ],
          ),
        )
      ),


      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocke,
      // floatingActionButton: FloatingActionButton(
      // backgroundColor: Colors.blue.shade200,
      // child: Icon(Icons.date_range),
      //   onPressed: () {
      //     Navigator.push(
      //       context, 
      //       MaterialPageRoute(
      //         builder: (context) => StudentPaymentSelectDate()
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
              builder: (context) => StudentPaymentSelectDate()
            )
          );
        },
      ),

    );
  }
}


class ModuleStudentPayment {
  String designation;
  String amount;
  String date;

  ModuleStudentPayment({this.designation, this.amount, this.date});

  factory ModuleStudentPayment.fromJson(Map<String, dynamic> json) {
    return ModuleStudentPayment(
      designation: json['designation'],
      amount: json['amount'].toString(),
      date: json['date'],
    );
  }

  Map<String, dynamic> toMap() => {
    "designation": designation,
    "amount": amount,
    "date":  date,
  };
}


List<ModuleStudentPayment> moduleStudentPaymentJson(String str) => 
        List<ModuleStudentPayment>.from(json.decode(str).map((x) => 
        ModuleStudentPayment.fromJson(x)));

class FetchingSingleUrl {
  Future<List<ModuleStudentPayment>> getRapportCaisse() async {
    // String url = emUrl + "bulletinizer/api/rapports?state=payment_detail"; 

    String url = emUrl + "rapports?state=payment_detail"; 
    final response = await http.post(url);
    return moduleStudentPaymentJson(response.body);
  }

  // Future<List<ModuleRapSold>> getRapSold() async {
  //   String url ="http://10.0.2.2:8000/shule/api/detail/rapport_sold/";
  //   final response = await http.get(url);
  //   return moduleRapSold(response.body);

  // "http://10.0.2.2:8000/shule/api/detail/rapport_payment/";
    // String url ="http://127.0.0.1:8000/shule/api/detail/rapport_payment/";
  // }
}


import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nankim_s/screens/api.dart';

// Student payment...

class StudentPaymentSelectDate extends StatefulWidget {
  @override 
  _StudentPaymentSelectDate createState() => _StudentPaymentSelectDate();

}

class _StudentPaymentSelectDate extends State<StudentPaymentSelectDate> {
  bool visible = false;
  DateTime _currentdate = new DateTime.now();
  DateTime _currentdate1 = new DateTime.now();

  String errMessage = "Erreur de connexion";
  String status = '';
  // final String url = emUrl + "bulletinizer/api/authentication/compute_student_payment.php";
  final String url = emUrl + "authentication/compute_student_payment.php";

  setStatus(String message) {
    setState(() {
      status = message;
    }); 
  }

  Future getData(String date1, String date2) async {

    var datas = {'date1': date1, 'date2': date2 };

    var response = await http.post(url, body: datas);

    print("******************${jsonDecode(response.body)}***********************");

    var result = jsonDecode(response.body);

    double totamoun = double.parse(result[0]['amount'] != null ? result[0]['amount']: 0.0.toString());

    

    setState(() {
      setStatus(result[0]['amount'] != null ? '\$' + totamoun.toString(): 'Rien à signaler sur cette date.');
    });

 }


  Future<Null> _selectdate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
        context: context, 
        initialDate: _currentdate, 
        firstDate: DateTime(1990), 
        lastDate: DateTime(2040),
        builder: (context, child) {
          return SingleChildScrollView(child: child,);
        }
      );

       if(_seldate!=null) {
          setState(() {
            _currentdate = _seldate;
          });
        }
    }

  Future<Null>  _selectdate1(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
      context: context, 
      initialDate: _currentdate, 
      firstDate: DateTime(1990), 
      lastDate: DateTime(2040)
      );
      if (_seldate!=null) {
        setState(() {
          _currentdate1 = _seldate;
        });
      }
  }

 @override 
  Widget build(BuildContext context){
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.height;
    String _formatdate = new DateFormat('yyyy-MM-dd').format(_currentdate);
    String _formatdate1 = new DateFormat('yyyy-MM-dd').format(_currentdate1);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélection de date"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectdate(context);
                            },
                          ),

                          Text("Du : $_formatdate", style: TextStyle(fontWeight: FontWeight.bold)),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),

                        ],
                      ),
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectdate1(context);
                            },
                          ),

                          Text("Au : $_formatdate1", style: TextStyle(fontWeight: FontWeight.bold)),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40.0),

                    Container ( 
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: RaisedButton(
                                  color: Colors.blue,
                                  child:
                                    Text("Afficher", 
                                    style: TextStyle( 
                                      fontFamily: 'Montser',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    getData(_formatdate, _formatdate1);
                                  },
                                )
                              )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 50.0,),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Résultat de la requête",
                             textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Text(status, 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 40.0
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Product Sold...


class ProductSoldSeleteDate extends StatefulWidget {
  @override 
  _ProductSoldSelecteDate createState() => _ProductSoldSelecteDate();
}

class _ProductSoldSelecteDate extends State<ProductSoldSeleteDate> {
  bool visible = false;
  DateTime _currentdate = new DateTime.now();
  DateTime _currentdate1 = new DateTime.now();

  String errMessage = "Erreur de connexion";
  String status = '';
  // final String url = emUrl + "bulletinizer/api/authentication/compute_product_sold.php";
  final String url = emUrl + "authentication/compute_product_sold.php";

  setStatus(String message) {
    setState(() {
      status = message;
    }); 
  }

  Future getData(String date1, String date2) async {

    var datas = {'date1': date1, 'date2': date2 };

    var response = await http.post(url, body: datas);

    var result = jsonDecode(response.body);

    double price = result[0]['amount'] != null ? double.parse(result[0]['amount']): 0;
    // double nombre = result[0]['nombre'] != null ? double.parse(result[0]['nombre']): 0;
    // double amount = price * nombre;
    double amount = price;

    setState(() {
      setStatus(result[0]['amount'] != null ? '\$' + amount.toString(): 'Rien à signaler sur cette date.');
    });

 }


  Future<Null> _selectdate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
        context: context, 
        initialDate: _currentdate, 
        firstDate: DateTime(1990), 
        lastDate: DateTime(2040),
        builder: (context, child) {
          return SingleChildScrollView(child: child,);
        }
      );

       if(_seldate!=null) {
          setState(() {
            _currentdate = _seldate;
          });
        }
    }

  Future<Null>  _selectdate1(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
      context: context, 
      initialDate: _currentdate, 
      firstDate: DateTime(1990), 
      lastDate: DateTime(2040)
      );
      if (_seldate!=null) {
        setState(() {
          _currentdate1 = _seldate;
        });
      }
  }

  

 @override 
  Widget build(BuildContext context){
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.height;
    String _formatdate = new DateFormat('yyyy-MM-dd').format(_currentdate);
    String _formatdate1 = new DateFormat('yyyy-MM-dd').format(_currentdate1);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélection de date"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectdate(context);
                            },
                          ),

                          Text("Du : $_formatdate", style: TextStyle(fontWeight: FontWeight.bold)),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),

                        ],
                      ),
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectdate1(context);
                            },
                          ),

                          Text("Au : $_formatdate1", style: TextStyle(fontWeight: FontWeight.bold)),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40.0),

                    Container ( 
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: RaisedButton(
                                  color: Colors.blue,
                                  child:
                                    Text("Afficher", 
                                    style: TextStyle( 
                                      fontFamily: 'Montser',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    getData(_formatdate, _formatdate1);
                                  },
                                )
                              )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 50.0,),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Résultat de la requête",
                             textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Text(status, 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 40.0
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Expenses amount


class ExpensesSelectDate extends StatefulWidget {
  @override 
  _ExpensesSelectDate createState() => _ExpensesSelectDate();
}

class _ExpensesSelectDate extends State<ExpensesSelectDate> {
  bool visible = false;
  DateTime _currentdate = new DateTime.now();
  DateTime _currentdate1 = new DateTime.now();

  String errMessage = "Erreur de connexion";
  String status = '';
  // final String url = emUrl + "bulletinizer/api/authentication/compute_expense_amount.php";
  final String url = emUrl + "authentication/compute_expense_amount.php";

  setStatus(String message) {
    setState(() {
      status = message;
    }); 
  }

  Future getData(String date1, String date2) async {

    var datas = {'date1': date1, 'date2': date2 };

    var response = await http.post(url, body: datas);

    var result = jsonDecode(response.body);

    setState(() {
      
      setStatus(result[0]['amount'] != null ? '\$' + result[0]['amount']: 'Rien à signaler sur cette date.');
    });

 }


  Future<Null> _selectdate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
        context: context, 
        initialDate: _currentdate, 
        firstDate: DateTime(1990), 
        lastDate: DateTime(2040),
        builder: (context, child) {
          return SingleChildScrollView(child: child,);
        }
      );

       if(_seldate!=null) {
          setState(() {
            _currentdate = _seldate;
          });
        }
    }

  Future<Null>  _selectdate1(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
      context: context, 
      initialDate: _currentdate, 
      firstDate: DateTime(1990), 
      lastDate: DateTime(2040)
      );
      if (_seldate!=null) {
        setState(() {
          _currentdate1 = _seldate;
        });
      }
  }

 @override 
  Widget build(BuildContext context){
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.height;
    String _formatdate = new DateFormat('yyyy-MM-dd').format(_currentdate);
    String _formatdate1 = new DateFormat('yyyy-MM-dd').format(_currentdate1);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélection de date"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectdate(context);
                            },
                          ),

                          Text("Du : $_formatdate", style: TextStyle(fontWeight: FontWeight.bold)),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),

                        ],
                      ),
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectdate1(context);
                            },
                          ),

                          Text("Au : $_formatdate1", style: TextStyle(fontWeight: FontWeight.bold)),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40.0),

                    Container ( 
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: RaisedButton(
                                  color: Colors.blue,
                                  child:
                                    Text("Afficher", 
                                    style: TextStyle( 
                                      fontFamily: 'Montser',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    getData(_formatdate, _formatdate1);
                                  },
                                )
                              )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 50.0,),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Résultat de la requête",
                             textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Text(status, 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 40.0
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Voire tout extantion "picking date range"

class VoireToutSelectDate extends StatefulWidget{
  @override 
  _VoireToutSelectDate createState() => _VoireToutSelectDate();
}

class _VoireToutSelectDate extends State<VoireToutSelectDate> {
  bool visible = false;
  DateTime _currentdate = new DateTime.now();
  DateTime _currentdate1 = new DateTime.now();

  String errMessage = "Erreur de connexion";
  String cashinamount = '';
  String cashoutamount = '';
  String cashtotamount = '';
  // final String url = emUrl + "bulletinizer/api/authentication/compute_todo.php";
  final String url = emUrl + "authentication/compute_todo.php";

  // setStatusCashin(String cashin) {
  //   setState(() {
  //     cashinamount = cashin;
  //   }); 
  // }

  // setStatusCashout(String cashout) {
  //   setState(() {
  //     cashoutamount = cashout;
  //   }); 
  // }

  // setStatusCashtot(String totamount) {
  //   setState(() {
  //     cashoutamount = totamount;
  //   }); 
  // }

  setStatusCashin(String cashin, String cashout, String totamount) {
    setState(() {
      cashinamount = cashin;
      cashoutamount = cashout;
      cashtotamount = totamount;
    }); 
  }




  Future getData(String date1, String date2) async {

    var datas = {'date1': date1, 'date2': date2 };

    var response = await http.post(url, body: datas);

    var result = jsonDecode(response.body);

    print(result);

    double cashin = result[0]['cashin'] != null && result[0]['cashin'] != 0 ? double.parse(result[0]['cashin']): 0;
    double cashout = result[1]['cashaout'] != null && result[1]['cashaout'] != 0 ? double.parse(result[1]['cashaout']): 0;
    double totamount = cashin - cashout;


     setState(() {
        setStatusCashin(cashin.toString(), cashout.toString(), totamount.toString());
      });

    // if (result[0]['cashin'] != 0 && result[0]['cashaout'] == 0) {
    //   if (result[0]['cashin'] != null ){
    //     setState(() {
    //       setStatusCashin(result[0]['cashin'].toString());
    //     });
    //   }
    // }

    // else if (result[0]['cashaout'] != 0 && result[0]['cashin'] == 0) {
    //   if (result[0]['cashaout'] != null ){
    //     setState(() {
    //       setStatusCashout(result[0]['cashaout'].toString());
    //     });
    //   }
    // }

    // else if (result[0]['cashin'] != 0 && result[0]['cashaout'] == 0) {
    //   if (result[0]['cashin'] != null ){
    //     setState(() {
    //       setStatusCashin(cashin.toString(), cashout.toString(), totamount.toString());
    //     });
    //   }
    // }



  

 }


  Future<Null> _selectdate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
        context: context, 
        initialDate: _currentdate, 
        firstDate: DateTime(1990), 
        lastDate: DateTime(2040),
        builder: (context, child) {
          return SingleChildScrollView(child: child,);
        }
      );

       if(_seldate!=null) {
          setState(() {
            _currentdate = _seldate;
          });
        }
    }

  Future<Null>  _selectdate1(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
      context: context, 
      initialDate: _currentdate, 
      firstDate: DateTime(1990), 
      lastDate: DateTime(2040)
      );
      if (_seldate!=null) {
        setState(() {
          _currentdate1 = _seldate;
        });
      }
  }
  @override 
  Widget build(BuildContext context){
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.height;
    String _formatdate = new DateFormat('yyyy-MM-dd').format(_currentdate);
    String _formatdate1 = new DateFormat('yyyy-MM-dd').format(_currentdate1);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélection de date"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectdate(context);
                            },
                          ),

                          Text("Du : $_formatdate", style: TextStyle(fontWeight: FontWeight.bold)),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),

                        ],
                      ),
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectdate1(context);
                            },
                          ),

                          Text("Au : $_formatdate1", style: TextStyle(fontWeight: FontWeight.bold)),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40.0),

                    Container ( 
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: RaisedButton(
                                  color: Colors.blue,
                                  child:
                                    Text("Afficher", 
                                    style: TextStyle( 
                                      fontFamily: 'Montser',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    getData(_formatdate, _formatdate1);
                                  },
                                )
                              )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 50.0,),

                    Container(
                      height: _height/3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Résultat de la requête",
                             textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Container ( 
                            padding: EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  
                                  Container(
                                    
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("Entré", 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25.0
                                          ),
                                        ), 
                                        Text(cashoutamount, 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 25.0
                                          ),
                                        ), 
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 5.0,),


                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("Sortie", 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25.0
                                          ),
                                        ), 
                                        Text(cashinamount, 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 25.0
                                          ),
                                        ), 
                                      ],
                                    ),
                                  ),

                                 SizedBox(height: 5.0,),

                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("Solde", 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25.0
                                          ),
                                        ), 
                                        Text(cashtotamount, 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 25.0
                                          ),
                                        ), 
                                      ],
                                    ),
                                  ),

                                  // Text(cashoutamount, 
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //     color: Colors.black54,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 25.0
                                  //   ),
                                  // ), 

                                  // Text(cashtotamount, 
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //     color: Colors.black54,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 25.0
                                  //   ),
                                  // ), 

                                ],
                              ),
                            ),
                          )

                          

                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
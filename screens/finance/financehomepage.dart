
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nankim_s/screens/api.dart';
import 'package:nankim_s/screens/finance/caisse_page/expenses.dart';
import 'package:nankim_s/screens/finance/caisse_page/sold.dart';
import 'package:nankim_s/screens/finance/fiche_paie_page/employeeinfo.dart';
// import 'package:nankim_s/screens/finance/entrecaissepage.dart';
// import 'package:nankim_s/screens/finance/fichepaiepage.dart';
import 'package:nankim_s/screens/finance/paiement_page/suiviepayment.dart';
// import 'package:nankim_s/screens/finance/livrecaissepage.dart';
// import 'package:nankim_s/screens/finance/paiementpage.dart';
// import 'package:nankim_s/screens/finance/soldecaissepage.dart';
import 'package:nankim_s/screens/finance/caisse_page/payment.dart';
import 'package:nankim_s/screens/finance/caisse_page/voirtout.dart';
import 'package:nankim_s/screens/info.dart';
import 'package:nankim_s/screens/loginpage.dart';
import 'package:nankim_s/screens/settings.dart';

class FinanceHome extends StatefulWidget{
  const FinanceHome({Key key}):super(key: key);

  @override 
  _FinanceHome createState() => _FinanceHome();
}

class _FinanceHome extends State<FinanceHome> with SingleTickerProviderStateMixin{
  DateTime _datetime = DateTime.now();

  ModuleDailyStudentPayment _voir;
  ModuleDailySold _voirsold;
  ModuleDailyExpenses _voirexpenses;
  List<ModuleDailyStudentPayment> _moduleDailyStudentPayment;
  // final  AccessRapportDailyCaisse _accessRapportDailyCaisse = AccessRapportDailyCaisse();

  List<ModuleDailyExpenses> _moduleDailyExpense;
  List<ModuleDailySold> _moduleDailySold;


  @override 
  void initState() {
    super.initState();
    _moduleDailyExpense = [];
    _moduleDailyStudentPayment = [];
    _moduleDailySold = [];
    _getExpenses();
    _getDailyStudentPayment();
    _getProductSold();
   
  }



  _getExpenses() {
     getDailyExpenses().then((getamount) {
      setState(() {
        _moduleDailyExpense = getamount;
      });
    });
  }

  _getDailyStudentPayment() {
    getDailyStudentPayment().then((getamount) {
      setState(() {
        _moduleDailyStudentPayment = getamount;
      });
    });
  }

  _getProductSold() {
     getDailySold().then((getamount) {
      setState(() {
        _moduleDailySold = getamount;
      });
    });
  }

Widget studentPayment() {
    return FutureBuilder(
      future: getDailyStudentPayment(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            // itemCount: snapshot.data.length,
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
                _voir = snapshot.data[index];
                if(_voir.studentpayment != null && _voir.studentpayment != 'null'){
                  double studentpayment =  double.parse(_voir.studentpayment);           
                  return Container(
                    height: 170.0,
                    child:  Card(
                      elevation: 1.0,
                      color: Colors.white,
                        child: Column (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container (
                            height: 60.0,
                            padding: EdgeInsets.all(0.0),
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: ListTile(
                              title: Text("Paiement", 
                                style: TextStyle(
                                  color: Colors.blue, 
                                  fontWeight: FontWeight.w600,

                                ),
                                ),
                              subtitle: Text("Paiement total des élèves"),
                              trailing: Text(
                                "${_datetime.year}-${_datetime.month}-${_datetime.day}",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),

                        Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            title: Text(
                              '$studentpayment',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 40.0,
                                color: Colors.black38,
                              ),
                            ),
                            trailing: Icon(Icons.more_vert),

                            onTap: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => StudentPayment()

                                )
                              );
                            },
                          ),
                        )
                        ],
                      )
                    ),
                  );
                } 
                return Container(
                  height: 170.0,
                  child:  Card(
                    elevation: 1.0,
                    color: Colors.white,
                      child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container (
                          height: 60.0,
                          padding: EdgeInsets.all(0.0),
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            title: Text("Paiement", 
                              style: TextStyle(
                                color: Colors.blue, 
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                            subtitle: Text("Paiement total des élèves"),
                            trailing: Text(
                              "${_datetime.year}-${_datetime.month}-${_datetime.day}",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),

                      Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            title: Text(
                              'Aucaune opération!',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20.0,
                                color: Colors.black38,
                              ),
                            ),
                            trailing: Icon(Icons.more_vert),

                            onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => StudentPayment()

                                  )
                                );
                              },
                          ),
                        )
                      ],
                    )
                  ),
                );
            });
        }

        return Center(child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            CircularProgressIndicator()
          ],));
      },
    );
  }
  


// =======================================PRODUCT SOLD ======================================================

  Widget productSold() {
    return FutureBuilder(
      future: getDailySold(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
                _voirsold = snapshot.data[index];
                if(_voirsold.productsold != null && _voirsold.productsold != 'null' ){
                  double totsum = double.parse(_voirsold.productsold);
                  return Container(
                    height: 170.0,
                    child:  Card(
                      elevation: 1.0,
                      color: Colors.white,
                        child: Column (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container (
                            height: 60.0,
                            padding: EdgeInsets.all(0.0),
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: ListTile(
                              title: Text("Vente", 
                                style: TextStyle(
                                  color: Colors.blue, 
                                  fontWeight: FontWeight.w600,

                                ),
                                ),
                              subtitle: Text("Ventes du jour"),
                              trailing: Text(
                                "${_datetime.year}-${_datetime.month}-${_datetime.day}",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),

                         Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            title: Text(
                              '$totsum',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 40.0,
                                color: Colors.black38,
                              ),
                            ),
                            trailing: Icon(Icons.more_vert),

                            onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => RapSold()

                                  )
                                );
                              },
                          ),
                        )
                        ],
                      )
                    ),
                  );
                } 
                return Container(
                  height: 170.0,
                  child:  Card(
                    elevation: 1.0,
                    color: Colors.white,
                      child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container (
                          height: 60.0,
                          padding: EdgeInsets.all(0.0),
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            title: Text("Ventes", 
                              style: TextStyle(
                                color: Colors.blue, 
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                            subtitle: Text("Ventes du jour"),
                            trailing: Text(
                              "${_datetime.year}-${_datetime.month}-${_datetime.day}",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => RapSold()

                                  )
                                );
                              },
                          ),
                        ),

                       Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            title: Text(
                              'Aucaune opération!',
                              // _voir.error,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20.0,
                                color: Colors.black38,
                              ),
                            ),
                            trailing: Icon(Icons.more_vert),

                            onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => RapSold()

                                  )
                                );
                              },
                          ),
                        )
                      ],
                    )
                  ),
                );
            });
        }
        // return Center(child: CircularProgressIndicator());
        return Center(child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            CircularProgressIndicator()
          ],));
      },
    );
  }

  // // ============================================================================================

  Widget expenses() {
              // print("${_voirexpenses.expenses}, ========================")
    return FutureBuilder(
      future: getDailyExpenses(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
                _voirexpenses = snapshot.data[index];
                if(_voirexpenses.expenses != null && _voirexpenses.expenses != 'null'){
                  double _expenses = double.parse(_voirexpenses.expenses);
                  return Container(
                    height: 170.0,
                    child:  Card(
                      elevation: 1.0,
                      color: Colors.white,
                        child: Column (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container (
                            height: 60.0,
                            padding: EdgeInsets.all(0.0),
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: ListTile(
                              title: Text("Dépenses", 
                                style: TextStyle(
                                  color: Colors.blue, 
                                  fontWeight: FontWeight.w600,

                                ),
                                ),
                              subtitle: Text("Dépenses du jour"),
                              trailing: Text(
                                "${_datetime.year}-${_datetime.month}-${_datetime.day}",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),

                         Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            title: Text(
                              '$_expenses',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 40.0,
                                color: Colors.black38,
                              ),
                            ),
                            trailing: Icon(Icons.more_vert),

                             onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => RapExpenses()

                                  )
                                );
                              },
                          ),
                        )
                        ],
                      )
                    ),
                  );
                } 
                return Container(
                  height: 170.0,
                  child:  Card(
                    elevation: 1.0,
                    color: Colors.white,
                      child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container (
                          height: 60.0,
                          padding: EdgeInsets.all(0.0),
                          margin: EdgeInsets.only(bottom: 20.0),

                          child: ListTile(
                            title: Text("Dépenses", 
                              style: TextStyle(
                                color: Colors.blue, 
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                            subtitle: Text("Dépenses du jour"),
                            trailing: Text(
                              "${_datetime.year}-${_datetime.month}-${_datetime.day}",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => RapExpenses()

                                  )
                                );
                              },
                          ),
                        ),

                       Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            title: Text(
                              'Aucaune opération!',
                              // _voir.error,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20.0,
                                color: Colors.black38,
                              ),
                            ),
                            trailing: Icon(Icons.more_vert),

                            onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => RapExpenses()

                                  )
                                );
                              },
                          ),
                        )
                      ],
                    )
                  ),
                );

            });
        }
          
        //  return Center(child: CircularProgressIndicator());
        return Center(child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            CircularProgressIndicator()
          ],));
      },
    );
  }
  

// ==================================================================================
// ===================================================================================
  
  // logout(BuildContext context) {
  //   Navigator.pop(
  //     context, 
  //     MaterialPageRoute(builder: (context) => LoginPage())
  //   );
  // }

  @override 
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold ( 
      appBar: AppBar(
        // title: Text('Activités'), 
        title: Text("Opérations de caisse"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: () {
              _getDailyStudentPayment();
              _getExpenses();
              _getProductSold();
            }
            )
        ],
      ),

      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.account_balance,
                  size: 128.0,
                  color: Colors.white54,
                ),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              
              Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Livre de caisse'),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => RapportCaisse(),
                        )
                      );
                    },
                  ),

                  // ListTile(
                  //   leading: Icon(Icons.payment),
                  //   title: Text('Fiche de paie'),
                  //   onTap: (){
                  //     Navigator.push(
                  //       context, 
                  //       MaterialPageRoute(
                  //         builder: (context) => FichePaie(),
                  //       )
                  //     );
                  //   },
                  // ),

                  ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text('Suivie'),
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => CheckPayment(),
                        )
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Employés'),
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => EmployeeInfo(),
                        )
                      );
                    },
                  ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Parametre'),
                    onTap: (){
                       Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => RegistrationForm())
                        );
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('info'),
                    onTap: (){
                       Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => InfoPage())
                        );
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.arrow_left),
                    title: Text('Déconnecter'),
                    onTap: (){
                      Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => LoginPage())
                        );
                    },
                  ),
                ],
              )
              
            ],
          ),
        ),
        // ======================================================
        // Daily Activities 
        // ======================================================

        body: SafeArea(
          child: Container(
            height: _height,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                studentPayment(),
                productSold(),
                expenses(),
              ],
            )
          )
        )
    );
  }         
}


// Retrive Stydentpayment
class ModuleDailyStudentPayment {
  String studentpayment;

  ModuleDailyStudentPayment({this.studentpayment});

  factory ModuleDailyStudentPayment.fromJson(Map<String, dynamic> json) {
    return ModuleDailyStudentPayment(studentpayment: json['studentpayment'].toString(),);
  }
  Map<String, dynamic> toMap() => {"studentpayment": studentpayment, };
}

// Retrieve Sold product
class ModuleDailySold {
  String productsold;

  ModuleDailySold({this.productsold});
  factory ModuleDailySold.fromJson(Map<String, dynamic> json) {
    return ModuleDailySold(
      productsold: json["productsold"],
    );

  }
  Map<String, dynamic> toMap() => {
    "productsold": productsold,
  };
}

// Retreive expensens 
class ModuleDailyExpenses {

  String expenses;

  ModuleDailyExpenses({this.expenses});

  factory ModuleDailyExpenses.fromJson(Map<String, dynamic> json) {
    return ModuleDailyExpenses(expenses: json['expenses'].toString());
  }

  Map<String, dynamic> toMap() => {"expenses": expenses, };
}

DateTime now = DateTime.now();

String _formatdate = "${now.year}-${now.month}-${now.day}";

List<ModuleDailyStudentPayment> moduleDailyStudentPaymentFromJson(String str) => 
    List<ModuleDailyStudentPayment>.from(json.decode(str).map((x) => 
    ModuleDailyStudentPayment.fromJson((x))));


List<ModuleDailySold> moduleSoldFromJson(String str) => 
  List<ModuleDailySold>.from(json.decode(str).map((x) =>
  ModuleDailySold.fromJson((x))));

List<ModuleDailyExpenses> moduleExpensesFromJson(String str) => 
  List<ModuleDailyExpenses>.from(json.decode(str).map((x) => 
  ModuleDailyExpenses.fromJson((x))));


  Future<List<ModuleDailyStudentPayment>> getDailyStudentPayment() async {
    var todaydate = {"todaydate": _formatdate};
    // String url = emUrl + "bulletinizer/api/rapports?state=daily_student_payment";
   
    String url = emUrl + "rapports?state=daily_student_payment";
    final response = await http.post(url, body: todaydate);
    return moduleDailyStudentPaymentFromJson(response.body);
  }

  Future<List<ModuleDailySold>> getDailySold()  async {
    var todaydate = {"todaydate": _formatdate};
    // String url = emUrl + "bulletinizer/api/rapports?state=daily_selling";
    String url = emUrl + "rapports?state=daily_selling";
    final response = await http.post(url, body: todaydate);
    return moduleSoldFromJson(response.body);
  }

  Future<List<ModuleDailyExpenses>> getDailyExpenses() async {
    var todaydate = {"todaydate": _formatdate};
    // String url= emUrl + "bulletinizer/api/rapports?state=daily_expenses";
    String url= emUrl + "rapports?state=daily_expenses";
    final response = await http.post(url, body: todaydate);
    return moduleExpensesFromJson(response.body);
  }













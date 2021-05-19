import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nankim_s/screens/api.dart';
import 'package:nankim_s/screens/finance/financehomepage.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginUserState createState() => LoginUserState();
}


class LoginUserState extends State with ChangeNotifier {
  // Checking internet connection
  StreamSubscription<DataConnectionStatus> listener;
  var Internetstatus = "Connexion...";
  var currentUser;

  @override
  void initState() {
    super.initState();
    // Update connection status
    checkInternet();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  checkInternet()  async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          Internetstatus = "Vous étes Connecté à Internet";
          setState(() {
            
          });
        break;

        case DataConnectionStatus.disconnected:
          Internetstatus = "Pas de connexion Internet";
          setState(() {
            
          });
        break;
      }
    });

    return await DataConnectionChecker().connectionStatus;
  }

  // Authentication session 

  authService() {
    print("new Authentication");
  }

  Future getUSer() {
    return Future.value(currentUser);
  }

  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }
  // For CircularProgressIndicator
  bool visible = false;

  // Getting value from textField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    // Showing circularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;


    // SERVER LOGIN API URL
    // var url = "http://10.0.2.2/bulletinizer/api/authentication/login_user.php";
    var url = emUrl + "bulletinizer/api/authentication/login.php";
    // var url = emUrl + "authentication/login_user.php";
    // var url  = emUrl + "authentication/login_user.php";
    // var url = "https://cslerocher.com/app/api/authentication/login_user.php";

    // Store all data with Param Name.
    var data = {'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into varaible.
    var message = jsonDecode(response.body);

    // If the CircularProgressIndicator

    if(message['message'] == "connexion...") {
      this.currentUser = {'email': message['username']};
      notifyListeners();
      setState(() {
        visible = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FinanceHome())
        );
      return Future.value(currentUser);
    }
    else {
      this.currentUser = null;
      // If Email or Password didn't matched.
      // Hidding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing alert Dialog with Response Json Message.
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );

      return Future.value(null);
    }
  }

  // void _onLoading() {
  //   showDialog(
  //     context: context, 
  //     barrierDismissible: false,
  //     builder: (BuildContext context){
  //       return Dialog(
  //         child: new Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             new CircularProgressIndicator(),

  //           ],
  //         ),
  //       );
  //     }
  //   );
  //   new Future.delayed(new Duration(seconds: 1), () {
  //     Navigator.pop(context);
  //   });
  // }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(  
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9]
              ),
            )
          ),

          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric( 
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'nanKim',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),

                Form(
                  // key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container( 
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        child: TextFormField(
                          controller: emailController,
                          autocorrect: true,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          decoration: new InputDecoration(labelText: "Email", 
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                              )
                            ),
                              validator: (val) => val.isNotEmpty? null : "Le nom d'utilisateur ne doit pas rester vide.",
                            ),
                        ),

                      SizedBox(height: 30.0),

                      Container( 
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        child: TextFormField(
                          controller: passwordController,
                          autocorrect: true,
                          cursorColor: Colors.white,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          decoration: new InputDecoration(
                            labelText: "*********", 
                            prefixIcon: Icon(
                              Icons.security,
                              color: Colors.white,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                              )
                          ),
                          validator: (val) => val.isNotEmpty? null : "Le mot depasse ne doit pas rester vide.",
                        ),
                      ),

                      SizedBox(height: 5.0),

                      // Container(
                      //   alignment: Alignment(1.0, 0.0),
                      //   padding: EdgeInsets.only(top:15.0, left:20.0),
                      //   child: InkWell(
                      //     child: Text('Mot de passe perdu?', 
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: 'Montserrat',
                      //       decoration: TextDecoration.underline
                      //     ),
                      //     ),
                      //   ),
                      // ), 

                      SizedBox(height: 40.0),

                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.white,
                          color: Colors.white,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: userLogin,
                            child: Center(
                              child: Text(
                                'CONNEXION',
                                style: TextStyle(
                                  color: Colors.black54, 
                                  fontWeight: FontWeight.bold, 
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.5,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 5.0),

                      Visibility(
                        visible: visible,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator(backgroundColor: Colors.white,),
                        ),
                      ),

                      Container ( 
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.white,
                          //     style: BorderStyle.solid,
                          //     width: 1.0,
                          //   ),
                          //   color: Colors.transparent,
                          //   borderRadius: BorderRadius.circular(20.0)
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center (
                                child: Text("$Internetstatus"),)
                              // Center(
                              //   child: Text("S'INSCRIRE", 
                              //   style: TextStyle( 
                              //     fontFamily: 'Montser',
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.white,
                              //   ),),
                              // )
                            ],
                          ),
                        ),
                      )

                    ]
                  )
                )
              ]
            )
          )
        ), 
        ]
      )
    );
  }               
}
import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nankim_s/screens/api.dart';
import 'package:nankim_s/screens/finance/financehomepage.dart';


class DeleteUserPage extends StatefulWidget {
  @override
  DeleteUserPag createState() => DeleteUserPag();
}


class DeleteUserPag extends State {
  // Checking internet connection
  StreamSubscription<DataConnectionStatus> listener;
  
  // For CircularProgressIndicator
  bool visible = false;

  // Getting value from textField widget.
  final formKey = GlobalKey<FormState>();
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
    // var url = emUrl + "authentication/login_user.php";
    // var url  = emUrl + "authentication/login_user.php";
    // var url = "https://cslerocher.com/app/api/authentication/login_user.php";

    // var url = emUrl + "bulletinizer/api/authentication/delete.php";

    var url = emUrl + "authentication/delete.php";

    // Store all data with Param Name.
    var data = {'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into varaible.
    var message = jsonDecode(response.body);

    // If the CircularProgressIndicator
    final form = formKey.currentState;
    form.save();

    if (form.validate()) {
      if(message['message'] == "Supprimé avec succès!") {
        
        setState(() {
          visible = false;
        });

        showDialog(
          context: context, 
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message['message']),
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
      }
    }
    else {
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
            title: new Text(message['message']),
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
    }
  }


  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Supper l'utilisateur"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric( 
                horizontal: 40.0,
                // vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                Center(
                  child: Text("Ne supprimez pas tous les comptes, vous devez toujours laisser un par défaut",
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                  )
                  ,),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container( 
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        child: TextFormField(
                          controller: emailController,
                          autocorrect: true,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.black54),
                          decoration: new InputDecoration(labelText: "Email", 
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black54,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
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
                          cursorColor: Colors.black,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.black54),
                          decoration: new InputDecoration(
                            labelText: "*********", 
                            prefixIcon: Icon(
                              Icons.security,
                              color: Colors.black54,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              )
                          ),
                          validator: (val) => val.isNotEmpty? null : "Le mot depasse ne doit pas rester vide.",
                        ),
                      ),

                      SizedBox(height: 40.0),

                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.lightBlue,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: userLogin,
                            child: Center(
                              child: Text(
                                'SUPPRIMER',
                                style: TextStyle(
                                  color: Colors.white, 
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
                          child: CircularProgressIndicator(),
                        ),
                      ),
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
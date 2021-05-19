import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:nankim_s/screens/api.dart';



class RegisterPage extends StatefulWidget {
  @override 
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {

   // For CircularProgressIndicator
  bool visible = false;

  // Getting value from textField widget.
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController1 = TextEditingController();

  Future userSignup() async {
    // Showing circularProgressIndicator.
    setState(() {
      visible = true;
    });

    String email = emailController.text;
    String password = passwordController.text;
    String password1 = passwordController1.text;
   
    final form = _formKey.currentState;
    form.save();

    // SERVER LOGIN API URL
    // var url = emUrl + "bulletinizer/api/authentication/signup.php";
    var url = emUrl + "authentication/signup.php";
    // var url = "https://cslerocher.com/app/api/authentication/login_user.php";
     
    if (form.validate()) {
      if(password == password1){
        // Store all data with Param Name.
        var data = {'email': email, 'password': password};

        // Starting Web API Call.
        var response = await http.post(url, body: json.encode(data));

        // Getting Server response into varaible.
        var message = jsonDecode(response.body);

        // If the CircularProgressIndicator

        if(message['message'] == "Enregistré avec succès") {
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
        else {
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
    }

    else {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Les mots de passe ne sont pas identique..."),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter utilisatuer"),
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
                  Form(
                    key: _formKey,
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
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black),
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

                        SizedBox(height: 30.0),

                        Container( 
                          alignment: Alignment.centerLeft,
                          height: 60.0,
                          child: TextFormField(
                            controller: passwordController1,
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


                        SizedBox(height: 30.0,),

                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.lightBlue,
                            color: Colors.blue,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: userSignup,
                              child: Center(
                                child: Text(
                                  'Enregistre',
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
          )
        ],
      ),
    );
  }
}
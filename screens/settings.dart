import 'package:flutter/material.dart';
import 'package:nankim_s/screens/deleteuser.dart';
import 'package:nankim_s/screens/signup.dart';



class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key key}) : super(key: key);

  @override 
  _RegisterFormState createState() => _RegisterFormState();

}

class _RegisterFormState extends State<RegistrationForm> {
 

 @override 
 Widget build(BuildContext conte) {
   return Scaffold(
    appBar: AppBar(
      title: Text("Parametre"),
     ),
    body: SafeArea(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             Card(
               child: ListTile(
                trailing: Icon(Icons.person_add),
                title: Text("Ajouter utilisateur"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage())
                  );
                },
              ),
             ),

             Card(
               child: ListTile(
                trailing: Icon(Icons.delete_sweep),
                title: Text("Supprimer l'utilisateur"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeleteUserPage())
                  );
                },
              ),
             )

            ],
          ),
        ),
      ),
    ),
   );
 }
}
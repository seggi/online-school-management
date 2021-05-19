

import 'package:flutter/material.dart';
import 'package:nankim_s/models/caissemodel.dart';


class HomePage extends StatefulWidget{
  const HomePage({Key key,}) : super(key: key);
  
  @override 
 _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container( 
          color: Colors.white70,
          width: _width, height: _height,
          padding: EdgeInsets.all(0.0),
          margin: EdgeInsets.all(0.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity / 3, height: 50.0,
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    elevation: 8.0,
                    child: Text(
                      'Finance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        backgroundColor: Colors.blueAccent,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        decorationColor: Colors.white,
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainListView(),//FinanceHome(),
                        )
                      );
                    },
                  ),
                ),
                Divider(color: Colors.white70, height: 40.0,),
                
                SizedBox(
                  width: double.infinity / 3, height: 50.0,
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    elevation: 8.0,
                    child: Text(
                      'Gestion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        backgroundColor: Colors.blueAccent,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        decorationColor: Colors.white,
                      ),
                    ),
                    onPressed: (){},
                  )
                ),
              ],
            ),
          ),
        ),
    );
  }
}
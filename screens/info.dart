import 'package:flutter/material.dart';



class InfoPage extends StatefulWidget {
  @override 
  _InfoPage createState() => _InfoPage();
}

class _InfoPage extends State {

  @override 
  Widget build(BuildContext context){
    return Scaffold (
      appBar: AppBar(title: Text("Info")),
      body: Container(
        child: Center(
          child: Text("nankim_s.0.1", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
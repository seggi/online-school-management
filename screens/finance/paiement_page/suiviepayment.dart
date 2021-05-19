import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nankim_s/screens/api.dart';

class CheckPayment extends StatefulWidget {
  @override
  _CheckPaymentState createState() => new _CheckPaymentState();
}

class _CheckPaymentState extends State<CheckPayment> {
  Future<http.Response> _responseFuture;

  @override
  void initState() {
    super.initState();
    // _responseFuture = http.get(emUrl+"bulletinizer/api/rapports?state=get_level");
    _responseFuture = http.post(emUrl+"rapports?state=get_level");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Les niveaux organiser"),
      ),
      body: new FutureBuilder(
        future: _responseFuture,
        builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
          if (!response.hasData) {
            return const Center(
              child: const Center(child: CircularProgressIndicator(),)
            );
          } else if (response.data.statusCode != 200) {
            return const Center(
              child: const Text('Erreur de chargement...'),
            );
          } else {
            List<dynamic> json = jsonDecode(response.data.body);
            return new MyExpansionTileList(json);
          }
        },
      ),
    );
  }
}


class MyExpansionTileList extends StatelessWidget {
  final List<dynamic> elementList;

  MyExpansionTileList(this.elementList);

  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList.forEach((element) {
      children.add(
        new MyExpansionTile(element['id'], element['level']),
      );
    });
    return children;
  }

  @override 
  Widget build(BuildContext context) {
    return new ListView(
      children: _getChildren(),
    );
  }
}


class MyExpansionTile extends StatefulWidget {
  final String id;
  final String level;
  MyExpansionTile(this.id, this.level);

  @override 
  State createState() => new MyExpansionTileState();
}

class MyExpansionTileState extends State<MyExpansionTile> {
  PageStorageKey _key;
  Future<http.Response> _responseFuture;
  // List _responseFuture;
  

  @override 
  void initState() {
    // var datas = ;
    super.initState();
    // var url = emUrl + "bulletinizer/api/rapports?state=student_statistics";
    var url = emUrl + "rapports?state=student_statistics";
    _responseFuture = http.post(url, body: {'degree': widget.id});
  }

  @override 
  Widget build(BuildContext context) {
    _key = new PageStorageKey('${widget.id}');
    return new ExpansionTile(
      key: _key,
      title: new Text(widget.level),
      children: <Widget>[
        new FutureBuilder(
          future: _responseFuture,
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> response) {
            if (!response.hasData) {
              return const Center(
                child: const Text('Chargement...'),
              );
            } else if (response.data.statusCode != 200) {
              return const Center(
                child: const Text('Erreur de chargement'),
              );
            } else {
              List<dynamic> json = jsonDecode(response.data.body);

              List<Widget> reasonList = [];

              json.forEach((element) {
                var showfrais = element['frais'] != null && element['frais'] != 'null' ? element['frais'] : 'Rien à signaler.';
                var showsomme  = element['somme'] != null && element['somme'] != '0' ? element['somme'] : 'Rien à signaler.';
                  reasonList.add(
                    new ListTile(
                    dense: true,
                    title: new Text(showfrais,
                      style: TextStyle( 
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    subtitle: new Text(showsomme,
                      style: TextStyle( 
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.red, 
                      ),
                    ),
                  )
                );
              });

              return new Column(children: reasonList);
            }
          },
        )
      ],
    );
  }
}

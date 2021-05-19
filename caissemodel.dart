import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nankim_s/models/services.dart';

List<AdminData> adminDataFromJson(String str) => List<AdminData>.from(json.decode(str).map((x)=> AdminData.fromJson(x)));
String adminDataToJson(List<AdminData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class AdminData{
  String idAdm;
  String user;
  String pword;
  String nom;
  String postnom;
  String titre;
  String status;

  AdminData({this.idAdm, this.user, this.pword, this.nom,
            this.postnom, this.titre, this.status});

  factory AdminData.fromJson(Map<String, dynamic> json){
    return AdminData(
      idAdm: json['idAdm'],
      user: json['user'],
      pword: json['pword'],
      nom: json['nom'],
      postnom: json['postnom'],
      titre: json['titre'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() => {
      'idAdm': idAdm,
      'user': user,
      'pword': pword,
      'nom': nom,
      'postnom': postnom,
      'titre': titre,
      'status': status,
  }; 
}


Future<List<AdminData>> fetchProducts() async {
  String url ="http://10.0.2.2/nankim_s_server/server.php";
  final  response =  await http.get(url);
  return adminDataFromJson(response.body);
} 

class ManageResult{

  final String uri = "put yout url";

  Future<List<AdminData>> fetchData() async {
    
    var response = await http.get(uri);
    if(response.statusCode == 200){
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<AdminData> listOfFruits = items.map<AdminData>((json) {
        return AdminData.fromJson(json);
      }).toList();

      return listOfFruits;
    }
    else {
      throw Exception('Failed to load data');
    }

  }

  

}

class MainListView extends StatefulWidget{
  MainListView({Key key}) : super(key : key);

  @override
  MainListViewState createState() =>  MainListViewState();

}

class MainListViewState extends State<MainListView> {
  List<AdminData> admindata;

  @override 
  Widget build(BuildContext context){
    fetchProducts().then((data) => data.forEach((value) => print(value.nom)));
    return Scaffold(
       appBar: AppBar(title: Text('test'),),
       body: Container(
        child: FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index){
                AdminData admin = snapshot.data[index];
                return Text(admin.nom);
              }
            );
          }
        )
       )
      );
  }

}


   

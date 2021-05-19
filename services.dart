import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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
  String url ="http://localhost/nankim_s_server/server.php";
  final  response =  await http.get(url);
  return adminDataFromJson(response.body);
} 


recieveIt(List value){
  return value;
}
checkList() async{
  var names = fetchProducts().then((value) => value.forEach((data) => print(data.idAdm)));
  
}

main(List<String> args) {
  var marks = "A";
  switch(marks){
    case "A": { print("Very Good");}
    break;

    case "B": { print("Very Bad");}
    break;

    case "C": { print('Fair');}
    break;

    default: { print("Fail");}
    break;
  }
}




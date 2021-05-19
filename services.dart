// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;


// class Services {
//   static const ROOT = 'https://http://localhost/nankim_s_server/nankim_s_script.php';
//   static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
//   static const _GET_ALL_ACTION = 'GET_ALL';
//   static const _ADD_EMPP_ACTION = 'ADD_EMP';
//   static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
//   static const _DELETE_EMP_ACTION = 'DELETE_EMP';

//   // Method to create the table Emplopyee.
//   static Future<String> createTable() async {
//     try {
//       // add the parameters to pass to the request.
//       var map = Map<String, dynamic>();
//       map['action'] = _CREATE_TABLE_ACTION;
//       final response  = await http.post(ROOT, body: map);
//       print('Create Table Response: ${response.body}');
//       if(200 == response.statusCode){
//         return response.body;
//       }else{
//         return 'error';
//       } 
//     } 

//     catch (e){
//         return "error";
//     }

//   }

//  // Method to Retrieve from Database....
//   Future<List<RapportCaisse>> getRapCaisse() async {
//     try{
//       var map = Map<String, dynamic>();
//       map['action'] = _GET_ALL_ACTION;
//       final response = await http.post(ROOT, body: map);
//       print('getRapCaisse Response: ${response.body}');
//       if(200 == response.statusCode){
//         final items = json.decode(response.body).cast<Map<String, dynamic>>();
//         List<RapportCaisse> listOfFruits = items.map<RapportCaisse>((json) {
//         return RapportCaisse.fromJson(json);
//       }).toList();
//       return listOfFruits;
//       }else {
//         return List<RapportCaisse>();
//       }
//     }
//     catch (e) {
//       return List<RapportCaisse>();
//     }
//   }

//   // Method to add employee to the database...
//   static Future<String> adminRegister(String firstName, String lastName) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _ADD_EMPP_ACTION;
//       map['first_name'] = firstName;
//       map['last_name'] = lastName;
//       final response = await http.post(ROOT, body: map);
//       print('Register Admin response: ${response.body}');
//       if(200 == response.statusCode){
//         return response.body;
//       } else {
//         return "error";
//       }
//     }
//     catch (e){
//       return "error";
//     }
//   }

//   // Method to update an Admin in Database...
//   static Future<String> updateAdmin(String adminId, String firstName, String lastName) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _UPDATE_EMP_ACTION;
//       map['emp_id'] = adminId;
//       map['first_name'] = firstName;
//       map['last_name'] = lastName;
//       final response = await http.post(ROOT, body: map);
//       print('update Admin Response: ${response.body}');
//       if(200 == response.statusCode){
//         return response.body;
//       } else {
//         return "error";
//       }
//     }
//     catch (e){
//       return "error";
//     }
//   }

//   // Method to Delete an Admin from Database....
//   static Future<String> deleteAdmin(String empId) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _DELETE_EMP_ACTION;
//       map['emp_id'] = empId;
//       final response = await http.post(ROOT, body: map);
//       print('delete Admin Response: ${response.body}');
//       if (200 == response.statusCode) {
//         return response.body;
//       } else {
//         return "error";
//       }
//     } catch (e) {
//       return "error"; // returning just an "error" string to keep this simple...
//     }
//   }

// }


// class RapportCaisse {
//   String id;
//   String firstname;
//   String lastname;

//   RapportCaisse({this.id, this.firstname, this.lastname});

//   factory RapportCaisse.fromJson(Map<String, dynamic> json){
//     return RapportCaisse(
//       id: json['id'],
//       firstname: json['firstname'],
//       lastname: json['lastname'],
//      );
//   }

// }

// // To be used later
// // _getRapCaisse() {
// //   _showProgress('Loading Employees...');
// //   Services.getRapCaisse().then((rapportcaisse){
// //     setState((){
// //       _rapportcaisse = rapportcaisse;
// //     });
// //     _showProgress(widget.title); // Reset the title...
// //     print("Length ${rapportcaisse.length}");
// //   });
// // }

// main(List<String> args) {
//   Services.createTable().then((result) => print('$result'));
// }

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




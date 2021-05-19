// import 'package:http/http.dart' as http;

// import 'modules.dart';


// class ViewLivreCaisse{
//   Future<List<ModuleVoirTout>> getLivreCaisse() async {
//     String url ="http://localhost/nankim_s_server/server.php";
//     final response = await http.get(url);
//     return moduleVoirToutFromJson(response.body);
//   }

// }

// //10.0.2.2
// import 'dart:convert';
// import 'package:http/http.dart' as http;

//  getDailyRapportCaisse() async {
//     String url = "http://10.0.2.2:800/shule/api/global_result/";
//     var response = await http.get(url);
//     print('Seggi');
//     var message = jsonDecode(response.body);

//   }

// main(List<String> args) {
//   print('seggi');
// }
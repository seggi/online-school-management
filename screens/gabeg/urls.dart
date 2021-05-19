// String url = "http://192.168.43.53/bulletinizer/api/rapports?state=sell_check_out";
// String url = "http://192.168.43.53/bulletinizer/api/rapports?state=check_out";
// String url = "http://192.168.43.53/bulletinizer/api/rapports?state=withdrawal";
// String url = "http://192.168.43.53/bulletinizer/api/rapports?state=sell_check_out";




// Future userLogin() async {
//     // Showing CircularProgressIndicator.
//     setState(() {
//       visible = true;
//     });

//     // Getting value from Controller
//     String email = emailController.text;
//     String password = passwordController.text;

//     // SERVER LOGIN API URL
//     // var url = "http://10.0.2.2:8000/shule/api/super_user/account/login/";
//     var url = "http://10.42.0.1:8000/shule/api/super_user/account/login/";

//     // Store all data with Param Name.
//     // var data =  {'email': email, 'password': password};

//     // Starting Web API call.
//     var  response = await http.post(url, body: {
//       "email": email,
//       "password": password,
//       "fcm_token": "nankim_fcm_tokem"
//     });

//     // Getting Server response into variable.
//     final data = jsonDecode(response.body);
//     int value = data['value'];
//     String message = data['msg'];
//     String emailAPI = data['email'];
//     String usernameAPI = data['username'];
    

//     // If the Response validation is_valid.
//     if( message == "You're logged in." ) {
//       // Hidding the CircularProgressIndicator.
//       setState(() {
//         visible = false;
//       });

//       // Navigate to Home Screen & Next Screen.
//       Navigator.push(
//         context, 
//         MaterialPageRoute(builder: (context) => FinanceHome()));

//     }else {
//       // If Email or Password did not Matched.
//       // Hiding the CircularProgressIndicator.
//       setState((){
//         visible = false;
//       });

//       // Showing Alert Dialog with Response JSON Message.
//       showDialog(
//         context: context, 
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: new Text(message),
//             actions: <Widget>[
//               FlatButton(
//                 child: new Text("OK"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ]
//           );
//         }
//       );
//     }

//   }
// ===================================================================================



// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:nankim_s/models/caissemodel.dart';
// import 'package:nankim_s/screens/finance/caisse_page/localdb.dart';
// import 'package:nankim_s/screens/finance/financehomepage.dart';
// import 'package:shared_preferences/shared_preferences.dart'; 

// // import 'package:nankim_s/screens/homepage.dart';


// // Login requerst

// // class LoginRequest {
  
// // }




// class LoginPage extends StatefulWidget {
//   const LoginPage({Key key}) : super(key: key);

//   @override 
//   _LoginPage createState() => _LoginPage();

// }

// enum LoginStatus { notSignIn, signIn }

// class _LoginPage extends State<LoginPage> implements LoginCallBack{
//   bool visible = false;

//   final NanKimDB nanKimDB = new NanKimDB();
  
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final formKey = new GlobalKey<FormState>();
//   final scaffoldKey = new GlobalKey<ScaffoldState>();

//   AccountData accountData;

 
 

//   // Future<AccountData> userLogin(String email, String password) async {
//   //   String username;

//   //   AccountData saveUser = AccountData.fromMap({email: "test@test.com", password: "12345678", username: 'admin',});

//   //   await nanKimDB.registerUser(saveUser).then((val) async {

//   //     AccountData user = await nanKimDB.userLogin(email, password);
//   //     return user;
//   //     // if (val == 1) {
//   //     //   // AccountData user = await nanKimDB.userLogin(email, password);
//   //     //   // print("seggi oooooooooooooooooooooo $user");
//   //     //   // return user;
//   //     // }
//   //     // return "User doesn't exist!";
//   //   });

//   // }

//   @override 
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(  
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFF73AEF5),
//                   Color(0xFF61A4F1),
//                   Color(0xFF478DE0),
//                   Color(0xFF398AE5),
//                 ],
//                 stops: [0.1, 0.4, 0.7, 0.9]
//               ),
//             )
//           ),

//           Container(
//             height: double.infinity,
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               padding: EdgeInsets.symmetric( 
//                 horizontal: 40.0,
//                 vertical: 120.0,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'nanKim',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'OpenSans',
//                       fontSize: 30.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 30.0),

//                 Form(
//                   key: formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container( 
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                           controller: emailController,
//                           autocorrect: true,
//                           cursorColor: Colors.white,
//                           keyboardType: TextInputType.emailAddress,
//                           style: TextStyle(color: Colors.white),
//                           decoration: new InputDecoration(labelText: "Email", 
//                             prefixIcon: Icon(
//                               Icons.person,
//                               color: Colors.white,
//                             ),
//                             labelStyle: TextStyle(
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white54,
//                               )
//                             ),
//                               validator: (val) => val.isNotEmpty? null : "Le nom d'utilisateur ne doit pas rester vide.",
//                             ),
//                         ),

//                       SizedBox(height: 30.0),

//                       Container( 
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                           controller: passwordController,
//                           autocorrect: true,
//                           cursorColor: Colors.white,
//                           obscureText: true,
//                           keyboardType: TextInputType.emailAddress,
//                           style: TextStyle(color: Colors.white),
//                           decoration: new InputDecoration(
//                             labelText: "*********", 
//                             prefixIcon: Icon(
//                               Icons.lock,
//                               color: Colors.white,
//                             ),
//                             labelStyle: TextStyle(
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white54,
//                               )
//                           ),
//                           validator: (val) => val.isNotEmpty? null : "Le mot depasse ne doit pas rester vide.",
//                         ),
//                       ),

//                       SizedBox(height: 5.0),

//                       Container(
//                         alignment: Alignment(1.0, 0.0),
//                         padding: EdgeInsets.only(top:15.0, left:20.0),
//                         child: InkWell(
//                           child: Text('Mot de passe perdu?', 
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Montserrat',
//                             decoration: TextDecoration.underline
//                           ),
//                           ),
//                         ),
//                       ), 

//                       SizedBox(height: 40.0),

//                       Container(
//                         height: 40.0,
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20.0),
//                           shadowColor: Colors.white,
//                           color: Colors.white,
//                           elevation: 7.0,
//                           child: GestureDetector(
//                             onTap: _submit,
//                             // onTap: () async {
//                             //   setState(() => _isLoading =true);
//                             //   AccountData user = await userLogin(emailController.text, passwordController.text);
//                             //   setState(() => _isLoading = false);

//                             //   if (user != null) {
//                             //     Navigator.push(
//                             //     context, 
//                             //     MaterialPageRoute(builder: (context) => FinanceHome()));
//                             //   }

//                             //   else {
//                             //     showDialog(
//                             //       context: context, 
//                             //       builder: (BuildContext context) {
//                             //         return AlertDialog(
//                             //           title: new Text("Le mot de pass ou l'email n'est pas correct."),
//                             //           actions: <Widget>[
//                             //             FlatButton(
//                             //               child: new Text("OK"),
//                             //               onPressed: () {
//                             //                 Navigator.of(context).pop();
//                             //               },
//                             //             )
//                             //           ]
//                             //         );
//                             //       }
//                             //     );
//                             //   }
//                             // }, 
//                             child: Center(
//                               child: Text(
//                                 'CONNEXION',
//                                 style: TextStyle(
//                                   color: Colors.black54, 
//                                   fontWeight: FontWeight.bold, 
//                                   fontFamily: 'OpenSans',
//                                   letterSpacing: 1.5,
//                                   fontSize: 18.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 40.0),

//                       Container(
//                         height: 40.0,
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20.0),
//                           shadowColor: Colors.white,
//                           color: Colors.white,
//                           elevation: 7.0,
//                           child: GestureDetector (
//                             onTap: () {
//                                Navigator.push(
//                                 context, 
//                                 MaterialPageRoute(builder: (context) => FinanceHome()));
//                             },
//                             child: Center( 
//                               child: Text(
//                                 "S'INSCRIRE",
//                                 style: TextStyle(
//                                     color: Colors.transparent, 
//                                     fontWeight: FontWeight.bold, 
//                                     fontFamily: 'OpenSans',
//                                     letterSpacing: 1.5,
//                                     fontSize: 18.0,
//                                   ),
//                                 ),
                             
//                               ),
//                             ),
                          
//                         )
//                       )

//                     ]
//                   )
//                 )
//               ]
//             )
//           )
//         ), 
//         ]
//       )
//     );
//   }
                            
//   // void userLogin() {
//   //   if(formKey.currentState.validate()) {

//   //   }
//   // }
// }



// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




// import 'dart:io' ;
// import 'dart:async';
// import 'dart:typed_data';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';


// // class NanKimDB {
// //   Database _database;

// //   Future openDb() async {
// //     var databasesPath = await getDatabasesPath();
// //     var path = join(databasesPath, "shule.db");

// //     await deleteDatabase(path);

// //     try {
// //       await Directory(dirname(path)).create(
// //         recursive: true 
// //       );
// //     }catch (_) {}

// //     ByteData data = await rootBundle.load(join("assets", "shule.db"));
// //     List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
// //     await new File(path).writeAsBytes(bytes, flush: true);

// //     _database = await openDatabase(path, readOnly: false);
// //   }


// //   Future<List<AccountData>> getAccountData() async {
// //     await openDb();
// //     final List<Map<String, dynamic>> maps = 
// //       await _database.query('adminaccount');
// //       return List.generate(maps.length, (i) {
// //         return AccountData( 
// //           id: maps[i]['id'],
// //           username: maps[i]['username'],
// //           email: maps[i]['email'],
// //           password: maps[i]['password'],
// //         );
// //       }
// //     );
// //   }

// //   Future<int> registerUser(AccountData account) async {
// //     await openDb();
// //     return await _database.insert('adminaccount', account.toMap(),
// //     conflictAlgorithm: ConflictAlgorithm.replace);
// //   }

// //   Future<void> updateAccount(AccountData account) async {
// //     await openDb();
// //     await _database.update('adminaccount', account.toMap(),
// //       where: "id = ?", whereArgs: [account.id]);
// //   }

// //   Future<AccountData> userLogin(String email, String password) async {
// //     await openDb();
// //     var res = await _database.rawQuery("SELECT * FROM adminaccount WHERE username = '$email' and password = '$password' ");

// //     if (res.length > 0) {
// //       return new AccountData.fromMap(res.first);
// //     }

// //     return null;
// //   }

// // }

// class NanKimDB {  
//   static final NanKimDB _instance = new NanKimDB.internal();  
//   factory NanKimDB() => _instance;  
  
//   static Database _db;  
  
//   Future<Database> get db async {  
//     if (_db != null) {  
//       return _db;  
//     }  
//     _db = await initDb();  
//     return _db;  
//   }  
  
//   NanKimDB.internal();  
  
//   initDb() async {  
//     Directory documentDirectory = await getApplicationDocumentsDirectory();  
//     String path = join(documentDirectory.path, "nkshule.db");  
      
//     // Only copy if the database doesn't exist  
//     //if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){  
//       // Load database from asset and copy  
//       ByteData data = await rootBundle.load(join('data', 'shule.db'));  
//       List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);  
  
//       // Save copied asset to documents  
//       await new File(path).writeAsBytes(bytes);  
//     //}  
  
//     var ourDb = await openDatabase(path);  
//     return ourDb;  
//   }  
// }  



// class AdminLogin {
//   NanKimDB con = new NanKimDB();
//   //insertion  
//   Future<int> saveUser(AccountData user) async {  
//     var dbClient = await con.db;  
//     int res = await dbClient.insert("User", user.toMap());  
//     return res;  
//   }  
  
//   //deletion  
//   Future<int> deleteUser(AccountData user) async {  
//     var dbClient = await con.db;  
//     int res = await dbClient.delete("User");  
//     return res;  
//   }  
  
//   Future<AccountData> getLogin(String user, String password) async {  
//     var dbClient = await con.db;  
//     var res = await dbClient.rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");  
      
//     if (res.length > 0) {  
//       return new AccountData.fromMap(res.first);  
//     }  
  
//     return null;  
//   }  
  
//   Future<List<AccountData>> getAllUser() async {  
//     var dbClient = await con.db;  
//     var res = await dbClient.query("user");  
      
//     List<AccountData> list =  
//         res.isNotEmpty ? res.map((c) => AccountData.fromMap(c)).toList() : null;  
  
//     return list;  
//   }  

// }


// abstract class LoginCallBack {  
//   void onLoginSuccess(AccountData user);  
//   void onLoginError(String error);  
// }  
  
// class LoginResponse {  
//   LoginCallBack _callBack;  
//   LoginRequest loginRequest = new LoginRequest();  
//   LoginResponse(this._callBack);  
  
//   doLogin(String username, String password) {  
//     loginRequest  
//         .getLogin(username, password)  
//         .then((user) => _callBack.onLoginSuccess(user))  
//         .catchError((onError) => _callBack.onLoginError(onError.toString()));  
//   }   
// }  

// class LoginRequest {  
//   AdminLogin con = new AdminLogin();  
  
//  Future<AccountData> getLogin(String username, String password) {  
//     var result = con.getLogin(username,password);  
//     return result;  
//   }  
// }  

// class AccountData {
//   int id;
//   String username;
//   String email;
//   String phone;
//   String password;

//   AccountData({@required this.id, this.username, this.email, this.password});
//   Map<String, dynamic> toMap()  {
//     return {
//       'id': id,
//       'username': username,
//       'email': email,
//       'password': password
//     };
//   }

//   AccountData.fromMap(Map<String, dynamic> map) {
//     this.id = map['id'];
//     this.username = map['username'];
//     this.email = map['email'];
//     this.password = map['password'];
//   }

//   int get userId => id;
//   String get userName => username;
//   String get userEmail => email;
//   String get userPassword => password;

// }







// // User login 

// // class UserLogin {
// //   int id;
// //   String username;
// //   String password;

// //   UserLogin(this.username, this.password);
  
// //   UserLogin.fromMap(dynamic user) {
// //     this.username = user['username'];
// //     this.password = user['password'];

// //   }

// //   String get _username => username;
// //   String get _password => _password;

// //   Map<String , dynamic> toMap() {
// //     var map =  new Map<String, dynamic>();
// //     map["username"] = username;
// //     map["password"] = password;
// //     return map;
// //   }
// // }

// // Rapport de caisse 

// class RapportCaisse {
//   String id;
//   String date;
//   String designation;
//   String debit;
//   String credit;

//   RapportCaisse({@required this.id, this.date, this.designation, this.debit, this.credit});
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'date': date,
//       'designation': designation,
//       'debit': debit,
//       'credit': credit,
//     };
//   }

//   RapportCaisse.fromMap(Map<String, dynamic> map) {
//     this.id = map['id'];
//     this.date = map['date'];
//     this.designation = map['designation'];
//     this.debit = map['debit'];
//     this.credit = map['credit'];

//   }
// }



// ============================LOGIN UNDESIGNED=====================================


// @override 
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Center(
  //       child: Column(
  //         children: <Widget>[
    
  //           Padding(
  //             padding: const EdgeInsets.all(12.0),
  //             child: Text('User Login Form', 
  //                     style: TextStyle(fontSize: 21))),
    
  //           Divider(),          
    
  //           Container(
  //           width: 280,
  //           padding: EdgeInsets.all(10.0),
  //           child: TextField(
  //               controller: emailController,
  //               autocorrect: true,
  //               decoration: InputDecoration(hintText: 'Enter Your Email Here'),
  //             )
  //           ),
    
  //           Container(
  //           width: 280,
  //           padding: EdgeInsets.all(10.0),
  //           child: TextField(
  //               controller: passwordController,
  //               autocorrect: true,
  //               obscureText: true,
  //               decoration: InputDecoration(hintText: 'Enter Your Password Here'),
  //             )
  //           ),
    
  //           RaisedButton(
  //             onPressed: userLogin,
  //             color: Colors.green,
  //             textColor: Colors.white,
  //             padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
  //             child: Text('Click Here To Login'),
  //           ),
    
  //           Visibility(
  //             visible: visible, 
  //             child: Container(
  //               margin: EdgeInsets.only(bottom: 30),
  //               child: CircularProgressIndicator()
  //               )
  //             ),
    
  //           ],
  //         ),
  //       )
  //     )
  //   );
  // }




 // Container(
//   height: 40.0,
//   color: Colors.transparent,
//   child: Material(
//     borderRadius: BorderRadius.circular(20.0),
//     shadowColor: Colors.transparent,
//     color: Colors.transparent,
//     elevation: 7.0,
//     child: GestureDetector (
//       onTap: () {
//         Navigator.push(
//           context, 
//           MaterialPageRoute(builder: (context) => FinanceHome()));
//       },
//       child: Center( 
//         child: Text(
//           "S'INSCRIRE",
//           style: TextStyle(
//               color: Colors.white, 
//               fontWeight: FontWeight.bold, 
//               fontFamily: 'OpenSans',
//               letterSpacing: 1.5,
//               fontSize: 18.0,
//             ),
//           ),
      
//         ),
//       ),
    
//   )
// )
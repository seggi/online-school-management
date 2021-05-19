

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:nankim_s/screens/api.dart';




class LevelDetails {
  final String id;
  final String title;
  // final String girls;
  // final String boys;
  final String totstudent;
  final String totpayment;

  LevelDetails(this.id, this.title,this.totstudent, this.totpayment);
}

class CheckPayment extends StatefulWidget{
  const CheckPayment({Key key}) :  super(key : key);

  @override 
  _CheckPayment createState() => _CheckPayment();
  
}

class _CheckPayment extends State<CheckPayment> {
  DateTime _datetime = DateTime.now();

  List<ModuleLevelList> _moduleLevelList;
  ModuleLevelList _voirlevelist;
  final ManageUrl _manageUrl = ManageUrl();

  @override
  void initState() {
    super.initState();
    _moduleLevelList = [];
    _getLevelList();
  }

  _getLevelList() {
   _manageUrl.getLevelList().then((getlevel) {
      setState(() {
        _moduleLevelList = getlevel;
      });
    });
  }

  Future getLevelInfo(items, title) async{
    // String url = "http://10.0.2.2:8000/shule/api/shule_repport/";
    // String url  = emUrl + "bulletinizer/api/rapports?state=get_level_details";
    // var url = "http://10.0.2.2/bulletinizer/api/authentication/level_details.php";
    var url = emUrl + "bulletinizer/api/rapports?state=student_statistics";
    

    // var response = await http.post(url, 
    //     body: {
    //       "id": items,
    //     }
    // );

    var datas = {'degree': items};

    // Starting Web API Call.
    // var response = await http.post(url, body: json.encode(datas));
    var response = await http.post(url, body: datas);

    // var  response = await http.post(url, body: {
    //   "id": items,
    // });

    var data = jsonDecode(response.body);
    // String girls = data[0]['girls'].toString();
    // String boys = data[0]['boys'].toString();
    // String totpayment = data[0]['totpayment'].toString() != 'null' ? data[0]['totpayment'].toString(): 'Rien à signaler.';
    // String totstudent = data[0]['totstudent'].toString() != 'null' ? data[0]['totstudent'].toString(): 'Rien à signaler';
    
    String totpayment = data[0]['frais'].toString() != 'null' ? data[0]['frais'].toString(): 'Rien à signaler.';
    String totstudent = data[0]['somme'].toString() != 'null' ? data[0]['somme'].toString(): 'Rien à signaler';
    

    // showDialog(
    //     context: context, 
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: new Text(message),
    //         actions: <Widget>[
    //           FlatButton(
    //             child: new Text("OK"),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           )
    //         ]
    //       );
    //     }
    //   );



    // String title= "seggi";
    // return moduleLevelInfoFromJson(response.body);

    Navigator.push(context,
      new MaterialPageRoute(builder: (context) => LevelDetail(),
      settings: RouteSettings(
        // arguments: LevelDetails(items, title, girls, boys, totstudent, totpayment),
        arguments: LevelDetails(items, title, totstudent, totpayment),
        )
      )
    );
  }

@override  
Widget build(BuildContext context){
  final double _height = MediaQuery.of(context).size.height;
  final double _width =  MediaQuery.of(context).size.width;
  return Scaffold(
    appBar: AppBar(
      title: Text("Les niveaux organisez"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh), 
          onPressed: () => _getLevelList())
      ],
    ),

    body: Container(
      height: _height,
      width: _width,
      child: FutureBuilder(
        future: _manageUrl.getLevelList(),
        builder: (context, snapshot){
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index) {
                  _voirlevelist = snapshot.data[index];
                  return Card(
                    child: new ListTile(
                      title: Text(_voirlevelist.level),
                      trailing: Icon(Icons.more_vert),
                      onTap: () { 
                        print('${snapshot.data[index].id} ${snapshot.data[index].level}');
                        // getLevelInfo(snapshot.data[index].id, snapshot.data[index].level);
                        getLevelInfo(snapshot.data[index].id, snapshot.data[index].level);
                      }
                    ),
                  );
                }
              );
            }

            return Center(child: CircularProgressIndicator(),);
        }
        )
      ),
    );
  }
}

// Next screen Show details

class LevelDetail extends StatefulWidget {
  const LevelDetail({Key key,}) : super(key : key);

  @override
  _LevelDetail createState() =>  _LevelDetail();
}

class _LevelDetail extends State<LevelDetail> {
  
  @override
  Widget build(BuildContext context) {
    final LevelDetails level = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("${level.title}"),
      ),

      body: Container(
       child: Padding(
         padding:EdgeInsets.all(8.0),
         child: ListView(
          children: <Widget>[
            Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Suivie paiement', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
                ),
              ),
            
            // Container(
            //   child: Text("Le nombre de élèves"),
            // ),

            Container(
              child: Column(
                children: <Widget>[
                  // ListTile(
                  //   title: Text("Filles", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black),),
                  //   subtitle: Text(level.girls,  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300,)),
                  // ),

                  // ListTile( Nombre total des élèves
                  //   title: Text("Garçons", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black)),
                  //   subtitle: Text(level.boys, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300,)),
                  // ),

                  ListTile(
                    title: Text("Type de paiement",  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black)),
                    subtitle: Text(level.totpayment, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300,)),
                  ),

                  ListTile(
                  title: Text("Paiement total", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black)),
                  subtitle: Text(level.totstudent, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300,)),
                  ),
                ]
              )
            ),

              
            
          ],
        ) ,)
      ),
    );
  }

  
}



class ModuleLevelInfo {
  String ngirls;
  String nboys;
  String payments;
  String totstudent;

  ModuleLevelInfo({this.ngirls, this.nboys, this.payments, this.totstudent});

  factory ModuleLevelInfo.fromJson(Map<String, dynamic> json) {
    return ModuleLevelInfo(
      ngirls: json['girls'].toString(),
      nboys: json['boys'].toString(),
      payments: json['totpayment'].toString(),
      totstudent: json['totstudent'].toString(),
    );
  }

  Map<String, dynamic> toMap() =>  {
    "girls": ngirls,
    "boys": nboys,
    "totpayment": payments,
    "totstudent": totstudent,
  };
 
}

class ModuleLevelList {
  String id;
  String level;

  ModuleLevelList({this.id, this.level});

  factory ModuleLevelList.fromJson(Map<String, dynamic> json) {
    return ModuleLevelList(
      id: json['id'].toString(),
      level: json['level'],
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "level": level,
  };
}



List<ModuleLevelInfo> moduleLevelInfoFromJson(String str) => 
    List<ModuleLevelInfo>.from(json.decode(str).map((x) => 
    ModuleLevelInfo.fromJson((x))));

List<ModuleLevelList> moduleLevelListFromJson(String str) => 
    List<ModuleLevelList>.from(json.decode(str).map((x) => 
    ModuleLevelList.fromJson((x))));

class Test {
  String test;

  Test(this.test);
}

class ManageUrl {
  Future<List<ModuleLevelInfo>> getLevelInfoinfo() async {
  //  Future<ModuleLevelInfo> getLevelInfoinfo(var items) async {

    // String url = "http://10.0.2.2:8000/shule/api/shule_repport/";
    // final http.Response response = await http.post(url, 
    //         body: {
    //           "id": items,
    //         }
    //     );

    // String url = "http://10.0.2.2:8000/shule/api/shule_repport/";
    String url = emUrl + "bulletinizer/api/rapports?state=get_level";
    // String url = "https://cslerocher.com/app/api/rapports?state=student_info";
    final response = await http.post(url);
    return moduleLevelInfoFromJson(response.body);

    // if(response.statusCode == 201) {
    //   var rep = jsonDecode(response.body);
    //   String girls =  rep['girls'];
    //   Test(girls);
      
    //   return ModuleLevelInfo.fromJson(json.decode(response.body));
    // }else {
    //   throw Exception("Faild to create album.");
    // }
  }

  Future<List<ModuleLevelList>> getLevelList() async {
    // String url = "http://10.0.2.2:8000/shule/api/shule_level/";
    String url = emUrl + "bulletinizer/api/rapports?state=get_level";
    final response = await http.post(url);
    return moduleLevelListFromJson(response.body);
  }
}





//-----------------------------------------------------


// body: Container(
//       child: ListView(
//         children: <Widget>[  
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container( 
//                 height: 20,
//                 alignment: Alignment.centerRight,
//                 child:  Padding(
//                   padding:  EdgeInsets.only(right: 20.0),
//                 child: Text("${_datetime.year}-${_datetime.month}-${_datetime.day}", textAlign: TextAlign.right, 
//                     style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18.0)),
//                 ), 
//               ),

//               Container(
//                 height: 40,
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 8.0),
//                   child: Text("Nombre d'eleve ", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
//                 ),
//               ),
    
//               Container(
//                 height: 60.0,
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                     padding: EdgeInsets.only(left: 16.0),
//                     child:Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[ 
//                         Text('Total: 25', textAlign: TextAlign.left,),
//                         Text('Fille: 12', textAlign: TextAlign.left,),
//                         Text('Garcon: 13', textAlign: TextAlign.left,),
                        
                        
//                       ],
//                   )
//                 )
//               ),

//               Container(
//                 height: 40,
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 8.0),
//                   child: Text('Paiement', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
//                 ),
//               ),
    
//               Container(
//                 height: 60.0,
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                     padding: EdgeInsets.only(left: 16.0),
//                     child:Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[ 
//                         Text('ELeves qui ont deja solde: 15', textAlign: TextAlign.left,),
//                         Text('Eleves insolvable: 5', textAlign: TextAlign.left,),
//                         Text('Eleves no pas encore solde : 5', textAlign: TextAlign.left,),
                        
//                       ],
//                   )
//                 )
//               ),

//               Container(
//                 height: 40,
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 8.0),
//                   child: Text('Montant percu : 900', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
//                 ),
//               ),

//             ],
//           ),
//           Divider()
//         ]
//       )
//     )



// Navigator.push(context,
//                             new MaterialPageRoute(builder: (context) => LevelDetail(),
//                             settings: RouteSettings(
//                               arguments: LevelDetails(snapshot.data[index].id, snapshot.data[index].title)
//                               )
//                             )
//                           );
//                       } 
//                         //() {
//                           // getLevelInfo(snapshot.data[index].id, snapshot.data[index].title);
//                         // setState(() {
//                           // _manageUrl.getLevelInfoinfo(snapshot.data[index].id);
//                         // });
//                       //},









// =========================================================================================================





// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// import 'package:nankim_s/screens/api.dart';




// class LevelDetails {
//   final String id;
//   final String title;
//   // final String totstudent;
//   // final String totpayment;
//   final List dbdata;

//   // LevelDetails(this.id, this.title,this.totstudent, this.totpayment);
//   LevelDetails(this.id, this.title,this.dbdata);
// }

// class CheckPayment extends StatefulWidget{
//   const CheckPayment({Key key}) :  super(key : key);

//   @override 
//   _CheckPayment createState() => _CheckPayment();
  
// }

// class _CheckPayment extends State<CheckPayment> {
//   DateTime _datetime = DateTime.now();

//   List<ModuleLevelList> _moduleLevelList;
//   ModuleLevelList _voirlevelist;
//   final ManageUrl _manageUrl = ManageUrl();

//   @override
//   void initState() {
//     super.initState();
//     _moduleLevelList = [];
//     _getLevelList();
//   }

//   _getLevelList() {
//    _manageUrl.getLevelList().then((getlevel) {
//       setState(() {
//         _moduleLevelList = getlevel;
//       });
//     });
//   }

//   Future getLevelInfo(items, title) async{
//     var url = emUrl + "bulletinizer/api/rapports?state=student_statistics";
//     var datas = {'degree': items};
//     var response = await http.post(url, body: datas);
//     var data = jsonDecode(response.body);

//     print("$data");
    
//     String totpayment = data[0]['frais'].toString() != 'null' ? data[0]['frais'].toString(): 'Rien à signaler.';
//     String totstudent = data[0]['somme'].toString() != 'null' ? data[0]['somme'].toString(): 'Rien à signaler';
//     // for (var dbitem in data) {
//         Navigator.push(context,
//         new MaterialPageRoute(builder: (context) => LevelDetail(),
//         settings: RouteSettings(
//           arguments: LevelDetails(items, title, data),
//           )
//         )
//       );
//     // }
//     // Navigator.push(context,
//     //   new MaterialPageRoute(builder: (context) => LevelDetail(),
//     //   settings: RouteSettings(
//     //     arguments: LevelDetails(items, title, totstudent, totpayment),
//     //     )
//     //   )
//     // );
//   }

// @override  
// Widget build(BuildContext context){
//   final double _height = MediaQuery.of(context).size.height;
//   final double _width =  MediaQuery.of(context).size.width;
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Les niveaux organisez"),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(Icons.refresh), 
//           onPressed: () => _getLevelList())
//       ],
//     ),

//     body: Container(
//       height: _height,
//       width: _width,
//       child: FutureBuilder(
//         future: _manageUrl.getLevelList(),
//         builder: (context, snapshot){
//             if (snapshot.hasData){
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context,int index) {
//                   _voirlevelist = snapshot.data[index];
//                   return Card(
//                     child: new ListTile(
//                       title: Text(_voirlevelist.level),
//                       trailing: Icon(Icons.more_vert),
//                       onTap: () { 
//                         print('${snapshot.data[index].id} ${snapshot.data[index].level}');
//                         getLevelInfo(snapshot.data[index].id, snapshot.data[index].level);
//                       }
//                     ),
//                   );
//                 }
//               );
//             }

//             return Center(child: CircularProgressIndicator(),);
//         }
//         )
//       ),
//     );
//   }
// }

// // Next screen Show details

// class LevelDetail extends StatefulWidget {
//   const LevelDetail({Key key,}) : super(key : key);

//   @override
//   _LevelDetail createState() =>  _LevelDetail();
// }

// class _LevelDetail extends State<LevelDetail> {



  
//   @override
//   Widget build(BuildContext context) {
//     final LevelDetails level = ModalRoute.of(context).settings.arguments;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${level.title}"),
//       ),

//       body: Container(
//        child: Padding(
//          padding:EdgeInsets.all(8.0),
//          child: ListView(
//           children: <Widget>[
//             Container(
//                 height: 40,
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 8.0),
//                   child: Text('Suivie paiement', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
//                 ),
//               ),

//             Container(
//               child: Column(
//                 children: 
//                     [
//                       Text("${level.dbdata.toString()}")
//                     ]
//               )
                
//                 // children: level.dbdata.map((i) => 
//                 //   new Text(i)).toList()
                
              
//               // child: Column(

//               //   children: <Widget>[
//               //     // ListTile(
//               //     //   title: Text("Type de paiement",  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black)),
//               //     //   subtitle: Text(level.totpayment, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300,)),
//               //     // ),

//               //     // ListTile(
//               //     // title: Text("Paiement total", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black)),
//               //     // subtitle: Text(level.totstudent, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300,)),
//               //     // ),
//               //   ]
//               // )
//             ),
//           ],
//         ) ,)
//       ),
//     );
//   }
// }



// class ModuleLevelInfo {
//   String ngirls;
//   String nboys;
//   String payments;
//   String totstudent;

//   ModuleLevelInfo({this.ngirls, this.nboys, this.payments, this.totstudent});

//   factory ModuleLevelInfo.fromJson(Map<String, dynamic> json) {
//     return ModuleLevelInfo(
//       // ngirls: json['girls'].toString(),
//       // nboys: json['boys'].toString(),
//       // payments: json['totpayment'].toString(),
//       // totstudent: json['totstudent'].toString(),

//       payments: json['frais'].toString(),
//       totstudent: json['somme'].toString(),
      
//     );
//   }

//   Map<String, dynamic> toMap() =>  {
//     // "girls": ngirls,
//     // "boys": nboys,
//     // "totpayment": payments,
//     // "totstudent": totstudent,
//     "frais": payments,
//     "somme": totstudent,
//   };
 
// }

// class ModuleLevelList {
//   String id;
//   String level;

//   ModuleLevelList({this.id, this.level});

//   factory ModuleLevelList.fromJson(Map<String, dynamic> json) {
//     return ModuleLevelList(
//       id: json['id'].toString(),
//       level: json['level'],
//     );
//   }

//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "level": level,
//   };
// }

// List<ModuleLevelInfo> moduleLevelInfoFromJson(List str) => 
//     List<ModuleLevelInfo>.from(str.map((x) => 
//     ModuleLevelInfo.fromJson((x))));


// // List<ModuleLevelInfo> moduleLevelInfoFromJson(String str) => 
// //     List<ModuleLevelInfo>.from(json.decode(str).map((x) => 
// //     ModuleLevelInfo.fromJson((x))));

// List<ModuleLevelList> moduleLevelListFromJson(String str) => 
//     List<ModuleLevelList>.from(json.decode(str).map((x) => 
//     ModuleLevelList.fromJson((x))));

// class Test {
//   String test;

//   Test(this.test);
// }

// class ManageUrl {
//   // Future<List<ModuleLevelInfo>> getLevelInfoinfo() async {
//   //   String url = emUrl + "bulletinizer/api/rapports?state=get_level";
//   //   final response = await http.post(url);
//   //   return moduleLevelInfoFromJson(response.body);

//   // }

//   Future<List<ModuleLevelList>> getLevelList() async {
//     String url = emUrl + "bulletinizer/api/rapports?state=get_level";
//     final response = await http.post(url);
//     return moduleLevelListFromJson(response.body);
//   }
// }







// // -----------------------------------------------------------------------------------
// // ===================================================================================


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// import 'package:nankim_s/screens/api.dart';




// class LevelDetails {
//   final String id;
//   final String title;
//   // final String totstudent;
//   // final String totpayment;
//   final List dbdata;

//   // LevelDetails(this.id, this.title,this.totstudent, this.totpayment);
//   LevelDetails(this.id, this.title,this.dbdata);
// }

// class CheckPayment extends StatefulWidget{
//   const CheckPayment({Key key}) :  super(key : key);

//   @override 
//   _CheckPayment createState() => _CheckPayment();
  
// }

// class _CheckPayment extends State<CheckPayment> {
//   DateTime _datetime = DateTime.now();

//   List<ModuleLevelList> _moduleLevelList;
//   ModuleLevelList _voirlevelist;
//   final ManageUrl _manageUrl = ManageUrl();

//   @override
//   void initState() {
//     super.initState();
//     _moduleLevelList = [];
//     _getLevelList();
//   }

//   _getLevelList() {
//    _manageUrl.getLevelList().then((getlevel) {
//       setState(() {
//         _moduleLevelList = getlevel;
//       });
//     });
//   }

//   Future getLevelInfo(items, title) async{
//     var url = emUrl + "bulletinizer/api/rapports?state=student_statistics";
//     var datas = {'degree': items};
//     var response = await http.post(url, body: datas);
//     var data = jsonDecode(response.body);

//     print("$data");
    
//     String totpayment = data[0]['frais'].toString() != 'null' ? data[0]['frais'].toString(): 'Rien à signaler.';
//     String totstudent = data[0]['somme'].toString() != 'null' ? data[0]['somme'].toString(): 'Rien à signaler';
//     // for (var dbitem in data) {
//         Navigator.push(context,
//         new MaterialPageRoute(builder: (context) => LevelDetail(),
//         settings: RouteSettings(
//           arguments: LevelDetails(items, title, data),
//           )
//         )
//       );
//     // }
//     // Navigator.push(context,
//     //   new MaterialPageRoute(builder: (context) => LevelDetail(),
//     //   settings: RouteSettings(
//     //     arguments: LevelDetails(items, title, totstudent, totpayment),
//     //     )
//     //   )
//     // );
//   }

// @override  
// Widget build(BuildContext context){
//   final double _height = MediaQuery.of(context).size.height;
//   final double _width =  MediaQuery.of(context).size.width;
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Les niveaux organisez"),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(Icons.refresh), 
//           onPressed: () => _getLevelList())
//       ],
//     ),

//     body: Container(
//       height: _height,
//       width: _width,
//       child: FutureBuilder(
//         future: _manageUrl.getLevelList(),
//         builder: (context, snapshot){
//             if (snapshot.hasData){
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context,int index) {
//                   _voirlevelist = snapshot.data[index];
//                   return Card(
//                     child: new ListTile(
//                       title: Text(_voirlevelist.level),
//                       trailing: Icon(Icons.more_vert),
//                       onTap: () { 
//                         print('${snapshot.data[index].id} ${snapshot.data[index].level}');
//                         getLevelInfo(snapshot.data[index].id, snapshot.data[index].level);
//                       }
//                     ),
//                   );
//                 }
//               );
//             }

//             return Center(child: CircularProgressIndicator(),);
//         }
//         )
//       ),
//     );
//   }
// }

// // Next screen Show details

// class LevelDetail extends StatefulWidget {
//   const LevelDetail({Key key,}) : super(key : key);

//   @override
//   _LevelDetail createState() =>  _LevelDetail();
// }

// class _LevelDetail extends State<LevelDetail> {

//   ModuleLevelInfo _levelInfo ;
  
//   @override
//   Widget build(BuildContext context) {
//     final LevelDetails level = ModalRoute.of(context).settings.arguments;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${level.title}"),
//       ),

//       body: Container(
//        child: Padding(
//          padding:EdgeInsets.all(8.0),
//          child: ListView(
//           children: <Widget>[
//             Container(
//                 height: 40,
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 8.0),
//                   child: Text('Suivie paiement', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25.0) ,),
//                 ),
//               ),

//             Container(
//               child: FutureBuilder(
//                 future: getLevelListInfo(level.dbdata),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(child: Text("Loading..."),);
//                   }
//                   return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     shrinkWrap: true,
//                     itemBuilder: (BuildContext context,int index) {
//                       _levelInfo = snapshot.data[index];
//                       return Card(
//                         child: new ListTile(
//                           title: Text(_levelInfo.payments),
//                           trailing: Icon(Icons.more_vert),
                          
//                         ),
//                       );
//                     }
//                   );
//                 }
//               )
//             ),
//           ],
//         ) ,)
//       ),
//     );
//   }
// }



// class ModuleLevelInfo {
//   String ngirls;
//   String nboys;
//   String payments;
//   String totstudent;

//   ModuleLevelInfo({this.ngirls, this.nboys, this.payments, this.totstudent});

//   factory ModuleLevelInfo.fromJson(Map<String, dynamic> json) {
//     return ModuleLevelInfo(
//       payments: json['frais'].toString(),
//       totstudent: json['somme'].toString(),
      
//     );
//   }

//   Map<String, dynamic> toMap() =>  {
//     "frais": payments,
//     "somme": totstudent,
//   };
 
// }



// class ModuleLevelList {
//   String id;
//   String level;

//   ModuleLevelList({this.id, this.level});

//   factory ModuleLevelList.fromJson(Map<String, dynamic> json) {
//     return ModuleLevelList(
//       id: json['id'].toString(),
//       level: json['level'],
//     );
//   }

//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "level": level,
//   };
// }

// List<ModuleLevelInfo>moduleLevelInfoFromJson(List str) => 
//     List<ModuleLevelInfo>.from(str.map((x) => 
//     ModuleLevelInfo.fromJson((x))));


// Future<List<ModuleLevelInfo>> getLevelListInfo(var items) async {
//   return  moduleLevelInfoFromJson(items);
// }

// List<ModuleLevelList> moduleLevelListFromJson(String str) => 
//     List<ModuleLevelList>.from(json.decode(str).map((x) => 
//     ModuleLevelList.fromJson((x))));

// class Test {
//   String test;

//   Test(this.test);
// }

// class ManageUrl {
//   // Future<List<ModuleLevelInfo>> getLevelInfoinfo() async {
//   //   String url = emUrl + "bulletinizer/api/rapports?state=get_level";
//   //   final response = await http.post(url);
//   //   return moduleLevelInfoFromJson(response.body);

//   // }

//   Future<List<ModuleLevelList>> getLevelList() async {
//     String url = emUrl + "bulletinizer/api/rapports?state=get_level";
//     final response = await http.post(url);
//     return moduleLevelListFromJson(response.body);
//   }
// }

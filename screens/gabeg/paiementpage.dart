import 'package:flutter/material.dart';
// import 'package:nankim_s/screens/finance/paiement_page/maternellepage.dart';
// import 'package:nankim_s/screens/finance/paiement_page/primairepage.dart';
// import 'package:nankim_s/screens/finance/paiement_page/secondairepage.dart';

// class Paiement extends StatefulWidget{
//   const Paiement({Key key}) : super(key: key);

//   @override 
//   _Paiement createState() => _Paiement();

// }

// class _Paiement extends State<Paiement> {

//   @override 
//   Widget build(BuildContext context){
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Suivie de Paiement"),
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(75.0),
//             child: TabBar(
//               tabs: <Widget>[
//                 Tab(icon: Icon(Icons.child_friendly,),
//                       child: Text('Maternelle'),
//                   ),

//                 Tab(icon: Icon(Icons.child_care,),
//                       child: Text('Primaire'),
//                   ),

//                 Tab(icon: Icon(Icons.school,),
//                       child: Text('Secondaire'),
//                   ),

//               ]
//             ),
//           )
//         ),

//         body: SafeArea(
//           child: TabBarView(
//             children: <Widget>[
//               // MaternelPaiement(),
//               PrimairePaiement(),
//               SecondairePaiement(),
//             ],
//           )
//         ),
//       )
//     );
//   }
// }
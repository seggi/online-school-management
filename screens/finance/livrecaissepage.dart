import 'package:flutter/material.dart';
import 'package:nankim_s/screens/finance/caisse_page/payment.dart';
// import 'package:nankim_s/screens/finance/caisse_page/rapmois.dart';
// import 'package:nankim_s/screens/finance/caisse_page/rapyear.dart';
import 'caisse_page/voirtout.dart';


class LivreCaisse extends StatefulWidget{
  const LivreCaisse({Key key}) : super(key: key);

  @override 
  _LivreCaisse createState() => _LivreCaisse();

}

class _LivreCaisse extends State<LivreCaisse> {


  @override 
  Widget build(BuildContext context){
    
    final double _width = MediaQuery.of(context).size.width;
    final double _hieght = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dépenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: () {
              
            })
        ],
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            RapportCaisse(),
          ],
        ),
      )
    );
  }
}

/////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
///
///
///
///
//  Widget build(BuildContext context){
    
//     final double _width = MediaQuery.of(context).size.width;
//     final double _hieght = MediaQuery.of(context).size.height;

//     return DefaultTabController(
//       length: 1,
//       child:Scaffold(
//         appBar: AppBar(
//           title: Text('Livre de caisse'),
//           ),
//         body: SafeArea(
//           child: TabBarView(
//               children: <Widget>[
//                 RapportCaisse(),
//                 // StudentPayment(),
//                 // RapAnnuel(),
//               ],
//             ),
          
//         ),
        
//         // bottomNavigationBar: Container(
//         //     color: Colors.lightBlue,
//         //     child: TabBar(
//         //       indicatorColor: Colors.lightBlue,
//         //       tabs: <Widget>[
//         //         Tab(icon: Icon(Icons.all_inclusive,),
//         //             child: Text('Le tout'),
//         //         ),
//         //         Tab(icon: Icon(Icons.today,),
//         //             child: Text('Journalier'),
//         //         ),
  
//         //         Tab(icon: Icon(Icons.calendar_view_day,),
//         //             child: Text('Annuel'),
//         //       ),
//         //     ]
//         //     )
//         //   ),
//         ),
//     );
//   }
// }



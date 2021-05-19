
import 'package:flutter/material.dart';
// import 'package:nankim_s/screens/finance/fiche_paie_page/autrespage.dart';
import 'package:nankim_s/screens/finance/fiche_paie_page/employeeinfo.dart';
// import 'package:nankim_s/screens/finance/fiche_paie_page/staffpage.dart';

class FichePaie extends StatefulWidget{
  const FichePaie({Key key}) : super(key: key);

  @override 
  _FichePaie createState() => _FichePaie();

}

class _FichePaie extends State<FichePaie> {

  @override 
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Fiche de paie"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.person,),
                      child: Text('Personnel'),
                  ),

                Tab(icon: Icon(Icons.people_outline,),
                      child: Text('Enseignant'),
                  ),

                Tab(icon: Icon(Icons.group_work,),
                      child: Text('Autres'),
                  ),

              ]
            ),
          )
        ),

        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              // StaffPaiement(),
              EmployeeInfo(),
              // AutresPaiement(),
            ],
          )
        ),
      )
    );
  }
}
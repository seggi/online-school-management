

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nankim_s/screens/api.dart';



class EmployeeInfo extends StatefulWidget{
  const EmployeeInfo({Key key}) : super(key: key);

  @override 
  _EmployeeInfo createState() => _EmployeeInfo();

}

class _EmployeeInfo extends State<EmployeeInfo>{

  ModuleEmployeeInfo _voirempolyeeinfo;
  List<ModuleEmployeeInfo> _moduleEmployeeInfo;

  @override
  void initState() {
    super.initState();
    _moduleEmployeeInfo = [];
    _getEmployeeInfo();
  }

  _getEmployeeInfo(){
    getEmployeeInfo().then((getemployee) {
      setState(() {
        _moduleEmployeeInfo = getemployee;
      });
    });
  }
  
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Employés"),),

      body: Container(
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: FutureBuilder(
            future: getEmployeeInfo(),
            builder: (context, snapshot){
              if (snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    _voirempolyeeinfo = snapshot.data[index];
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // ${_voirempolyeeinfo.functions}
                              // Text("${_voirempolyeeinfo.name} ${_voirempolyeeinfo.lastname}",
                              //       style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25.0),),
                              // Text("${_voirempolyeeinfo.nickname}", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0)),
                              // Text("${_voirempolyeeinfo.salary}", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0)),
                          Container (
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Noms ", 
                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 20.0),
                                    textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                     Text("${_voirempolyeeinfo.name} ${_voirempolyeeinfo.lastname} ${_voirempolyeeinfo.nickname}", 
                                      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w300, fontSize: 20.0),),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 2.0,),

                          Container (
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Genre ", 
                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 20.0, ),
                                    textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("${_voirempolyeeinfo.gender}", 
                                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w300, fontSize: 20.0),
                                    textAlign: TextAlign.start,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 2.0,),

                          Container (
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Salaire ", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 20.0),),
                                  ]
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("${_voirempolyeeinfo.salary}", 
                                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w300, fontSize: 20.0),),
                                  ]
                                ),
                                
                              ],
                            ),
                          ),
                         
                        ],
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator(),);
            }     
          ),
        ),
      )
    ,
    );
  }
}



class ModuleEmployeeInfo {
  String name;
  String lastname;
  String nickname;
  String salary;
  String gender;


  ModuleEmployeeInfo({this.name, this.lastname, this.nickname, this.salary, this.gender});

  factory ModuleEmployeeInfo.fromJson(Map<String, dynamic> json) {
    return ModuleEmployeeInfo(
      name: json['name'],
      lastname: json['subname'],
      nickname:  json['girlname'],
      salary: json['salaire'],
      gender: json['civile'],

    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'subname': lastname,
    'girlname': nickname,
    'salaire': salary,
    'civile': gender
  };
  
}

List<ModuleEmployeeInfo>  moduleEmployeeInfoFromJson(String str) =>
    List<ModuleEmployeeInfo>.from(json.decode(str).map((x) => 
    ModuleEmployeeInfo.fromJson((x))));


Future<List<ModuleEmployeeInfo>> getEmployeeInfo() async {
  // String url = emUrl + "bulletinizer/api/rapports?state=employee_info";
  String url = emUrl + "rapports?state=employee_info";
  final response = await http.post(url);
  return moduleEmployeeInfoFromJson(response.body);
}
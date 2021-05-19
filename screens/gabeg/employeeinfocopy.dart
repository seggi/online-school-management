

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
        title: Text("Employees"),),

      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
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
                              Text("${_voirempolyeeinfo.name} ${_voirempolyeeinfo.lastname}",
                                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25.0),),
                              Text("${_voirempolyeeinfo.nickname}", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0)),
                              Text("${_voirempolyeeinfo.salary}", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0)),
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
  String functions;


  ModuleEmployeeInfo({this.name, this.lastname, this.nickname, this.salary, this.functions});

  factory ModuleEmployeeInfo.fromJson(Map<String, dynamic> json) {
    return ModuleEmployeeInfo(
      // name: json['name'],
      // lastname: json['lastname'],
      // nickname: json['nickname'],
      // salary: json['salary'].toString(),
      // functions: json['functions'],

      name: json['name'],
      lastname: json['subname'],
      nickname:  json['girlname'],
      salary: json['salaire'],
      functions: json['civile'],

    );
  }

  Map<String, dynamic> toMap() => {
    // 'name': name,
    // 'lastname': lastname,
    // 'nickname':  nickname,
    // 'salary': salary,
    // 'functions': functions,

    'name': name,
    'subname': lastname,
    'girlname': nickname,
    'salaire': salary,
    'civile': functions
  };
  
}

List<ModuleEmployeeInfo>  moduleEmployeeInfoFromJson(String str) =>
    List<ModuleEmployeeInfo>.from(json.decode(str).map((x) => 
    ModuleEmployeeInfo.fromJson((x))));


Future<List<ModuleEmployeeInfo>> getEmployeeInfo() async {
  // String url = "http://10.0.2.2:8000/shule/api/shule_employee/info/";
  // String url = "http://127.0.0.1:8000/shule/api/shule_employee/info/";
  String url = emUrl + "bulletinizer/api/rapports?state=employee_info";
  final response = await http.get(url);
  return moduleEmployeeInfoFromJson(response.body);
}
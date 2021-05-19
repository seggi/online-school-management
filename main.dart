import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nankim_s/screens/finance/financehomepage.dart';

import 'package:nankim_s/screens/loginpage.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nankim-s',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}




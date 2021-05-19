// import 'package:flutter/material.dart';
// import 'package:connectivity/connectivity.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeConnect(),
//     );
//   }
// }

// class HomeConnect extends StatefulWidget {
//   @override
//   _HomeConnectState createState() => _HomeConnectState();
// }

// class _HomeConnectState extends State<HomeConnect> {
//   var wifiBSSID;
//   var wifiIP;
//   var wifiName;
//   bool iswificonnected = false;
//   bool isInternetOn = true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     GetConnect(); // calls getconnect method to check which type if connection it 
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Connectivity..."),
//       ),
//       body: isInternetOn
//           ? iswificonnected ? ShowWifi() : ShowMobile()
//           : buildAlertDialog(),
//     );
//   }

//   AlertDialog buildAlertDialog() {
//     return AlertDialog(
//       title: Text(
//         "You are not Connected to Internet",
//         style: TextStyle(fontStyle: FontStyle.italic),
//       ),
//     );
//   }

//   Center ShowWifi() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//               " Your are connected to ${iswificonnected ? "WIFI" : "MOBILE DATA"}"),
//           Text(iswificonnected ? "$wifiBSSID" : "Not Wifi"),
//           Text("$wifiIP"),
//           Text("$wifiName")
//         ],
//       ),
//     );
//   }

//   Center ShowMobile() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(" Your are Connected to  MOBILE DATA"),
//         ],
//       ),
//     );
//   }

//   void GetConnect() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       setState(() {
//         isInternetOn = false;
//       });
//     } else if (connectivityResult == ConnectivityResult.mobile) {
     
//       iswificonnected = false;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
      
//       iswificonnected = true;
//       setState(() async {
//         wifiBSSID = await (Connectivity().getWifiBSSID());
//         wifiIP = await (Connectivity().getWifiIP());
//         wifiName = await (Connectivity().getWifiName());
//       });

   
//     }
//   }
// }






import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Data Connection Checker",
//       home: HomePageHomePages(),
//     );
//   }
// }

class HomePages extends StatefulWidget {
  @override
  _StateHomePages createState() => _StateHomePages();
}

class _StateHomePages extends State<HomePages> {
  StreamSubscription<DataConnectionStatus> listener;

  var Internetstatus = "Unknown";

  @override
  void initState() {
    super.initState();
//    _updateConnectionStatus();
      CheckInternet();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  CheckInternet() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          Internetstatus="Connectd TO THe Internet";
          print('Data connection is available.');
          setState(() {

          });
          break;
        case DataConnectionStatus.disconnected:
          Internetstatus="No Data Connection";
          print('You are disconnected from the internet.');
          setState(() {

          });
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
//    await Future.delayed(Duration(seconds: 30));
//    await listener.cancel();
    return  await DataConnectionChecker().connectionStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Connection Checker"),
      ),
      body: Container(
        child: Center(
          child: Text("$Internetstatus"),
        ),
      ),
    );
  }
}
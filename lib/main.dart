import 'package:flutter/material.dart';
import 'package:flutter_application_4/loading.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppnew createState() => new MyAppnew();
}

class MyAppnew extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'FRESHDIGITAL BOT',
      debugShowCheckedModeBanner: false,
      home: loading(),
      theme: new ThemeData(
        canvasColor: Color.fromRGBO(238, 248, 246, 1.0),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'chat.dart';
import 'globals.dart' as globals;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'dart:math' as math;

class loading extends StatefulWidget {
  loading({Key key, this.title}) : super(key: key);

  final String title;

  @override
  loadingnew createState() => new loadingnew();
}

class loadingnew extends State<loading> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool ready = false;
  double percent = 0.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      auth();
    });
  }

  auth() async {
    print("authenticating.....");
// set up POST request arguments
    String url = 'https://botbuilder.freshdigital.io//authentication';
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*"
    };
// String json = '{"title": "Hello", "body": "body text", "userId": 1}';
    String json =
        '{  "strategy": "local", "email": "dbadmin@diwks.com", "password": "Admin@!23" }';
// make POST request
    http.Response response = await http.post(url, headers: headers, body: json);
// check the status code for the result
    int statusCode = response.statusCode;
    print('printing status code');
    print(statusCode);
// this API passes back the id of the new item added to the body
    var body = convert.jsonDecode(response.body);
    print('printing body responce');
    print(body);
    globals.authToken = body['accessToken'];
    analytics();
// exit(0);
  }

  analytics() async {
    String url =
        'https://botbuilder.freshdigital.io/botbuilder/60a38c2d069969090559722e';
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer " + globals.authToken,
    };
    http.Response response = await http.get(url, headers: headers);
    var body = convert.jsonDecode(response.body);
    print('printing body responce');
    print(body);
    globals.titlex = body['botname'];
    globals.light = body['color'];
    var ttemp = body['content'];
    final split = ttemp.split(',');
    globals.a = {for (int i = 0; i < split.length; i++) i: split[i]};
    //globals.a = body['content'];
    print(globals.titlex);
    print(globals.light);
    print(globals.a.values);
    final Map<int, String> list = globals.a;
    for (String vals in list.values) {
      globals.b.add(vals);
      print(vals);
    }
    // for (String vals in globals.a.values) {
    //   globals.b.add(vals);
    //   print(vals);
    // }
    print(globals.b);
    if (globals.b[0] != null) {
      setState(() {
        ready = true;
      });
    }
    // setState(() {
    //   ready = true;
    // });
  }

  builder() {
    if (ready) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => Homepage()));
    } else {
      Container(
        color: Colors.grey[300],
        width: 70.0,
        height: 70.0,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(child: new CircularProgressIndicator())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: builder(),
      // ready
      //     ?
      //     Container(
      //   color: Colors.grey[300],
      //   width: 70.0,
      //   height: 70.0,
      //   child: new Padding(
      //       padding: const EdgeInsets.all(5.0),
      //       child:
      //       // new Center(child: new CircularProgressIndicator())),
      // )
      // // : Navigator.push(
      // //     context,
      // //     MaterialPageRoute(
      // //         builder: (BuildContext context) => Homepage()))
    );
  }
}

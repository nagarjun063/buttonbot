import 'package:bubble/bubble.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart' as globals;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Homepagenew createState() => new Homepagenew();
}

class Homepagenew extends State<Homepage> {
  final GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();
  bool _isDark = false;
  var dark = Color(0xFF263238);
  var light = Color(0xFF2196F3);
  var light1 = Colors.red[10];
  var dark1 = Color(0xFFE3F2FD);
  var titlex = globals.titlex;

  final List _messages = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

   analytics() async {
// set up POST request arguments
    String url = 'https://botbuilder.freshdigital.io/analytics';
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer " + globals.authToken,
    };
// String json = '{"title": "Hello", "body": "body text", "userId": 1}';
   Map<String,dynamic> args =
        //{ "username": "admin", "password": "admin", "faq_clicked": globals.ListFaq, "faq_clicked_collection": globals.ListFaq_Collection,"collection_clicked":globals.ListCollection , "uncatched_tags": globals.ListUnCatched, "missed_counter":"${globals.missedcounter}","rating_faq": globals.Listfaq, "rating": globals.Listrating, "total_ratings": "${globals.total_ratings}", "no_of_ratings": "${globals.no_of_ratings}", "video_counter": "${globals.videocounter}", "faq_counter": "${globals.faqcounter}","collection_counter": "${globals.collectioncounter}","demo_counter":"${globals.democounter}","total_time":"${globals.diff_mn}"};
{   "username": "admin", "password": "admin","faq_clicked": globals.List_option,  "no_of_clicks":"${globals.option_counter}","agents_clicked": "${globals.live_agent_counter}", "website_clicked": "${globals.website_counter}","total_time":"${globals.diff_mn}"};
// make POST request
var body1= convert.jsonEncode(args);
    http.Response response = await http.post(url, headers: headers, body: body1);
// check the status code for the result
    int statusCode = response.statusCode;
    print('printing status code');
    print(statusCode);
// this API passes back the id of the new item added to the body
    var body = convert.jsonDecode(response.body);
    print('printing body responce');
    print(body);
    globals.id = body['_id'];
// exit(0);
  }

analyticspatch() async {
// set up POST request arguments
    String url = 'https://botbuilder.freshdigital.io/analytics/${globals.id}';
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer " + globals.authToken,
    };
// String json = '{"title": "Hello", "body": "body text", "userId": 1}';
     Map<String,dynamic> args =
      //  { "username": "admin", "password": "admin", "faq_clicked": globals.ListFaq, "faq_clicked_collection": globals.ListFaq_Collection,"collection_clicked":globals.ListCollection , "uncatched_tags": globals.ListUnCatched, "missed_counter":"${globals.missedcounter}","rating_faq": globals.Listfaq, "rating": globals.Listrating, "total_ratings": "${globals.total_ratings}", "no_of_ratings": "${globals.no_of_ratings}", "video_counter": "${globals.videocounter}", "faq_counter": "${globals.faqcounter}","collection_counter": "${globals.collectioncounter}","demo_counter":"${globals.democounter}","total_time":"${globals.diff_mn}"};
{  "username": "admin", "password": "admin","faq_clicked": globals.List_option,  "no_of_clicks":"${globals.option_counter}","agents_clicked": "${globals.live_agent_counter}", "website_clicked": "${globals.website_counter}","total_time":"${globals.diff_mn}"};
// make POST request
var body1= convert.jsonEncode(args);
    http.Response response = await http.patch(url, headers: headers, body: body1);
// check the status code for the result
    int statusCode = response.statusCode;
    print('printing status code');
    print(statusCode);
// this API passes back the id of the new item added to the body
    var body = convert.jsonDecode(response.body);
    print('printing body responce');
    print(body);
    
// exit(0);
  }


  @override
  void initState() {
     globals.intime = DateTime.now();
    print('In-time :'+globals.intime.toString());
   

    super.initState();

    setState(() {
      _messages.insert(0, welcome1());
      _messages.insert(0, welcome2());
     
    });
  }
// creates the button 
  button(List arr, List index) {
    setState(() {
      _messages.insert(
          0,
          SizedBox(
            width: 300.0,
            child: Column(
              children: arr.map((k) {
                return RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Color(0Xff217ad3)),
                  ),
                  child: Text(k),
                  onPressed: () {
                    setState(() {
                      _messages.removeAt(0);
                      _messages.insert(
                          0,
                          Bubble(
                            margin: BubbleEdges.only(top: 10),
                            elevation: 3.toDouble(),
                            color: Color(0xff217ad3),
                            alignment: Alignment.topRight,
                            nip: BubbleNip.rightTop,
                            child: Text(k,
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white)),
                          ));
                    });
                    globals.option_counter++;
                   print('No.of.times Option clicked :'+globals.option_counter.toString());
                    globals.List_option.add((k));
                   print('Option clicked :'+' '+globals.List_option.toString());
                      print('In-time :'+globals.intime.toString());
                       globals.outtime=DateTime.now();
                       print('out time :'+globals.outtime.toString());
                    globals.diff_mn=globals.outtime.difference(globals.intime). inSeconds;
                    print('Time diff :'+globals.diff_mn.toString()+'minutes');
                    print("this is" + k);
                    analyticspatch();
                    var t = arr.indexOf(k);
                    decider(index[t]);
                  },
                );
              }).toList(),
            ),
          ));
    });
  }
// decides the next element to be published 
  decider(l) {
    var len = l.length + 2;
    var item = [];
    var indi = [];
    var some = 0;
    for (var j = 0; j < globals.b.length; j++) {
      if (globals.b[j].length == len &&
          globals.b[j].substring(0, len - 2) == l) {
        if (globals.b[j].contains("a")) {
          print("answer");
          _messages.insert(
              0,
              Bubble(
                margin: BubbleEdges.only(top: 10),
                elevation: 3.toDouble(),
                color: Colors.grey[100],
                alignment: Alignment.topLeft,
                nip: BubbleNip.leftTop,
                child: Text(globals.b[j + 1],
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black)),
              ));
        } else {
          some++;
          item.add(globals.b[j + 1]);
          print(globals.b[j + 1]);
          indi.add(globals.b[j]);
        }
      }
    }
    if(some!=0){
      _messages.insert(
              0,
              Bubble(
                margin: BubbleEdges.only(top: 10),
                elevation: 3.toDouble(),
                color: Colors.grey[100],
                alignment: Alignment.topLeft,
                nip: BubbleNip.leftTop,
                child: Text("Here are few more options for you!",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black)),
              ));
    }
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          button(item, indi),
          Container(
            height: 10.0,
          ),
        ],
      ),
    );
  }
// Finds the First elements to publish
  heading() {
    print("heading");
    print(globals.b[0]);
    var temp = [];
    var ind = [];
    for (var i = 0; i < globals.b.length; i += 2) {
      if (globals.b[i].length == 1) {
        temp.add(globals.b[i + 1]);
        ind.add(globals.b[i]);
        print("temp");
        print(temp);
        print(ind);
      } else {
        print("mistake");
      }
    }
    button(temp, ind);
  }

  welcome1() {
    return Column(
      children: <Widget>[
        Wrap(
          children: <Widget>[
            Bubble(
              margin: BubbleEdges.only(top: 10),
              elevation: 3.toDouble(),
              color: Colors.grey[100],
              alignment: Alignment.topLeft,
              nip: BubbleNip.leftTop,
              child: Text(
                  "Hey there! Welcome to Skandashield,comprehensive securtiy solutions that will take of all your security issues.",
                  textAlign: TextAlign.left),
            ),
          ],
        ),
      ],
    );
  }

  welcome2() {
    return Column(
      children: <Widget>[
        Wrap(
          children: <Widget>[
            Bubble(
              margin: BubbleEdges.only(top: 10),
              elevation: 3.toDouble(),
              color: Colors.grey[100],
              alignment: Alignment.topLeft,
              nip: BubbleNip.leftTop,
              child: Text("Let me know if you need any assistance now?",
                  textAlign: TextAlign.left),
            ),
          ],
        ),
      ],
    );
  }

  _launchourweb() async {
    const url = 'https://www.freshdigital.io/';
    if (await canLaunch(url)) {
      await launch(url);
      globals.website_counter++;
      print('No.of.times website clicked :' +
      globals.website_counter.toString());
        globals.outtime=DateTime.now();
                    print('out time :'+globals.outtime.toString());
                    globals.diff_mn=globals.outtime.difference(globals.intime). inSeconds;
                    print('Time diff :'+globals.diff_mn.toString()+'minutes');
                    analyticspatch();
    } else {
      throw 'Could not launch $url';
    }
  }
Widget mainarea(){
 
    return Column(children: <Widget>[

        new Flexible(
            child: Align(
          alignment: Alignment.topCenter,
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        )),
        new Divider(height: 1.0),
      ]);
  }

  Widget getNoConnectionWidget(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 60.0,
          child: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/no-wifi.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        new Text("No Internet Connection"),
        new FlatButton(
            color: Colors.red,
            child: new Text("Retry", style: TextStyle(color: Colors.white),),
            onPressed: () => asyncLoaderState.currentState.reloadState())
      ],
    );
  }
  

  fetchdata() async {
     print("authenticating.....");
// set up POST request arguments
    String url1 = 'https://botbuilder.freshdigital.io//authentication';
    Map<String, String> headers1 = {
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*"
    };
// String json = '{"title": "Hello", "body": "body text", "userId": 1}';
    String json1 =
        '{  "strategy": "local", "email": "dbadmin@diwks.com", "password": "Admin@!23" }';
// make POST request
    http.Response response1 = await http.post(url1, headers: headers1, body: json1);
// check the status code for the result
    int statusCode1 = response1.statusCode;
    print('printing status code');
    print(statusCode1);
// this API passes back the id of the new item added to the body
    var body1 = convert.jsonDecode(response1.body);
    print('printing body responce');
    print(body1);
    globals.authToken = body1['accessToken'];
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
    print(globals.b);
      globals.outtime=DateTime.now();
                       print('out time :'+globals.outtime.toString());
                    globals.diff_mn=globals.outtime.difference(globals.intime). inSeconds;
                    print('Time diff :'+globals.diff_mn.toString()+'minutes');

    analytics();
    heading();
   return true;
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await fetchdata(),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({data}) => mainarea(),
    );
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF16FFBD),
        title: new Text(
          "Freshdigital",
          style: TextStyle(color: Colors.black),
        ),
      )),
      body: _asyncLoader,
      bottomNavigationBar: new Container(
        color: Colors.grey[200],
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: InkWell(
                  onTap: () {
                    print("Live agent");
                     globals.live_agent_counter++;
                print('No.of.times Live agent clicked :' +
                            globals.live_agent_counter.toString());
                              globals.outtime=DateTime.now();
                       print('out time :'+globals.outtime.toString());
                    globals.diff_mn=globals.outtime.difference(globals.intime). inSeconds;
                    print('Time diff :'+globals.diff_mn.toString()+'minutes');
                    analyticspatch();
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.person, size: 20),
                        ),
                        TextSpan(
                            text: "Live agent",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                )),
            FlatButton(
                onPressed: _launchourweb,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(
                    Icons.flash_on,
                    color: Color(0xFF16FFBD),
                  ),
                  Text(
                    "by  ",
                  ),
                  Image.asset("assets/clogo.png", height: 40, width: 100),
                ]))
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});
  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Wrap(
        children: <Widget>[
          Bubble(
            margin: BubbleEdges.only(top: 10),
            elevation: 3.toDouble(),
            color: Colors.grey[100],
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            child: Text(text, textAlign: TextAlign.left),
          ),
        ],
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Wrap(
        children: <Widget>[
          Bubble(
            margin: BubbleEdges.only(top: 10),
            elevation: 3.toDouble(),
            color: Color(0xff217ad3),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightTop,
            child: Text(text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Wrap(
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart' as globals;

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Homepagenew createState() => new Homepagenew();
}

class Homepagenew extends State<Homepage> {
  bool _isDark = false;
  var dark = Color(0xFF263238);
  var light = Color(0xFF2196F3);
  var light1 = Colors.red[10];
  var dark1 = Color(0xFFE3F2FD);
  var titlex = globals.titlex;

  final List _messages = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      _messages.insert(0, welcome1());
      _messages.insert(0, welcome2());
      heading();
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
                    print("this is" + k);
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
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: _isDark ? dark : light,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: new Text(titlex),
        actions: <Widget>[
          Icon(
            Icons.brightness_4,
          ),
          CupertinoSwitch(
            value: _isDark,
            onChanged: (v) {
              setState(() {
                _isDark = !_isDark;
              });
            },
          ),
        ],
      ),
      body: new Column(children: <Widget>[
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
      ]),
      bottomNavigationBar: new Container(
        height: 40,
        child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.flash_on,
                color: _isDark ? dark1 : light,
              ),
              Text(
                "by  ",
              ),
              Image.asset("assets/clogo.png", height: 40, width: 100),
            ],
          ),
          onPressed: _launchourweb,
        ),
      ),
      backgroundColor: _isDark ? dark : light1,
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

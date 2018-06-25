import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign-in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'question-types.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.amber,

      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool signedIn = false;



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new PopupMenuButton(
            onSelected: (item) {
              switch(item){
                case 1:
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new SignInPage()),
                  );
                  break;
                case 2:
                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  _auth.signOut();
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                new PopupMenuItem<int>(child: new Text("Sign In"), value: 1,),
                new PopupMenuItem<int>(child: new Text("Sign Out"), value: 2,),
              ];
            }
          )
        ],
      ),
      body: new Text("HI"),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), 
    );
  }
}

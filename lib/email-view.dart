import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailView extends StatefulWidget {
  @override
  _EmailViewState createState() => new _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final TextEditingController _controllerEmail = new TextEditingController();

  @override
  Widget build(BuildContext context) =>
      new Scaffold(
        appBar: new AppBar(
          title: new Text("Sign In"),
        ),
        body: new Builder(
          builder: (BuildContext context) {
            return new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: new InputDecoration(
                      labelText: "email",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        persistentFooterButtons: <Widget>[
          new ButtonBar(
            alignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new FlatButton(
                  onPressed: () => _connexion(context),
                  child: new Row(
                    children: <Widget>[
                      new Text("Next"),
                    ],
                  )),
            ],
          )
        ],
      );

  _connexion(BuildContext context) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      List<String> providers =
      await auth.fetchProvidersForEmail(email: _controllerEmail.text);
      print(providers);

      if (providers.isEmpty) {
        bool connected = await Navigator
            .of(context)
            .push(new MaterialPageRoute<bool>(builder: (BuildContext context) {
          return new SignUpView(_controllerEmail.text);
        }));

        if (connected) {
          Navigator.pop(context);
        }
      } else if (providers.contains('password')) {
        bool connected = await Navigator
            .of(context)
            .push(new MaterialPageRoute<bool>(builder: (BuildContext context) {
          return new PasswordView(_controllerEmail.text);
        }));

        if (connected) {
          Navigator.pop(context);
        }
      } else {
//        String provider = await _showDialogSelectOtherProvider(
//            _controllerEmail.text, providers);
//        if (provider.isNotEmpty) {
//          Navigator.pop(context, provider);
//        }
      }
    } catch (exception) {
      print(exception);
    }
  }

//  _showDialogSelectOtherProvider(String email, List<String> providers) {
//    var providerName = _providersToString(providers);
//    return showDialog<Null>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) => new AlertDialog(
//        content: new SingleChildScrollView(
//            child: new ListBody(
//              children: <Widget>[
//                new Text(FFULocalizations
//                    .of(context)
//                    .allReadyEmailMessage(email, providerName)),
//                new SizedBox(
//                  height: 16.0,
//                ),
//                new Column(
//                  children: providers.map((String p) {
//                    return new RaisedButton(
//                      child: new Row(
//                        children: <Widget>[
//                          new Text(_providerStringToButton(p)),
//                        ],
//                      ),
//                      onPressed: () {
//                        Navigator.of(context).pop(p);
//                      },
//                    );
//                  }).toList(),
//                )
//              ],
//            )),
//        actions: <Widget>[
//          new FlatButton(
//            child: new Row(
//              children: <Widget>[
//                new Text("Cancel"),
//              ],
//            ),
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//          ),
//        ],
//      ),
//    );
//  }
//}
}

class SignUpView extends StatefulWidget {
  final String email;

  SignUpView(this.email, {Key key}) : super(key: key);

  @override
  _SignUpViewState createState() => new _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerDisplayName;
  TextEditingController _controllerPassword;

  bool _valid = false;

  @override
  initState() {
    super.initState();
    _controllerEmail = new TextEditingController(text: widget.email);
    _controllerDisplayName = new TextEditingController();
    _controllerPassword = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _controllerEmail.text = widget.email;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Connexion"),
        elevation: 4.0,
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: new InputDecoration(
                      labelText: "Email",
                  ),
                ),
                const SizedBox(height: 8.0),
                new TextField(
                  controller: _controllerDisplayName,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  onChanged: _checkValid,
                  decoration: new InputDecoration(
                      labelText: "Name",
                  ),
                ),
                const SizedBox(height: 8.0),
                new TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  autocorrect: false,
                  decoration: new InputDecoration(
                      labelText: "Password",
                  ),
                ),
              ],
            ),
          );
        },
      ),
      persistentFooterButtons: <Widget>[
        new ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new FlatButton(
                onPressed: _valid ? () => _connexion(context) : null,
                child: new Row(
                  children: <Widget>[
                    new Text("Save"),
                  ],
                )),
          ],
        )
      ],
    );
  }

  _connexion(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      try {
        var userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _controllerDisplayName.text;
        await _auth.updateProfile(userUpdateInfo);
        Navigator.pop(context, true);
      } catch (e) {
      }
    } catch(e) {
      print(e.details);
    }
  }

  void _checkValid(String value) {
    setState(() {
      _valid = _controllerDisplayName.text.isNotEmpty;
    });
  }
}

class PasswordView extends StatefulWidget {
  final String email;

  PasswordView(this.email, {Key key}) : super(key: key);

  @override
  _PasswordViewState createState() => new _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;

  @override
  initState() {
    super.initState();
    _controllerEmail = new TextEditingController(text: widget.email);
    _controllerPassword = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _controllerEmail.text = widget.email;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sign In"),
        elevation: 4.0,
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: new InputDecoration(
                      labelText: "Email",
                  ),
                ),
                //const SizedBox(height: 5.0),
                new TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  autocorrect: false,
                  decoration: new InputDecoration(
                      labelText: "Email",
  ),
                ),
                new SizedBox(height: 16.0),
                new Container(
                    alignment: Alignment.centerLeft,
                    child: new InkWell(
                        child: new Text(
                          "Trouble Signing In?",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        onTap: _handleLostPassword)),
              ],
            ),
          );
        },
      ),
      persistentFooterButtons: <Widget>[
        new ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new FlatButton(
                onPressed: () => _connexion(context),
                child: new Row(
                  children: <Widget>[
                    new Text("Sign In"),
                  ],
                )),
          ],
        )
      ],
    );
  }

  _handleLostPassword() {
    Navigator
        .of(context)
        .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new TroubleSignIn(_controllerEmail.text);
    }));
  }

  _connexion(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user;
    try {
      user = await _auth.signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      print(user);
    } catch (exception) {
      //TODO improve errors catching
    }

    if (user != null) {
      Navigator.of(context).pop(true);
    }
  }
}
class TroubleSignIn extends StatefulWidget {
  final String email;

  TroubleSignIn(this.email, {Key key}) : super(key: key);

  @override
  _TroubleSignInState createState() => new _TroubleSignInState();
}

class _TroubleSignInState extends State<TroubleSignIn> {
  TextEditingController _controllerEmail;

  @override
  initState() {
    super.initState();
    _controllerEmail = new TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    _controllerEmail.text = widget.email;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Recover Password"),
        elevation: 4.0,
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: new InputDecoration(
                      labelText: "Email",
                  ),
                ),
                new SizedBox(height: 16.0),
                new Container(
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      "Recover Help",
                      style: Theme.of(context).textTheme.caption,
                    )),
                //const SizedBox(height: 5.0),
              ],
            ),
          );
        },
      ),
      persistentFooterButtons: <Widget>[
        new ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new FlatButton(
                onPressed: () => _send(context),
                child: new Row(
                  children: <Widget>[
                    new Text("Send"),
                  ],
                )),
          ],
        )
      ],
    );
  }

  _send(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.sendPasswordResetEmail(email: _controllerEmail.text);
    } catch (exception) {
    }
  }
}
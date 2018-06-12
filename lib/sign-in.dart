import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'social-button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
final FirebaseAuth _auth = FirebaseAuth.instance;


class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Signed In"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new SocialButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              icon: Icons.email,
              text: "Email & Password",
              onPressed: null,
            ),
            new SocialButton(
              color: new Color(0xFFDB4437),
              textColor: Colors.white,
              icon: FontAwesomeIcons.google,
              text: "Google",
              onPressed: signInWithGoogle,
            ),
            new SocialButton(
              color: new Color(0xFF3B5998),
              textColor: Colors.white,
              icon: FontAwesomeIcons.facebook,
              text: "Facebook",
              onPressed: signInWithFacebook,
            ),
            new SocialButton(
              color: new Color(0xFF1DA1F2),
              textColor: Colors.white,
              icon: FontAwesomeIcons.twitter,
              text: "Twitter",
              onPressed: signInWithTwitter,
            )
          ],
        ),
      ),
    );
  }

  void signInWithGoogle() async{
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  void signOut() {
    _auth.signOut();
  }

  signInWithTwitter() {
    _auth.signInWithTwitter(
        authToken: "283671411-DmSGuc3B0JD0jCOp30Z66DRfukheUYd8xxqu2u68",
        authTokenSecret: "lMWxzmadMnphAnTDqhlaVWeTbX0i7iO2fMcOXpfqra7S0",
    );
  }

  signInWithFacebook() async{
    var facebookLogin = new FacebookLogin();
    FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['email']);
    if (result.accessToken != null) {
      try {
        FirebaseUser user = await _auth.signInWithFacebook(
            accessToken: result.accessToken.token);
        print(user);
      } catch (e) {
        print(e.details);
      }
    }
  }


}
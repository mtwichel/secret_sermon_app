import 'package:flutter/material.dart';

class SocialButton extends StatefulWidget {
  SocialButton({
    Key key,
    this.text,
    this.color,
    this.textColor,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  final onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final IconData icon;

  @override
  _SocialButtonState createState() => new _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
      child: new RaisedButton(
        onPressed: widget.onPressed,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(

              child: new Icon(
                widget.icon,
                color: widget.textColor,
              ),
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 50.0, left: 16.0),
            ),
            new Container(
              child: new Text(
                widget.text,
                textScaleFactor: 1.3,
              ),
            ),
          ],
        ),
        color: widget.color,
        textColor: widget.textColor,
      ),
    );
  }
}

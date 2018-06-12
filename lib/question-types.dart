import 'package:flutter/material.dart';

class TextAreaQuestion extends StatefulWidget {
  const TextAreaQuestion({
    Key key,
    this.question,
  }) : super(key: key);

  final String question;

  @override
  _TextAreaQuestionState createState() => new _TextAreaQuestionState();
}

class _TextAreaQuestionState extends State<TextAreaQuestion> {
  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: const EdgeInsets.all(20.0),
      child :new Container(
        margin: const EdgeInsets.all(24.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(widget.question),
            new TextField(
              maxLength: 1000,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class RadioQuestion extends StatefulWidget {
  RadioQuestion({
    Key key,
    this.question,
    this.options,
  }) : super(key: key);

  final String question;
  final List<String> options;

  @override
  _RadioQuestionState createState() => new _RadioQuestionState();
}

class _RadioQuestionState extends State<RadioQuestion> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: const EdgeInsets.all(20.0),
      child :new Container(
        margin: const EdgeInsets.all(24.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(widget.question),
            new ListView(
              children: <Widget>[
                new RadioListTile<int>(
                  title: const Text('One'),
                  value: 0,
                  groupValue: _selected,
                  onChanged: (int value) { setState(() { _selected = value; }); },
                ),
                new RadioListTile<int>(
                  title: const Text('Two'),
                  value: 1,
                  groupValue: _selected,
                  onChanged: (int value) { setState(() { _selected = value; }); },
                ),
                new RadioListTile<int>(
                  title: const Text('Three'),
                  value: 2,
                  groupValue: _selected,
                  onChanged: (int value) { setState(() { _selected = value; }); },
                ),
                new RadioListTile<int>(
                  title: const Text('Four'),
                  value: 3,
                  groupValue: _selected,
                  onChanged: (int value) { setState(() { _selected = value; }); },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



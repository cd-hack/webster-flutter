import 'package:flutter/material.dart';

class Alertbox extends StatelessWidget {
  final content;
  final callback;
  Alertbox(this.content, {this.callback});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }
}

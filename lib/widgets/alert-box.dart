import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Alertbox extends StatelessWidget {
  final content;
  final callback;
  Alertbox(this.content, {this.callback});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      title: Text(
        'Error',
        style: GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: 24),
      ),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                  fontSize: 17,
                )))
      ],
    );
  }
}

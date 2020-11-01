import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static const routeName = 'formPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        //width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.yellow,
        child: Form(
            key: this._formKey,
            child: ListView(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Title",
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

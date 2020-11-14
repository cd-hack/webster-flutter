import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import './home-page.dart';

import '../widgets/alert-box.dart';
import '../providers/auth.dart';

class ChangeEmail extends StatefulWidget {
  static const routeName='/changeEmail';
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _formechange = GlobalKey<FormState>();
  TextEditingController email, password;
  bool _isloading = false, _isValid = false;
  Future<bool> _updateEmail(
      String email, int wid, String password, String token) async {
    final url = 'http://192.168.1.5:8000/client/user/$wid/';
    try {
      final response = await http.patch(url,
          body: {"email": email, "password": password},
          headers: {"Authorization": "Token $token"});
      final jresponse = json.decode(response.body);
      if (jresponse['status'] == 'failed')
        throw jresponse['message'];
      else
        return true;
    } catch (e) {
      throw e.toString();
    }
  }

  void _saveform() {
    _isValid = _formechange.currentState.validate();
    if (!_isValid) {
      return;
    }
  }

  @override
  void initState() {
    email = new TextEditingController();
    password = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int wid = ModalRoute.of(context).settings.arguments;
    String token = Provider.of<Auth>(context).token;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          _isloading
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    _saveform();
                    if (_isValid) {
                      setState(() {
                        _isloading = true;
                      });
                      _updateEmail(email.text, wid, password.text, token)
                          .then((value) {
                        setState(() {
                          _isloading = false;
                        });
                        if (value) Navigator.pop(context);
                        homeKey.currentState.showSnackBar(SnackBar(content: Text('Email was updated successfully')));
                      }).catchError((e) {
                        setState(() {
                          _isloading = false;
                        });
                        showDialog(
                          context: context,
                          builder: (context) => Alertbox(e.toString()),
                        );
                      });
                    }
                  })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formechange,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: email,
                validator: (value) {
                  if (!EmailValidator.validate(value))
                    return "Invalid Email";
                  else
                    return null;
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Email",
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1.0),
                  ),
                ),
              ),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value.length < 8) return "Invalid Password";
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Confirm Password",
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

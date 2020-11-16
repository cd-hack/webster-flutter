import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './home-page.dart';

import '../widgets/alert-box.dart';
import '../providers/auth.dart';

class ChangePhone extends StatefulWidget {
  static const routeName = '/changePhone';
  @override
  _ChangePhoneState createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {
  final _formpchange = GlobalKey<FormState>();
  TextEditingController phone, password;
  bool _isloading = false, _isValid = false;
  Future<bool> _updatePhone(
      String phone, int wid, String password, String token) async {
    final url = 'https://websterapp.herokuapp.com/client/user/$wid/';
    try {
      final response = await http.patch(url,
          body: {"phone": phone, "password": password},
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
    _isValid = _formpchange.currentState.validate();
    if (!_isValid) {
      return;
    }
  }

  @override
  void initState() {
    phone = new TextEditingController();
    password = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int wid = ModalRoute.of(context).settings.arguments;
    String token = Provider.of<Auth>(context).token;
    return Scaffold(
      appBar: AppBar(title: Text('Change Phone Number'),
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
                      _updatePhone(phone.text, wid, password.text, token)
                          .then((value) {
                        setState(() {
                          _isloading = false;
                        });
                        if (value) Navigator.pop(context);
                        homeKey.currentState.showSnackBar(SnackBar(
                            content:
                                Text('Phone Number was updated successfully')));
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
          key: _formpchange,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phone,
                  validator: (value) {
                    if (value.length != 10)
                      return "Invalid Phone Number";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: "Phone Number",
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
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

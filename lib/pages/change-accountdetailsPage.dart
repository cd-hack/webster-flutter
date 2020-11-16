import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './home-page.dart';

import '../widgets/alert-box.dart';
import '../providers/auth.dart';

class ChangeAccountDetails extends StatefulWidget {
  static const routeName = '/changeAccDetails';
  @override
  _ChangeAccountDetailsState createState() => _ChangeAccountDetailsState();
}

class _ChangeAccountDetailsState extends State<ChangeAccountDetails> {
  final _formachange = GlobalKey<FormState>();
  TextEditingController accNo, ifsc, password;
  bool _isloading = false, _isValid = false;
  Future<bool> _updateAccountDetails(
      String accNo, String ifsc, int wid, String password, String token) async {
    final url = 'http://192.168.1.4:8000/client/user/$wid/';
    try {
      final response = await http.patch(url,
          body: {"accNo": accNo, "ifsc": ifsc, "password": password},
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
    _isValid = _formachange.currentState.validate();
    if (!_isValid) {
      return;
    }
  }

  @override
  void initState() {
    accNo = new TextEditingController();
    ifsc = new TextEditingController();
    password = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    accNo.dispose();
    ifsc.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int wid = ModalRoute.of(context).settings.arguments;
    String token = Provider.of<Auth>(context).token;
    return Scaffold(
      appBar: AppBar(title: Text('Change Payment Details'),
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
                      _updateAccountDetails(
                              accNo.text, ifsc.text, wid, password.text, token)
                          .then((value) {
                        setState(() {
                          _isloading = false;
                        });
                        if (value) Navigator.pop(context);
                        homeKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'Account Details were updated successfully')));
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
          key: _formachange,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: accNo,
                  validator: (value) {
                    if (value.length < 9 || value.length > 18)
                      return "Invalid Account Number";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: "Account Number",
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
                  controller: ifsc,
                  validator: (value) {
                    if (value.length != 11)
                      return "Invalid IFSC Code";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: "IFSC Code",
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

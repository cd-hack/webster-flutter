import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

import '../providers/auth.dart';
import '../widgets/alert-box.dart';
import './home-page.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registrationPage';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _name = FocusNode();
  final _phone = FocusNode();
  final _password = FocusNode();
  final _confpassword = FocusNode();
  final _accNo = FocusNode();
  final _ifsc = FocusNode();

  bool _isValid = false, _isloading = false;
  final _formreg = GlobalKey<FormState>();
  Map<String, dynamic> _check = {};
  void _saveform() {
    print('jio');
    _isValid = _formreg.currentState.validate();
    if (!_isValid) {
      return;
    }
    _formreg.currentState.save();
    print(_check);
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _password.dispose();
    _confpassword.dispose();
    _accNo.dispose();
    _ifsc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    bool isloading = false;

    return Scaffold(
        backgroundColor: Color.fromRGBO(33, 37, 40, 1),
        body: Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  height: 0.9 * height,
                  width: 0.85 * width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Form(
                      key: _formreg,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'REGISTER',
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                            child: ListView(
                              children: <Widget>[
                                TextFormField(
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintText: 'Enter your E-mail address',
                                        prefixIcon: Icon(Icons.email),
                                        fillColor: Colors.grey[300],
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none)),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) =>
                                        _phone.requestFocus(),
                                    validator: (value) =>
                                        !EmailValidator.validate(value)
                                            ? "Invalid Email"
                                            : null,
                                    onSaved: (newValue) {
                                      print(newValue);
                                      _check['email'] = newValue;
                                    }),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Enter your Phone Number',
                                      prefixIcon: Icon(Icons.phone),
                                      fillColor: Colors.grey[300],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none)),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) => _name.requestFocus(),
                                  validator: (value) => value.length != 10
                                      ? "Enter a valid Phone Number"
                                      : null,
                                  onSaved: (newValue) =>
                                      _check['phone'] = newValue,
                                  focusNode: _phone,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Enter your Name',
                                      prefixIcon: Icon(Icons.person),
                                      fillColor: Colors.grey[300],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none)),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      _accNo.requestFocus(),
                                  validator: (value) => value.isEmpty
                                      ? "Enter a valid Name"
                                      : null,
                                  onSaved: (newValue) =>
                                      _check['name'] = newValue,
                                  focusNode: _name,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Enter your Account Number',
                                      prefixIcon: Icon(Icons.account_balance),
                                      fillColor: Colors.grey[300],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none)),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) => _ifsc.requestFocus(),
                                  validator: (value) =>
                                      value.length <= 8 || value.length >= 20
                                          ? "Invalid Account Number"
                                          : null,
                                  onSaved: (newValue) =>
                                      _check['accNo'] = newValue,
                                  focusNode: _accNo,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Enter your IFSC Code',
                                      prefixIcon: Icon(Icons.code),
                                      fillColor: Colors.grey[300],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none)),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      _password.requestFocus(),
                                  validator: (value) =>
                                      value.length <= 8 || value.length >= 20
                                          ? "Invalid IFSC Code"
                                          : null,
                                  onSaved: (newValue) =>
                                      _check['ifsc'] = newValue,
                                  focusNode: _ifsc,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Enter your Password Code',
                                      prefixIcon: Icon(Icons.lock),
                                      fillColor: Colors.grey[300],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none)),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      _confpassword.requestFocus(),
                                  validator: (value) => value.length <= 8
                                      ? "Password must be longer than 8 characters"
                                      : null,
                                  onSaved: (newValue) =>
                                      _check['password'] = newValue,
                                  focusNode: _password,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Confirm your Password',
                                      prefixIcon: Icon(Icons.lock),
                                      fillColor: Colors.grey[300],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none)),
                                  textInputAction: TextInputAction.next,
                                  // onFieldSubmitted: (_) => _confpassword.requestFocus(),
                                  validator: (value) => value.length <= 8
                                      ? "Passwords must be similar"
                                      : null,
                                  onSaved: (newValue) =>
                                      _check['confpass'] = newValue,
                                  focusNode: _confpassword,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                !_isloading
                                    ? Column(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.black,
                                            ),
                                            width: 0.3 * width,
                                            child: MaterialButton(
                                              child: Text(
                                                'Register',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                _saveform();
                                                print('hi');
                                                print(_isValid);
                                                print(_check);
                                                if (_isValid) {
                                                  print('hey');
                                                  setState(
                                                      () => _isloading = true);
                                                  Provider.of<Auth>(context,
                                                          listen: false)
                                                      .register(
                                                          name: _check['name'],
                                                          email:
                                                              _check['email'],
                                                          phone:
                                                              _check['phone'],
                                                          password: _check[
                                                              'password'],
                                                          accNo:
                                                              _check['accNo'],
                                                          ifsc: _check['ifsc'])
                                                      .then((value) {
                                                    if (value)
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                              Home.routeName,
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                    setState(() {
                                                      _isloading = false;
                                                    });
                                                  }).catchError((e) {
                                                    setState(() {
                                                      _isloading = false;
                                                    });
                                                    showDialog(
                                                        context: context,
                                                        child: Alertbox(
                                                            e.toString()));
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('Login Instead'))
                                        ],
                                      )
                                    : Center(child: CircularProgressIndicator())
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ))));
  }
}

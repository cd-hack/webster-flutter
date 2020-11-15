import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/alert-box.dart';
import '../providers/auth.dart';
import '../pages/home-page.dart';

class AddCategoryPage extends StatefulWidget {
  static const routeName = 'add-category';
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final cat3Controller = TextEditingController();
  final cat2Controller = TextEditingController();
  final cat1Controller = TextEditingController();

  @override
  void dispose() {
    cat1Controller.dispose();
    cat2Controller.dispose();
    cat3Controller.dispose();
    super.dispose();
  }

  bool _isloading = false, _isValid = false;

  String isEmptyValidator(String value) {
    if (value.isEmpty) return "This field cannot be empty";
    return null;
  }

  Future<bool> _addCategory(List<String> cat, String token, int wid) async {
    try {
      final url = 'http://192.168.1.5:8000/client/category/$wid/';
      final response = await http.post(url,
          body: json.encode({"category": cat}),
          headers: {
            "Authorization": "Token $token",
            'Content-Type': 'application/json'
          });
      final jresponse = json.decode(response.body) as Map;
      if (jresponse.containsKey('status') && jresponse['status'] == 'failed')
        throw jresponse['message'];
      if (jresponse.containsKey('detail')) throw jresponse['detail'];
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> _fetchProducts(String token, String wid) async {
    try {
      final url = 'http://192.168.1.5:8000/client/fetchproducts/$wid/';
      final response =
          await http.post(url, headers: {"Authorization": "Token $token"});
      final jresponse = json.decode(response.body) as Map;
      if (jresponse.containsKey('status') && jresponse['status'] == 'failed')
        throw jresponse['message'];
      if (jresponse.containsKey('detail')) throw jresponse['detail'];
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  final _formcatpage = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _token = Provider.of<Auth>(context, listen: false).token;
    final _wid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Add Category')),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Form(
            key: _formcatpage,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cat1Controller,
                    validator: isEmptyValidator,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Category 1",
                      focusedErrorBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red)),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cat2Controller,
                    validator: isEmptyValidator,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Category 2",
                      focusedErrorBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red)),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cat3Controller,
                    validator: isEmptyValidator,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Category 3",
                      focusedErrorBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red)),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ))),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'konakey',
        child: _isloading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Icon(Icons.save),
        onPressed: () {
          _isValid = _formcatpage.currentState.validate();
          if (_isValid && !_isloading) {
            setState(() {
              _isloading = true;
            });
            _addCategory([
              cat1Controller.text,
              cat2Controller.text,
              cat3Controller.text
            ], _token, _wid)
                .then((value) {
              if (value)
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              setState(() {
                _isloading = false;
              });
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
        },
      ),
    );
  }
}

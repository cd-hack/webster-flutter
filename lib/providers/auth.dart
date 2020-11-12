import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token = null, _email = null;

  get token => _token;

  get email => _email;

  Future<bool> login(String email, String password) async {
    final url = 'http://192.168.1.2:8000/client/login/';
    try {
      final response =
          await http.post(url, body: {'username': email, 'password': password});
      print(response.body);
      final jresponse = json.decode(response.body) as Map;
      if (jresponse.containsKey('non_field_errors'))
        throw (jresponse['non_field_errors'][0]);
      else {
        print(jresponse);
        _token = jresponse['token'];
        _email = email;
        await _saveToken();
        return true;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<bool> register(
      {String email,
      String name,
      String password,
      String accNo,
      String ifsc,
      String phone}) async {
    const url = 'http://192.168.1.2:8000/client/user/';
    try {
      print({
        'email': email,
        'name': name,
        'password': password,
        'accNo': accNo,
        'ifsc': ifsc,
        'phone': phone,
        'is_client': true,
        'is_user': false,
        'plan': 1
      });
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'name': name,
            'password': password,
            'accNo': accNo,
            'ifsc': ifsc,
            'phone': phone,
            'is_client': true,
            'is_user': false,
            'plan': 1
          }),
          headers: {'Content-Type': 'application/json'});
      final jresponse = json.decode(response.body);
      print(jresponse);
      if (jresponse.containsKey('status') && jresponse['status'] == 'failed')
        throw (jresponse['message']);
      else {
        final a = login(email, password);
        return a;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> _saveToken() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setString('token', _token);
    shr.setString('email', _email);
  }

  Future<bool> isloggedin() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    if (shr.containsKey('token') && shr.containsKey('email')) {
      _token = shr.getString('token');
      _email = shr.getString('email');
      return true;
    } else
      return false;
  }

  Future<void> logout() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.clear();
    _token = null;
    _email = null;
  }
}

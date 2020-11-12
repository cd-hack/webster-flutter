import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import '../providers/auth.dart';

class ProfilePage extends StatelessWidget {
  Future<Map> _fetchUser(String email) async {
    final url = 'http://192.168.1.2:8000/client/user/?email=$email';
    try {
      final response = await http.get(url);
      final jresponse = json.decode(response.body) as List;
      return jresponse[0];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Auth>(context, listen: false);
    return FutureBuilder(
        future: _fetchUser(prov.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.hasError)
            return Center(
              child: Text(
                snapshot.error.toString(),
                style:
                    GoogleFonts.openSans(color: Colors.grey[700], fontSize: 23),
                textAlign: TextAlign.center,
              ),
            );
          else {
            return Container(
              child: ListView(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                'assets/images/default-profile-picture.jpg'),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              snapshot.data["name"],
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              "UID:${snapshot.data['id']}",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Change Email"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          snapshot.data['email'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone_android),
                    title: Text("Change Phone number"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          snapshot.data['phone'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.payment),
                    title: Text("Change Payment Details"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.desktop_mac),
                    title: Text("View Desktop Site"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("Request a Call"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () => prov.logout().then((value) =>
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false)),
                  )
                ],
              ),
            );
          }
        });
  }
}

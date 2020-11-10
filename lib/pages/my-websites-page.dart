import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import '../providers/auth.dart';
import 'package:webster/pages/editable-form-page.dart';
import '../widgets/alert-box.dart';

class MyWebsitesPage extends StatelessWidget {
  Future<List> _fetchWebsites(String token) async {
    const url = 'http://192.168.1.3:8000/client/websitelist/';
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Token $token'});
      final jresponse = json.decode(response.body) as List;
      print(jresponse);
      if (jresponse.isEmpty)
        throw "Currently you don't own any websites,\nCreate one by tapping the plus button below!";
      else
        return jresponse;
    } catch (e) {
      throw e.toString();
    }
  }

  Widget pictile(
      {String tileText, String networkImageUrl, BuildContext context}) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(5),
      //color: Colors.red,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        //color: Colors.yellow,
        child: Container(
          //color: Colors.blue,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  networkImageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 15,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      tileText,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context, listen: false).token;
    return FutureBuilder(
        future: _fetchWebsites(token),
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
            return ListView.builder(
              itemCount: snapshot.data.length,
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    EditableForm.routeName,
                    arguments: snapshot.data[index]),
                child: pictile(
                    networkImageUrl: snapshot.data[index]['image'],
                    tileText: snapshot.data[index]['title'],
                    context: context),
              ),
            );
          }
        });
  }
}

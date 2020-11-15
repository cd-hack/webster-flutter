import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:webster/widgets/alert-box.dart';

class ProductPreviewPage extends StatefulWidget {
  static const routeName = '/productpreviewPage';
  @override
  _ProductPreviewPageState createState() => _ProductPreviewPageState();
}

class _ProductPreviewPageState extends State<ProductPreviewPage> {
  Future<Map> _fetchProductDetail(int id) async {
    final url = 'http://192.168.1.5:8000/client/productdetail/$id';
    try {
      final response = await http.get(url);
      final jresponse = json.decode(response.body);
      if (response.statusCode != 200) throw "Something went wrong, Try again!";
      return jresponse;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: FutureBuilder(
            future: _fetchProductDetail(pid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (snapshot.hasError)
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: GoogleFonts.openSans(
                        color: Colors.grey[700], fontSize: 23),
                    textAlign: TextAlign.center,
                  ),
                );
              else {
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Image.network(snapshot.data['image480']),
                      Positioned(
                        child: FloatingActionButton(
                            elevation: 2,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/heart.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            backgroundColor: Colors.white,
                            onPressed: () {}),
                        bottom: 0,
                        right: 20,
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}

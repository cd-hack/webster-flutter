import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:convert';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/product-tile.dart';
import '../providers/auth.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int wid;
  bool _isloading = true, _get = false;
  List<Map> posts = [];

  String next = "http://192.168.1.2:8000/client/productlist/", email;

  Future _fetchProducts() async {
    if (next == 'null') return;
    setState(() => _isloading = true);
    try {
      final response = await http.get(next);
      final jresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          posts.add(jresponse['results']);
          _isloading = false;
        });
        next = jresponse['next'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (!_get) {
      email = Provider.of<Auth>(context, listen: false).email;
      final url = 'http://192.168.1.3:8000/client/user/?email=$email';
      final res = await http.get(url);
      final jres = json.decode(res.body);
      if (jres[0]['websites_owned'].len != 0)
        wid = jres[0]['websites_owned'][0];
      if (wid != null)
        await _fetchProducts();
      else {
        setState(() {
          _isloading = false;
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Stack(
        children: <Widget>[
          _isloading
              ? CircularProgressIndicator()
              : wid == null || posts.length == 0
                  ? Center(
                      child: Text(
                        'You Currently don\'t have any Products / Websites, Tap refresh to Fetch/ Update the Products',
                        style: GoogleFonts.openSans(
                            color: Colors.grey[700], fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : LazyLoadScrollView(
                      child: GridView.builder(
                        itemCount: posts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => ProductTile(
                            posts[index]['image'], posts[index]['name'], '4.7'),
                      ),
                      onEndOfPage: _fetchProducts,
                    ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SpeedDial(
                animatedIcon: AnimatedIcons.menu_close,
                animatedIconTheme: IconThemeData(size: 22.0),
                curve: Curves.bounceIn,
                tooltip: 'Speed Dial',
                heroTag: 'speed-dial-hero-tag',
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 8.0,
                shape: CircleBorder(),
                children: [
                  SpeedDialChild(
                      child: Icon(Icons.add),
                      backgroundColor: Colors.red,
                      label: 'Add new Product',
                      onTap: () {}),
                  SpeedDialChild(
                      child: Icon(Icons.refresh),
                      backgroundColor: Colors.blue,
                      label: 'Fetch/Update Products',
                      onTap: null),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

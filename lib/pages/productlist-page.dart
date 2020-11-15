import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:convert';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:google_fonts/google_fonts.dart';
import './newproduct-page.dart';

import './home-page.dart';
import '../widgets/product-tile.dart';
import '../providers/auth.dart';
import '../widgets/alert-box.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int wid;
  bool _isloading = true, _get = false;
  List<Map> posts = [];

  String next = "http://192.168.1.5:8000/client/productlist/", email, token;

  Future _fetchProducts() async {
    print(next);
    if (next == null) return;
    setState(() => _isloading = true);
    try {
      next += '?wid=$wid';
      final response = await http.get(next);
      final jresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          jresponse['results'].forEach((e) => posts.add(e));
          _isloading = false;
        });
        next = jresponse['next'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> _fetchProductsFromInstagram(String token) async {
    if (wid == null) return false;
    final url = 'http://192.168.1.5:8000/client/fetchproducts/$wid/';
    try {
      final response =
          await http.post(url, headers: {'Authorization': 'Token $token'});
      final jresponse = json.decode(response.body);
      if (!jresponse.containsKey('status') || jresponse['status'] == 'failed')
        throw "Couldn\'t fetch the products, Please try later";
      return true;
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
      token = Provider.of<Auth>(context, listen: false).token;
      final url = 'http://192.168.1.5:8000/client/user/?email=$email';
      final res = await http.get(
        url,
      );
      final jres = json.decode(res.body);
      print(jres);
      if (jres[0]['websites_owned'].length != 0)
        wid = jres[0]['websites_owned'][0];
      if (wid != null)
        await _fetchProducts();
      else {
        setState(() {
          _isloading = false;
        });
      }
      _get = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          wid == null || posts.length == 0
              ? Center(
                  child: Text(
                    'You Currently don\'t have any Products / Websites, Tap refresh to Fetch/ Update the Products',
                    style: GoogleFonts.openSans(
                        color: Colors.grey[700], fontSize: 23),
                    textAlign: TextAlign.center,
                  ),
                )
              : LazyLoadScrollView(
                  isLoading: _isloading,
                  child: GridView.builder(
                    itemCount: posts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.8),
                    itemBuilder: (context, index) => ProductTile(
                        posts[index]['image320'], posts[index]['name'], '4.7'),
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
                overlayOpacity: 0,
                elevation: 8.0,
                shape: CircleBorder(),
                children: [
                  SpeedDialChild(
                      child: Icon(Icons.add),
                      backgroundColor: Colors.red,
                      label: 'Add new Product',
                      onTap: () => AddProduct()),
                  SpeedDialChild(
                      child: Icon(Icons.refresh),
                      backgroundColor: Colors.blue,
                      label: 'Fetch/Update Products',
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => LoadingDialogue());
                        _fetchProductsFromInstagram(token).then((value) {
                          Navigator.pop(context);
                          if (value)
                            homeKey.currentState.showSnackBar(SnackBar(
                                content: Text('Products fetched and stored')));
                          else
                            showDialog(
                              context: context,
                              builder: (context) => Alertbox(
                                  'Couldn\'t Fetch the products, Try Again!'),
                            );
                        }).catchError((e) {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => Alertbox(
                                'Couldn\'t Fetch the products, Try Again!'),
                          );
                        });
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoadingDialogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Image.asset("assets/images/fetching.gif"),
    );
  }
}

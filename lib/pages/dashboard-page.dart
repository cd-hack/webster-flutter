import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/alert-box.dart';
import '../providers/auth.dart';

class DashBoard extends StatelessWidget {
  static const routeName = '/dashboard';

  Future<Map> _fetchDashboard(String email, String token) async {
    Map ret = {};
    final url = 'http://192.168.1.3:8000/client/user/?email=$email';
    print(url);
    try {
      final response = await http.get(url);
      print(response.body);
      final jresponse = json.decode(response.body);
      if (response.statusCode != 200) throw "Can't access the server";

      if (jresponse.length == 0) throw "Given user email does not exist";

      if (jresponse[0]['websites_owned'].length == 0)
        throw "Currently you don't own any websites,\nCreate one by tapping the plus button below!";
      final websiteid = jresponse[0]['websites_owned'][0];
      final dashurl = 'http://192.168.1.3:8000/client/dashboard/$websiteid/';
      final dashres =
          await http.post(dashurl, headers: {'Authorization': 'Token $token'});
      final dashjres = json.decode(dashres.body);
      if (dashjres.containsKey('detail')) throw dashjres['detail'];
      if (dashjres['status'] == 'failed')
        throw dashjres['message'];
      else
        return dashjres;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    final double screen_width = MediaQuery.of(context).size.width;
    final prov = Provider.of<Auth>(context, listen: false);
    return FutureBuilder(
        future: _fetchDashboard(prov.email, prov.token),
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
                child: StaggeredGridView.count(
              crossAxisCount: 2,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Material(
                    elevation: 5,
                    color: Colors.indigo[50],
                    borderRadius: BorderRadius.circular(30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "LAST 7 DAYS SALES:",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Sparkline(
                              data: snapshot.data['ordergraph'],
                              fallbackHeight: screen_height * 0.25,
                              fallbackWidth: screen_width,
                              pointsMode: PointsMode.all,
                              pointSize: 8,
                              lineWidth: 4,
                              pointColor: Colors.red,
                              lineColor: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Material(
                    elevation: 5,
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("TOTAL ORDER\nAMOUNT",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            Text("₹${snapshot.data['order_total']}",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Material(
                    elevation: 5,
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("TODAY'S\nTOTAL\nORDER",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            Text(snapshot.data['ordertoday'],
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Material(
                    elevation: 5,
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(snapshot.data['totalorders'],
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold)),
                            Text("TOTAL\nORDERS\nTILL\nDATE",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
              staggeredTiles: [
                StaggeredTile.extent(2, screen_height * 0.4),
                StaggeredTile.extent(1, screen_height * 0.4),
                StaggeredTile.extent(1, screen_height * 0.2),
                StaggeredTile.extent(1, screen_height * 0.2),
              ],
            ));
          }
        });
  }
}

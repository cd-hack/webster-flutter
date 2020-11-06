import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:webster/main.dart';
import '';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    final double screen_width = MediaQuery.of(context).size.width;

    List<double> last_7_day_orders = [1, 2, 5, 4, 7, 3, 5];
    return Container(
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        data: last_7_day_orders,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      Text("₹ " + "5140",
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      Text("25",
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      Text("155",
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
      ),
    );
  }
}

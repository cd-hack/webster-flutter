import 'package:flutter/material.dart';
import 'package:webster/pages/add-new-form-page.dart';
import '../widgets/picture-tile.dart';

class SelectCategory extends StatelessWidget {
  static const routeName = '/categories-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Select the category of your page:",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormPage(
                        websiteType: 0,
                      )),
            ),
            child: PictureTile(
              assetImageUrl: 'assets/images/fashion-banner.jpg',
              tileText: "FASHION STORE",
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormPage(
                        websiteType: 1,
                      )),
            ),
            child: PictureTile(
              assetImageUrl: 'assets/images/food-banner.jpg',
              tileText: "FOOD STORE",
            ),
          ),
        ],
      ),
    );
  }
}

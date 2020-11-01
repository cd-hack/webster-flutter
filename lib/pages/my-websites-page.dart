import 'package:flutter/material.dart';
import 'package:webster/pages/form-page.dart';
import '../widgets/picture-tile.dart';

class MyWebsitesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(FormPage.routeName),
          child: PictureTile(
            assetImageUrl: 'assets/images/fashion-banner.jpg',
            tileText: "FASHIONSTORE",
          ),
        ),
        PictureTile(
          assetImageUrl: 'assets/images/vegetables-banner.jpg',
          tileText: "VEGSTORE",
        ),
      ],
    );
  }
}

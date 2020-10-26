import 'package:flutter/material.dart';
import '../widgets/picture-tile.dart';

class MyWebsitesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      children: [
        PictureTile(
          assetImageUrl: 'assets/images/fashion-banner.jpg',
          tileText: "FASHIONSTORE",
        ),
      ],
    );
  }
}

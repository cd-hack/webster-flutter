import 'package:flutter/material.dart';
import 'package:webster/pages/add-new-form-page.dart';
import 'package:webster/pages/editable-form-page.dart';
import '../widgets/picture-tile.dart';

class MyWebsitesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(EditableForm.routeName),
          child: PictureTile(
            assetImageUrl: 'assets/images/vegetables-banner.jpg',
            tileText: "VEG STORE",
          ),
        ),
      ],
    );
  }
}

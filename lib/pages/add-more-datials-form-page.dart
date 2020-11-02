import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMoreDetailsPage extends StatefulWidget {
  static const routeName = '/add-more-details-page';

  @override
  _AddMoreDetailsPageState createState() => _AddMoreDetailsPageState();
}

class _AddMoreDetailsPageState extends State<AddMoreDetailsPage> {
  File carousel_image;

  Future getImage() async {
    final uploaded_image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      carousel_image = File(uploaded_image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced"),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              child: carousel_image == null
                  ? Image.asset('assets/images/no-image.png')
                  : Image.file(carousel_image),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 5),
              child: RaisedButton(
                color: Colors.white,
                onPressed: getImage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/upload-icon.png",
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text("Upload Carousel Image")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: RaisedButton(
                color: Colors.black,
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => LoadingDialogue());
                },
                child: Text(
                  "START FETCHING PRODUCTS",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
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

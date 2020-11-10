import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PictureTile extends StatelessWidget {
  final assetImageUrl;
  final tileText;
  PictureTile({@required this.assetImageUrl, @required this.tileText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(5),
      //color: Colors.red,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        //color: Colors.yellow,
        child: Container(
          //color: Colors.blue,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  assetImageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 15,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      tileText,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

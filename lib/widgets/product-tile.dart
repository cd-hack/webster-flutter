import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTile extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String rating;
  ProductTile(this.imageUrl, this.productName, this.rating);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0,
            ),
          ]),
      height: 0.35 * height,
      width: 0.45 * width,
      child: Column(
        children: <Widget>[
          ClipRRect(
            child: Image.network(imageUrl,height: 0.45*width,width:0.45*width,fit: BoxFit.cover,),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30) )
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    productName,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      rating,
                      style: TextStyle(color: Colors.yellow, fontSize: 20),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:webster/widgets/alert-box.dart';
import 'package:flutter/services.dart';

import '../providers/auth.dart';
import './home-page.dart';

class AddProduct extends StatefulWidget {
  static const routeName = '/addProduct';
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _newProdformkey = new GlobalKey<FormState>();

  TextEditingController nameController, priceController, descriptionController;

  bool availability = false, veg = false, _isValid = false;

  int selectedRadioTile;

  List cat;

  Future<Map> _getSiteInfo(int wid, String token) async {
    final url = 'http://192.168.1.5:8000/client/website/$wid/';
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Token $token'});
      final jresponse = json.decode(response.body);
      if (response.statusCode != 200)
        throw "Some error occurred, Try Again later";
      return jresponse;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    nameController = new TextEditingController();
    priceController = new TextEditingController();
    descriptionController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context, listen: false).token;
    final wid = ModalRoute.of(context).settings.arguments;
    Map prodData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Product'),
      ),
      body: FutureBuilder(
          future: _getSiteInfo(wid, token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (snapshot.hasError)
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: GoogleFonts.openSans(
                      color: Colors.grey[700], fontSize: 23),
                  textAlign: TextAlign.center,
                ),
              );
            else {
              cat = snapshot.data['category'];
              prodData['productType'] = snapshot.data['templatetype'];
              prodData['size'] = '11111';
              prodData['foodType'] = 1;
              return Container(
                padding: EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Form(
                    key: _newProdformkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("You can edit the following fields:"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value.isEmpty) return "Name cannot be empty";
                              if (value.length > 30)
                                return "Length of the name is too big";
                              return null;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Name",
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: priceController,
                            validator: (value) {
                              if (value.isEmpty) return "Price cannot be empty";
                              if (value.length > 7) return "Price is too big";
                              return null;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Price",
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: descriptionController,
                            validator: (value) {
                              if (value.length < 30)
                                return "Minimum characters 30";
                              return null;
                            },
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Description",
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        CheckboxListTile(
                          title: Text("Availability"),
                          value: availability,
                          onChanged: (newValue) {
                            setState(() {
                              availability = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                        Text('Select Category'),
                        ...snapshot.data['category']
                            .map((e) => RadioListTile(
                                  value: 0,
                                  groupValue: selectedRadioTile,
                                  title: Text(e),
                                  onChanged: (val) {
                                    setState(() => selectedRadioTile = val);
                                  },
                                  activeColor: Colors.blueAccent[700],
                                ))
                            .toList(),
                        snapshot.data['templatetype'] == 1
                            ? SizedBox()
                            : Column(
                                children: <Widget>[
                                  Text('Food Type'),
                                  CheckboxListTile(
                                    title: Text("Vegetarian"),
                                    value: veg,
                                    onChanged: (newValue) {
                                      setState(() {
                                        veg = newValue;
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity
                                        .leading, //  <-- leading Checkbox
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _isValid = _newProdformkey.currentState.validate();
          if (selectedRadioTile != null)
            showDialog(
              context: context,
              builder: (context) => Alertbox("Category must be selected"),
            );
          else {
            if (_isValid) {
              prodData['name'] = nameController.text;
              prodData['price'] = double.parse(priceController.text);
              prodData['description'] = descriptionController.text;
              prodData['category'] = cat[selectedRadioTile];
              prodData['veg'] = veg;
              prodData['available'] = availability;
              Clipboard.setData(new ClipboardData(text: json.encode(prodData)))
                  .then((value) {
                Navigator.pop(context);
                homeKey.currentState.showSnackBar(SnackBar(
                  content: Text('Text copied to clipboard!'),
                ));
              });
            }
          }
        },
        icon: Icon(Icons.content_copy),
        label: Text("Copy to Clipboard"),
      ),
    );
  }
}

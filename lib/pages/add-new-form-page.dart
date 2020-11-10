import 'package:flutter/material.dart';
import 'package:webster/pages/add-more-datials-form-page.dart';

class FormPage extends StatefulWidget {
  static const routeName = '/formPage';
  final int websiteType;
  FormPage({this.websiteType});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var currentDropDownValue = 0;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final websiteid = TextEditingController();
  final titleController = TextEditingController();
  final aboutController = TextEditingController();
  final instagramIdController = TextEditingController();
  final facebookIdController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    aboutController.dispose();
    instagramIdController.dispose();
    facebookIdController.dispose();
    websiteid.dispose();
    super.dispose();
  }

  String isEmptyValidator(String value) {
    if (value.isEmpty) {
      //return "This field cannot be empty";
      return null;
    }
    return null;
  }

  Map _detail;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    print(widget.websiteType);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        //width: MediaQuery.of(context).size.width * 0.9,
        //color: Colors.yellow,
        child: Form(
            key: this._formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    validator: isEmptyValidator,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Title",
                      focusedErrorBorder:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2, color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: aboutController,
                    validator: isEmptyValidator,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "About",
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2, color: Colors.red)),
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
                    controller: instagramIdController,
                    validator: isEmptyValidator,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Instagram id",
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2, color: Colors.red)),
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
                    controller: facebookIdController,
                    validator: isEmptyValidator,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "FaceBook id",
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2, color: Colors.red)),
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
                    controller: websiteid,
                    validator: isEmptyValidator,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Website ID",
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2, color: Colors.red)),
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
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: double.infinity,
                    height: 0.2 * height,
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            if (_formKey.currentState.validate())
              _detail = {
                "title": titleController.text,
                "about": aboutController.text,
                "ighandle": instagramIdController.text,
                "fburl": facebookIdController.text,
                "websiteid": websiteid.text,
                "lnurl": "",
                "templateType": widget.websiteType
              };
            Navigator.of(context).pushReplacementNamed(
                AddMoreDetailsPage.routeName,
                arguments: _detail);
          },
          child: Text(
            "NEXT",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

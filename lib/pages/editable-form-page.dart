import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add-more-datials-form-page.dart';

class EditableForm extends StatefulWidget {
  static const routeName = '/edit-page';
  @override
  _EditableFormState createState() => _EditableFormState();
}

class _EditableFormState extends State<EditableForm> {
  File carousel_image;
  Map args;
  bool _hasloaded = false;
  Future getImage() async {
    final uploaded_image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      carousel_image = File(uploaded_image.path);
    });
  }

  var currentDropDownValue = 0;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController titleController,
      aboutController,
      instagramIdController,
      facebookIdController,
      websiteid;

  @override
  void didChangeDependencies() {
    if (!_hasloaded) {
      args = ModalRoute.of(context).settings.arguments;
      titleController = TextEditingController(text: args['title']);
      aboutController = TextEditingController(text: args['about']);
      instagramIdController = TextEditingController(text: args['ighandle']);
      facebookIdController = TextEditingController(text: args['fburl']);
      websiteid = TextEditingController(text: 'hi');
    }
    super.didChangeDependencies();
  }

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
      return "This field cannot be empty";
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args['title']),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Form(
            key: this._formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("You can edit the following fields:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    validator: isEmptyValidator,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Title",
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2)),
                      errorBorder: OutlineInputBorder(
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
                    controller: aboutController,
                    validator: isEmptyValidator,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "About",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorBorder: OutlineInputBorder(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 5),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                Container(
                  child: carousel_image == null
                      ? Image.asset('assets/images/no-image.png')
                      : Image.file(carousel_image),
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {},
          color: Colors.black,
          textColor: Colors.white,
          child: Text("UPDATE DETAILS"),
        ),
      ),
    );
  }
}

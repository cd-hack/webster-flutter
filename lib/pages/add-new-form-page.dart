import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:webster/widgets/alert-box.dart';
import '../providers/auth.dart';
import './add-category-page.dart';

class FormPage extends StatefulWidget {
  static const routeName = '/formPage';
  final int websiteType;
  FormPage({this.websiteType});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  File carousel_image;
  bool _isloading = false;
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

  Future getImage() async {
    final uploaded_image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      carousel_image = File(uploaded_image.path);
    });
  }

  Future<Map> _uploadImage(Map userdetails, String token) async {
    final url = 'http://192.168.1.5:8000/client/website/';
    try {
      Dio dio = new Dio();
      String date = DateTime.now().toString();
      userdetails['image'] = await MultipartFile.fromFile(carousel_image.path,
          filename: "$date.jpg");
      FormData formdata = FormData.fromMap(userdetails);
      final response = await dio
          .post(url,
              data: formdata,
              options: Options(
                  method: 'POST',
                  responseType: ResponseType.json,
                  headers: {"Authorization": "Token $token"}))
          .catchError((e) {
        throw e.toString();
      });
      print(response.data);
      return response.data;
    } catch (e) {
      throw e.toString();
    }
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
    final token = Provider.of<Auth>(context, listen: false).token;
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
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 5),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text("Upload Carousel Image")
                            ],
                          ),
                        ),
                      ),
                    ),
                    width: double.infinity,
                    height: 0.3 * height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: carousel_image != null
                                ? FileImage(carousel_image)
                                : AssetImage('assets/images/grey.png'),
                            fit: BoxFit.cover),
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
            if (_formKey.currentState.validate() &&
                !_isloading) if (carousel_image == null)
              showDialog(
                  context: context,
                  builder: (ctx) => Alertbox('Carousel Image not selected'));
            else {
              setState(() => _isloading = true);
              _detail = {
                "title": titleController.text,
                "about": aboutController.text,
                "ighandle": instagramIdController.text,
                "fburl": facebookIdController.text,
                "websiteid": websiteid.text,
                "lnurl": "",
                "templateType": widget.websiteType
              };
              _uploadImage(_detail, token).then((value) {
                setState(() => _isloading = false);
                Navigator.of(context)
                    .pushReplacementNamed(AddCategoryPage.routeName,arguments: value['id']);
              }).catchError((e) {
                setState(() => _isloading = false);
                showDialog(
                  context: context,
                  builder: (context) => Alertbox(e.toString()),
                );
              });
            }
          },
          child: _isloading
              ? CircularProgressIndicator()
              : Text(
                  "NEXT",
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}

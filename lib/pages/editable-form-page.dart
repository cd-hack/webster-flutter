import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import './home-page.dart';
import '../widgets/alert-box.dart';
import '../providers/auth.dart';

class EditableForm extends StatefulWidget {
  static const routeName = '/edit-page';
  @override
  _EditableFormState createState() => _EditableFormState();
}

class _EditableFormState extends State<EditableForm> {
  File carousel_image;
  Map<String, dynamic> args;
  bool _hasloaded = false, _isloading = false, _isValid = false;
  Future getImage() async {
    final uploaded_image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      carousel_image = File(uploaded_image.path);
    });
  }

  Future<void> _editWebsite(Map<String, dynamic> args, String token) async {
    final url = 'http://192.168.1.4:8000/client/website/${args['id']}/';
    print(args);
    try {
      var response, jresponse;
      if (carousel_image == null) {
        response = await http.patch(url,
            body: json.encode({
              "title": args['title'],
              "about": args['about'],
              "templatetype": args['templatetype'],
              "ighandle": args['ighandle'],
              "fburl": args['fburl'],
              "lnurl": args['lnurl'],
              "websiteid": args['websiteid'],
            }),
            headers: {
              'Authorization': 'Token $token',
              'Content-Type': 'application/json'
            });
        jresponse = json.decode(response.body);
        print(jresponse);
        if (jresponse.containsKey('status') &&
            jresponse['status'][0] == 'failed') throw jresponse['message'][0];
      } else {
        Dio dio = new Dio();
        FormData formdata = FormData.fromMap({
          "title": args['title'],
          "about": args['about'],
          "templatetype": args['templatetype'],
          "ighandle": args['ighandle'],
          "fburl": args['fburl'],
          "lnurl": args['lnurl'],
          "websiteid": args['websiteid'],
          "image": await MultipartFile.fromFile(carousel_image.path)
        });
        print('loco');
        response = await dio.patch(url,
            data: formdata,
            options: Options(
                method: 'PATCH',
                responseType: ResponseType.json,
                headers: {"Authorization": "Token $token"}));
        jresponse = response.data;
        if (jresponse.containsKey('status') &&
            jresponse['status'][0] == 'failed') throw jresponse['message'][0];
      }
    } catch (e) {
      throw e.toString();
    }
  }

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
      websiteid = TextEditingController(text: args['websiteid']);
      _hasloaded = true;
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final token = Provider.of<Auth>(context, listen: false).token;
    return Scaffold(
      appBar: AppBar(
        title: Text(args['title']),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'http://192.168.1.4:8000/${args['websiteid']}/',
                      style: TextStyle(fontSize: 20),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("You can edit the following fields:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value.isEmpty) return "Title cannot be empty";
                      if (value.length > 30)
                        return "Length of the title is too big";
                      return null;
                    },
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
                    validator: (value) {
                      if (value.length < 60) return "Minimum characters 60";
                      return null;
                    },
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
                    validator: (value) {
                      if (value.length >= 30 || value.isEmpty)
                        return "Invalid Instagram handle";
                      return null;
                    },
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
                    validator: (value) {
                      if (value.isEmpty) return "Value can't be empty";
                      if (!Uri.parse(value).isAbsolute) return "Invalid URL";
                      return null;
                    },
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
                    validator: (value) {
                      if (value.length > 30) return "Invalid Website ID";
                      return null;
                    },
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
                ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {
            _isValid = _formKey.currentState.validate();
            if (_isValid) {
              setState(() => _isloading = true);
              args['title'] = titleController.text;
              args['about'] = aboutController.text;
              args['ighandle'] = instagramIdController.text;
              args['fburl'] = facebookIdController.text;
              args['websiteid'] = websiteid.text;
              _editWebsite(args, token).then((value) {
                setState(() => _isloading = false);
                Navigator.pop(context);
                homeKey.currentState.showSnackBar(
                    SnackBar(content: Text('Website updated successfully!')));
              }).catchError((e) {
                setState(() => _isloading = false);
                showDialog(
                  context: context,
                  builder: (context) => Alertbox(e.toString()),
                );
              });
            }
          },
          color: Colors.black,
          textColor: Colors.white,
          child: _isloading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text("UPDATE DETAILS"),
        ),
      ),
    );
  }
}

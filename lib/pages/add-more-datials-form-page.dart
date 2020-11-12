import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import './add-category-page.dart';
import '../widgets/alert-box.dart';

class AddMoreDetailsPage extends StatefulWidget {
  static const routeName = '/add-more-details-page';

  @override
  _AddMoreDetailsPageState createState() => _AddMoreDetailsPageState();
}

class _AddMoreDetailsPageState extends State<AddMoreDetailsPage> {
  File carousel_image;
  bool _isloading = false;

  Future getImage() async {
    final uploaded_image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      carousel_image = File(uploaded_image.path);
    });
  }

  Future<Map> _uploadImage(Map userdetails, String token) async {
    final url = 'http://192.168.1.2:8000/client/website/';
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
        print(e);
        return false;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    final token = Provider.of<Auth>(context,listen: false).token;
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
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            padding: const EdgeInsets.all(15.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.black,
            onPressed: () {
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     builder: (context) => LoadingDialogue());
              if (!_isloading) {
                setState(() {
                  _isloading = true;
                });
                _uploadImage(args, token).then((value) {
                  Navigator.of(context).pushNamed(AddCategoryPage.routeName,
                      arguments: value['id']);
                }).catchError((e) {
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
                    "GENERATE WEBSITE",
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ));
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

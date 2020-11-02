import 'package:flutter/material.dart';
import 'package:webster/pages/add-more-datials-form-page.dart';
import 'package:webster/pages/add-new-form-page.dart';

import './pages/home-page.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFFFFFFFF, color);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Webster',
      theme: ThemeData(
          primarySwatch: colorCustom,
          accentColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          )),
      routes: {
        '/': (context) => Home(),
        FormPage.routeName: (context) => FormPage(),
        AddMoreDetailsPage.routeName: (context) => AddMoreDetailsPage(),
      },
    );
  }
}

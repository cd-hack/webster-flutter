import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:webster/pages/add-more-datials-form-page.dart';
import 'package:webster/pages/add-new-form-page.dart';
import 'package:webster/pages/editable-form-page.dart';
import 'package:webster/pages/select-category-page.dart';
import './pages/dashboard-page.dart';
import './pages/add-category-page.dart';
import './pages/login-page.dart';
import './pages/registration-page.dart';
import './providers/auth.dart';

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
    return ChangeNotifierProvider(
      create: (context) => Auth(),
      child: Consumer<Auth>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Webster',
          theme: ThemeData(
              primarySwatch: colorCustom,
              accentColor: Colors.black,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: TextTheme(
                headline1:
                    TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                // headline6:
                //     TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              )),
          routes: {
            "/": (ctx) => FutureBuilder(
                future: value.isloggedin(),
                builder: (_, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? Scaffold()
                        : (snapshot.data != null && snapshot.data)
                            ? Home()
                            : LoginPage()),
            Home.routeName: (context) => Home(),
            FormPage.routeName: (context) => FormPage(),
            SelectCategory.routeName: (context) => SelectCategory(),
            AddMoreDetailsPage.routeName: (context) => AddMoreDetailsPage(),
            EditableForm.routeName: (context) => EditableForm(),
            DashBoard.routeName: (context) => DashBoard(),
            AddCategoryPage.routeName: (context) => AddCategoryPage(),
            LoginPage.routeName: (context) => LoginPage(),
            RegistrationPage.routeName: (context) => RegistrationPage()
          },
        ),
      ),
    );
  }
}

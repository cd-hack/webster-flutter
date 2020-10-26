import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const routeName = '/homePage';
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int selectedIndex = 0;
  void updateTabSelection(int index) {
    print(index);
    setState(() => selectedIndex = index);
  }

  final List<Widget> _widgets = [];
  final List<String> _title = [
    'Home',
    'My Websites',
    'Settings',
    'User Profile'
  ];
  final List<IconData> _bottomAppBar = [
    Icons.home,
    Icons.web_asset,
    Icons.settings,
    Icons.account_circle
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[selectedIndex]),
      ),
      body: Center(
        child: Text('Hello'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Icon(Icons.add),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                _bottomAppBar.length,
                (index) => Padding(
                      padding: index == 1
                          ? EdgeInsets.only(right: 25)
                          : index == 2
                              ? EdgeInsets.only(left: 25)
                              : EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () => updateTabSelection(index),
                        iconSize: 27.0,
                        icon: Icon(
                          _bottomAppBar[index],
                          color: selectedIndex == index
                              ? Colors.blueAccent[700]
                              : Colors.grey.shade400,
                        ),
                      ),
                    )),
          ),
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}

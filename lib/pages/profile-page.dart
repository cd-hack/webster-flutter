import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/default-profile-picture.jpg'),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Username",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "UID:123456",
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.looks_one),
            title: Text("Option 1"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.looks_two),
            title: Text("Option 2"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.desktop_mac),
            title: Text("View Desktop Site"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Request a Call"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}

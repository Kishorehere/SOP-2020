import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inductions_20/screens/mentee/announcement.dart';
import 'package:inductions_20/screens/mentee/mentee_home.dart';
import 'package:inductions_20/screens/navigation/widgets/custom_list_tile.dart';
import '../../theme/navigation.dart';

class MenteeCustomDrawer extends StatelessWidget {
  final String _name;
  final String _username;
  final String _url;

  MenteeCustomDrawer(this._name, this._username, this._url);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  _name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: theme.primaryColor,
                  ),
                ),
                accountEmail: Text(
                  _username,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.primaryColor,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    _url,
                  ),
                  backgroundColor: theme.fontColor,
                ),
                decoration: BoxDecoration(
                  color: theme.tertiaryColor,
                ),
              ),
            ),
            CustomListTile(Icons.home, "Home Page", () {
              Navigator.push(context, 
               MaterialPageRoute(builder: (context) =>homepage()),);

                          Navigator.push(context, 
               MaterialPageRoute(builder: (context) =>homepage()),);
             
            }),
            CustomListTile(Icons.announcement, "Announcements", () {
     
                            Navigator.push(context, 
               MaterialPageRoute(builder: (context) =>Announcement()),);

              Navigator.pushNamed(context,'/mentee/announcement/');
               
            }),
            CustomListTile(Icons.exit_to_app, "Logout", () async {
              final storage = new FlutterSecureStorage();
              await storage.delete(key: "jwt");
              Navigator.pushNamed(context, '/login');
            }),
          ],
        ),
      ),
    );
  }
}

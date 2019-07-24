import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:http/http.dart" as http;
import "package:url_launcher/url_launcher.dart" as launcher;
import "package:location/location.dart";
import "package:shared_preferences/shared_preferences.dart";

import "localizations.dart";
import "welcome.dart";

Color themeColour = Colors.deepOrange;
String name = "";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Faithlife Meets",
      theme: ThemeData(primarySwatch: themeColour),
      home: MyHomePage(),
      supportedLocales: [Locale("en"), Locale("zh")],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales)
          if (supportedLocale.languageCode == "en") //locale?.languageCode)
            return supportedLocale;
        return supportedLocales.first;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return name == ""
        ? CreateJoinGroup(
            askName: true,
          )
        : Scaffold(
            appBar: AppBar(
                title: Text(AppLocalizations.of(context).translate("home"))),
            body: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(47.649281, -122.358524), zoom: 10),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
            drawer: Drawer(
                child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(name),
                  accountEmail: Text("+852 2345 6789"),
                  currentAccountPicture: CircleAvatar(
                    child: Text(name.substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 40)),
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).translate("home")),
                  leading: Icon(Icons.home),
                  selected: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                      AppLocalizations.of(context).translate("create-join")),
                  leading: Icon(Icons.group_add),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateJoinGroup(
                                  askName: false,
                                )));
                  },
                ),
                ListTile(
                  title: Text(
                      AppLocalizations.of(context).translate("address-book")),
                  leading: Icon(Icons.contacts),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  title:
                      Text(AppLocalizations.of(context).translate("settings")),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).translate("help")),
                  leading: Icon(Icons.help),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("You don't need help."),
                        content: Text("You're smart!"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                                AppLocalizations.of(context).translate("ok")),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            )),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black54,
                  onPressed: () {},
                  heroTag: null,
                  tooltip: "Centre map",
                  child: Icon(Icons.my_location),
                ),
                SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {},
                  tooltip: "Create a request",
                  child: Icon(Icons.add),
                ),
              ],
            ),
          );
  }
}

import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "main.dart";
import "localizations.dart";

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _name = myself.getName(), _phone = myself.getPhone();
  String _mood = moodMap[myself.getMood()];
  String _sex = sexMap[myself.getSex()];
  TextEditingController _controllerName =
      new TextEditingController(text: myself.getName());
  TextEditingController _controllerPhone =
      new TextEditingController(text: myself.getPhone());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("edit-profile")),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.mood),
            title: Text(AppLocalizations.of(context).translate("mood")),
            subtitle: DropdownButton<String>(
              value: _mood,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _mood = value;
                });
              },
              items: moodStringList.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            contentPadding: EdgeInsets.all(16),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(AppLocalizations.of(context).translate("name")),
            subtitle: TextField(
              enabled: true,
              controller: _controllerName,
              onChanged: (value) {
                _name = value;
              },
            ),
            contentPadding: EdgeInsets.all(16),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(AppLocalizations.of(context).translate("phone") +
                " (" +
                AppLocalizations.of(context).translate("optional") +
                ")"),
            subtitle: TextField(
              enabled: true,
              controller: _controllerPhone,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _phone = value;
              },
            ),
            contentPadding: EdgeInsets.all(16),
          ),
          ListTile(
            leading: Icon(Icons.wc),
            title: Text(AppLocalizations.of(context).translate("sex") +
                " (" +
                AppLocalizations.of(context).translate("optional") +
                ")"),
            subtitle: DropdownButton<String>(
              value: _sex,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _sex = value;
                });
              },
              items: sexStringList.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(),
          ListTile(),
          ListTile(
            title: RaisedButton(
              onPressed: () {
                myself.setData(
                    name: _name,
                    mood: getKeyFromMap(moodMap, _mood),
                    phone: int.parse(_phone),
                    sex: getKeyFromMap(sexMap, _sex));
                Navigator.pop(context);
              },
              textColor: Colors.white,
              color: themeColour,
              child: Text(AppLocalizations.of(context).translate("save")),
            ),
          ),
        ],
      ),
    );
  }
}

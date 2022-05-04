
import 'package:flutter/material.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/textstyle.dart';
import 'package:golden_lines/util/themes.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { Light, Dark }

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme;
  int groupValue = 0;

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("theme") == "light") {
      currentTheme = lightTheme;
      groupValue = 1;
    } else {
      currentTheme = darkTheme;
      groupValue = 2;
    }
    notifyListeners();
  }

  Future<void> saveTheme(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", name);
    print(prefs.getString("theme"));
  }

  themeChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        Widget cancelButton = TextButton(
          child: Text(
            AppLocalizations.of(context)!.translate('cancel').toString(),
            style: NormalOrangeTextStyle.display5(context),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        Widget continueButton = TextButton(
          child: Text(
            AppLocalizations.of(context)!.translate('ok').toString(),
            style: NormalOrangeTextStyle.display5(context),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        return AlertDialog(
            actions: [continueButton, cancelButton],
            backgroundColor: Provider.of<ThemeProvider>(context).currentTheme!.backgroundColor,
            title: Text(
              AppLocalizations.of(context)!.translate('lang').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      value: 1,
                      groupValue: groupValue,
                      activeColor: Provider.of<ThemeProvider>(context).currentTheme!.accentColor,
                      title: Text(
                        AppLocalizations.of(context)!.translate('lightTheme').toString(),
                        style: NormalOrangeTextStyle.display5(context),
                      ),
                      onChanged: (int? v) {
                        groupValue = v!;
                        currentTheme = lightTheme;

                        saveTheme("light");
                        //   Navigator.pushReplacementNamed(context, "/");
                        return notifyListeners();
                      },
                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: groupValue,
                      activeColor: Provider.of<ThemeProvider>(context).currentTheme!.accentColor,
                      title: Text(
                        AppLocalizations.of(context)!.translate('darkTheme').toString(),
                        style: NormalOrangeTextStyle.display5(context),
                      ),
                      onChanged: (int? v) {
                        groupValue = v!;
                        currentTheme = darkTheme;
                        saveTheme("dark");
                        //  Navigator.pushReplacementNamed(context, "/");
                        return notifyListeners();
                      },
                    ),
                  ],
                ),
              ),
            ));
      });
}

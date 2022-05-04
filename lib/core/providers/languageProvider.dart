
import 'package:flutter/material.dart';
import 'package:golden_lines/core/providers/theme_provider.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/textstyle.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
   Locale? currentLocale;
   String? langName;
   int groupValue=0;


   void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("lang") == "en") {
      currentLocale = Locale('en', 'US');
      groupValue=2;
    } else {
      currentLocale = Locale('ar', 'EG');
      groupValue=1;
    }
    notifyListeners();
  }

  Future<void> saveLanguage(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", name);
   // print(prefs.getString("lang"));
  }

  langChoiceDialog(BuildContext context) => showDialog(
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
            backgroundColor:  Provider.of<ThemeProvider>(context).currentTheme!.backgroundColor,
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
                      activeColor:  Provider.of<ThemeProvider>(context).currentTheme!.accentColor,
                      title: Text(
                        'العربية',
                        style: NormalOrangeTextStyle.display5(context),
                      ),
                      onChanged: (int? v){
                          groupValue = v!;
                          saveLanguage("ar");
                          currentLocale = Locale('ar', 'EG');
                       //   Navigator.pushReplacementNamed(context, "/");
                          return notifyListeners();

                      },

                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: groupValue,
                      activeColor:  Provider.of<ThemeProvider>(context).currentTheme!.accentColor,
                      title: Text(
                        'English',
                        style: NormalOrangeTextStyle.display5(context),
                      ),
                      onChanged: (int? v) {
                        groupValue = v!;
                        saveLanguage("en");
                        currentLocale = Locale('en', 'Us');
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

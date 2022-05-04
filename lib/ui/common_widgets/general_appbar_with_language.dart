import 'package:flutter/material.dart';
import 'package:golden_lines/core/providers/languageProvider.dart';
import 'package:golden_lines/core/providers/theme_provider.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/textstyle.dart';


import 'package:provider/provider.dart';

class GeneralAppBarWithLanguage extends StatelessWidget implements PreferredSizeWidget {
  late final String title;

  GeneralAppBarWithLanguage({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: NormalTextStyle.display5(context).copyWith(color: Colors.black),
      ),
      iconTheme: Provider.of<ThemeProvider>(context).currentTheme!.iconTheme,
      textTheme: Provider.of<ThemeProvider>(context).currentTheme!.appBarTheme.textTheme,
      actions: [
        Center(
          child: InkWell(
            onTap: (){
              Provider.of<LanguageProvider>(context, listen: false).langChoiceDialog(context);
              
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppLocalizations.of(context)!.translate("lang").toString(),
                style: NormalTextStyle.display5(context).copyWith(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}

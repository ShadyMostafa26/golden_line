
import 'package:flutter/material.dart';
import 'package:golden_lines/core/providers/theme_provider.dart';
import 'package:golden_lines/util/textstyle.dart';


import 'package:provider/provider.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  late final String title;
  GeneralAppBar({required this.title});


  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Color(0xffff5405),

      centerTitle: true,
      title: Text(
        title,
        style: NormalTextStyle.display5(context),
      ),
      iconTheme: Provider.of<ThemeProvider>(context).currentTheme!.iconTheme,
      textTheme: Provider.of<ThemeProvider>(context).currentTheme!.appBarTheme.textTheme,

    );
  }
}

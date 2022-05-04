
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_lines/core/providers/theme_provider.dart';
import 'package:golden_lines/util/textstyle.dart';

import 'package:provider/provider.dart';

class GeneralInput extends StatelessWidget {
  final Function(String) onChange;
  TextEditingController enter =TextEditingController();
  final String? hint;
  final TextInputType textInputType;
  final IconData icon;
 VoidCallback? onTap;
 bool isVisible;
  GeneralInput(
      {required this.onChange,
      required this.hint,
      required this.textInputType,
      required this.icon,required this.enter,
       this.onTap,
        this.isVisible = true,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
          color:Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
             maxLength: 5,
              obscureText: isVisible,
              enableInteractiveSelection: false,
              onChanged: onChange,
              autofocus: false,
              keyboardType: textInputType,
              style: NormalGreyTextStyle.display5(context),
              decoration: InputDecoration(
                counterText: '5 / ${(enter.text.length).toString()} ',
                counterStyle: TextStyle(color: Colors.black),
                suffixIcon: GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    icon,
                    color: Provider.of<ThemeProvider>(context).currentTheme!.accentColor,
                    size: 30,
                  ),
                ),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 15,color:Color(0xb4e80909)),

              ),
 controller:enter,
            ),
          )),
    );
  }
}

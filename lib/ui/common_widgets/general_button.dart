
import 'package:flutter/material.dart';


class GeneralButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  GeneralButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: width,
      height: 70,  //حجم زرار تفعيل طلبات المصعد
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xffff5405),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 22,color: Colors.white),
        ),
        onPressed: onTap,
      ),
    );
  }
}

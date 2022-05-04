import 'package:flutter/material.dart';
import 'package:golden_lines/util/textstyle.dart';


class GeneralCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  GeneralCard({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: width,
      height: height * .08,
      child: Card(
        color:Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          splashColor: Color(0xffff5405),
          onTap: onTap,
          child: Center(
            child: Container(
              width: width * .85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: NormalOrangeTextStyle.display5(context),
                    textAlign: TextAlign.start,
                  ),
                  Icon(Icons.arrow_forward_ios_outlined,size: 25,color: Color(0xffff5405),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

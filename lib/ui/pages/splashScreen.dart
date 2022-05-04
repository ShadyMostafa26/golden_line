import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', false);
      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }
  }

  void initState() {
    super.initState();
     Future.delayed(Duration(seconds: 2), () {
    Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xffff5405),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              width: double.infinity,
             // color: Color.fromRGBO(247,247,247,1),
              child: SafeArea(
                child: Image.asset(
                  'assets/images/up.jpg',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 100,
                  alignment: Alignment.topRight,
                ),
              ),
            ),
           // SizedBox(height: 100),
            Container(
              child: Image.asset(
                'assets/images/gll3.png',  // صورة اللوجو
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .7,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .4,
              ),
            ),

             SizedBox(height: 280),
             Expanded(
               child: Column(
                 children: [
                   Container(

                      child: Text(":Powered by",style:TextStyle(fontSize: 18,height: 1.1 ,fontFamily: 'Cairo',color: Color(0xffff5405))),

                   ),
                   Container(
                    child: Text("KAS",style:TextStyle(fontSize: 18,height: 1.1 ,fontFamily: 'Cairo',color: Color(0xffff5405))),

            ),
                   Expanded(
                     child: Image.asset(
                       'assets/images/down.jpg',
                        fit: BoxFit.cover,
                       width: double.infinity,
                       height: 100,
                       alignment: Alignment.topRight,
                     ),
                   ),
                 ],
               ),
             ),
            //--------------------------------------- حاجة جديده ------------------------------
              //    Container(decoration: BoxDecoration(border: Border.all(color: Colors.cyanAccent)),)
            //--------------------------------------- حاجة جديده ------------------------------

          ]
        ),
      ),
    );
  }

}

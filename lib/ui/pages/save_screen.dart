import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_lines/core/providers/user_provider.dart';
import 'package:golden_lines/ui/common_widgets/general_appbar.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/common.dart';
import 'package:golden_lines/util/textstyle.dart';

import 'package:provider/provider.dart';

class SaveScreen extends StatefulWidget {
  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> with WidgetsBindingObserver  {
  late var subscription;
late UserProvider provider;
  @override
  initState() {
    super.initState();
    provider = Provider.of<UserProvider>(context,listen: false);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        print("check");

      } else {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!
                .translate("connection_error")
                .toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0);

        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);
      }
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () async {

        provider.levelVisible = false;
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: GeneralAppBar(
            title: "",
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(AppLocalizations.of(context)!.translate("order_elevator").toString(),
                  style: LargeOrangeTextStyle.display5(context),
                    textAlign: TextAlign.center,

                  ),
                ),
                CircularCountDownTimer(
                  duration: int.parse(Common.timer),
                  initialDuration: 0,
                  controller: provider.countDownController,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  ringColor: Colors.white,
                  ringGradient: null,
                  fillColor: Color(0xffff5405),
                  fillGradient: null,
                  backgroundColor: Colors.black12,
                  backgroundGradient: null,
                  strokeWidth: 20.0,
                  strokeCap: StrokeCap.round,
                  textStyle: ExtraLargeOrangeTextStyle.display5(context),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {

                    print('Countdown Started');
                  },
                  onComplete: () {


                    print('Countdown Ended');
                    provider.levelVisible = false;
                    Navigator.pushNamedAndRemoveUntil(

                        context, '/home', (Route<dynamic> route) => false);
                  },
                ),

                /*
                Align(    //طريقة الكتابة القديمة
                alignment: AlignmentDirectional.centerStart,


                  //  child: Text('  شركه : ${  Common.Comp_Name  }' , style: TextStyle(color: Colors.orange,fontSize: 30,),)),
                    child: Text('  ${AppLocalizations.of(context)!.translate("Company_word").toString()}  ${  Common.Comp_Name  }',style: TextStyle(color: Colors.orange,fontSize: 30,),)),


                // child: Text('  ${AppLocalizations.of(context)!.translate("Company_word").toString()}',style: TextStyle(color: Color(0xffff5405),fontSize: 25),))
                    //Text('  ${Common.Comp_Name}',style: TextStyle(color: Color(0xffff5405),fontSize: 35,height: 1.1,)
                     //  SizedBox(height: 30,),
              */    //  //طريقة الكتابة القديمة لاسم الشركة في صفحة التايمر اللي بيلف


              // طريقة الكتابة الجديدة لاسم الشركة في صفحة التايمر اللي بيلف (( نفس اللي في الصفحة الرئيسية و نفس الكونتاينر
               /* Container(
                  margin: EdgeInsets.symmetric(horizontal: 25), //مسئولة عن حجم المربع الذي بداخلة اتحاد الملاك او اسم الشركة
                  child: Column(

                    children: [
                      Text('${AppLocalizations.of(context)!.translate("pass_hint").toString()} ',  // جملة يمكنك الحصول علي كلمة المرور من إتحاد الملاك
                        // AppLocalizations.of(context)!.translate("Comp_Name").toString(),
                        style: TextStyle(color: Color(0xffe72d0c),fontSize: 30,height: 0.3) ,  // مسئولة عن تنزيل احصل علي كلمة المرور و كل اللي تحت -- الي اسفل او اعلي
                        textAlign: TextAlign.right,
                      ),


                      SizedBox(height: 7,),  //مسئولة عن ابعاد كلمة اتحاد الملاك و تنزياها اسف و اعلي في نفس الوضع الراسي
                      Row(
                        children: [
                          Expanded(
                            child: Container(

                              decoration: BoxDecoration(border: Border.all(color:Color(0xffe72d0c),)),  // برواز إتحاد الملاك

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                /* children: [
                                   (Common.Comp_Name == null)? Text("اتحاد ملاك العقار او الشركه المسئوله عن المصعد ",style: TextStyle(color: Color(0xffff5405),fontSize: 25),):
                               Text(' ${Common.Comp_Name}',style: TextStyle(color: Color(0xffff5405),fontSize: 35,height: 1.1),),
                                 ],*/
                                children: [
                                  (Common.Comp_Name == null)? Text(' ${AppLocalizations.of(context)!.translate("Default_Company").toString()}',style: TextStyle(color: Color(
                                      0xffe72d0c),fontSize: 30),):
                                  Text('  ${Common.Comp_Name}',style: TextStyle(color: Color(
                                      0xffe72d0c),fontSize: 25,height: 1.1 ) ,),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                )*/





              ],
            ),

          ),

          /*SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: CircularCountDownTimer(
                    duration: int.parse(Common.timer),
                    initialDuration: 0,
                    controller: provider.countDownController,
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    ringColor: Colors.white,
                    ringGradient: null,
                    fillColor: Color(0xffff5405),
                    fillGradient: null,
                    backgroundColor: Colors.white,
                    backgroundGradient: null,
                    strokeWidth: 20.0,
                    strokeCap: StrokeCap.round,
                    textStyle: ExtraLargeOrangeTextStyle.display5(context),
                    textFormat: CountdownTextFormat.S,
                    isReverse: true,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: true,
                    onStart: () {
                      print('Countdown Started');
                    },
                    onComplete: () {
                      print('Countdown Ended');
                      provider.levelVisible = false;
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (Route<dynamic> route) => false);
                    },
                  ),
                )
              *//*  Center(
                  child: InkWell(
                    onTap: () {
                      provider.countDownController.start();
                      provider.sendPacket(context, "order_elevator");
                    },
                    child: CircularCountDownTimer(
                      duration: int.parse(Common.timer),
                      initialDuration: 0,
                      controller: provider.countDownController,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 2,
                      ringColor: Colors.white,
                      ringGradient: null,
                      fillColor: Color(0xffff5405),
                      fillGradient: null,
                      backgroundColor: Colors.white,
                      backgroundGradient: null,
                      strokeWidth: 20.0,
                      strokeCap: StrokeCap.round,
                      textStyle: ExtraLargeOrangeTextStyle.display5(context),
                      textFormat: CountdownTextFormat.S,
                      isReverse: true,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        print('Countdown Started');
                      },
                      onComplete: () {
                        print('Countdown Ended');
                        provider.levelVisible = false;
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ),
         *//**//*       Container(
                  child: Text(
                    AppLocalizations.of(context)!.translate("click_to_refresh").toString(),
                    style: NormalOrangeTextStyle.display5(context),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GeneralButton(
                  title: AppLocalizations.of(context)!.translate("order_elevator").toString(),
                  onTap: () {
                    provider.levelVisible = true;
                    provider.sendPacket(context, "order_elevator");
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .3,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: MediaQuery.of(context).size.height * .1,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: int.parse(Common.levels),
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              print(index);
                              provider.sendPacket(context, index.toString());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                index.toString(),
                                style: NormalTextStyle.display5(context),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffff5405),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                        }),
                  ),
                ),*//*
              ],
            ),
          ),*/
        ),

      ),
    );

  }

}

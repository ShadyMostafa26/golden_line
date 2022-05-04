import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_lines/core/providers/admin_provider.dart';
import 'package:golden_lines/ui/common_widgets/general_appbar.dart';
import 'package:golden_lines/ui/common_widgets/general_card.dart';
import 'package:golden_lines/ui/pages/admin_pages/user/table.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/common.dart';
import 'package:golden_lines/util/textstyle.dart';

import 'package:provider/provider.dart';

class AdminSettingsScreen2 extends StatefulWidget {
  const AdminSettingsScreen2({Key? key}) : super(key: key);

  @override
  _AdminSettingsScreenState2 createState() => _AdminSettingsScreenState2();
}

class _AdminSettingsScreenState2 extends State<AdminSettingsScreen2>
    with WidgetsBindingObserver {
  late AdminProvider provider;
  late var subscription;
  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    provider = Provider.of<AdminProvider>(context, listen: false);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {});
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    subscription.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AdminProvider>(context, listen: true);
    if (_lastLifecycleState == null) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      color: Color(0xffff5405),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SafeArea(
                      child: Column(
                       //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.dehaze,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.home,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50),
                                Container(
                                  margin: EdgeInsets.all(15),
                                  padding: EdgeInsets.all(15),
                                  height: MediaQuery.of(context).size.height * .2,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(255, 220, 214, 1),
                                  ),
                                 // color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        'الاعدادات الحاليه',
                                        style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)!.translate("client_password").toString(),
                                                    // AppLocalizations.of(context)!.translate("Comp_Name").toString(),

                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    Common.clientPassword.toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)!.translate("admin_password").toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    Common.adminPassword.toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)!.translate("Comp_Name").toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    Common.Comp_Name.toString(),
                                                    //Common.ssid.toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 80,
                                            child: VerticalDivider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)!.translate("timer_s").toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    Common.timer.toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)!.translate("ssid").toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    Common.ssid.toString(),
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          childAspectRatio: 1/0.7,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          children: [
                            buildGridItem(AppLocalizations.of(context)!.translate("change_client_password").toString(), 'assets/images/pass.jpg',() {
                              provider.sendPacket(context, "client_password_change");  //تغيير كلمة مرور العميل
                              provider.changeClientPasswordDialog(context);
                            }),
                            buildGridItem('تغيير وقت المؤقت', 'assets/images/timer.jpg',() {
                              provider.sendPacket(context, "timer_change");     // تغيير وقت التايمر
                              provider.changeTimerDialog(context);
                            }),

                            buildGridItem( AppLocalizations.of(context)!.translate("change_admin_password").toString(), 'assets/images/pass.jpg',() {
                              provider.sendPacket(context, "admin_password_change");       //تغيير كلمة مرور مدير الحساب
                              provider.changeAdminPasswordDialog(context);
                            }),
                            buildGridItem('تغيير شبكه WIFI', 'assets/images/wifi.jpg',() {
                              provider.sendPacket(context, "ssid_change");    //تغيير اسم شبكة الوايفاي
                              provider.changeWifiNameDialog(context);
                            },
                                text2: '(حد اقصي 15 حرف)'),
                            buildGridItem('تغيير اسم الشركه', 'assets/images/company.jpg',() {
                              provider.sendPacket(context, "Comp_Name_change");    //تغيير اسم الشركة
                              provider.changeComp_Name_Dialog(context);
                            },text2: '(حد اقصي 50 حرف)'),
                          ],
                        ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      provider.back(context);
      return SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
            title: AppLocalizations.of(context)!
                .translate("admin_settings")
                .toString(), // إعدادات مدير الحساب
          ),
          body: Center(
            child: Text(
              AppLocalizations.of(context)!
                  .translate("connection_error")
                  .toString(), // تم قطع الاتصال برجاء المحاولة مرة اخري
              style: LargeOrangeTextStyle.display5(context),
            ),
          ),
        ),
      );
    }
  }

  Widget buildGridItem(String text, String image,VoidCallback onTap, {String? text2}) => SizedBox(
    height: 100,
    child: GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,height: 100,width: 100,fit: BoxFit.cover,),
          Text(text ,style: TextStyle(color: Colors.black,fontFamily: 'Tajawal'),),
          Text(text2 ?? '',style: Theme.of(context).textTheme.caption!.copyWith(fontFamily: 'Tajawal',color: Colors.grey),)
        ],
      ),
    ),
  );

  void fixer() {
    var response;
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210)
        .then((RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = false;

      udpSocket.close();
    });
    return response;
  }

  Future<dynamic> sendPacket(BuildContext context, String data) async {
    String? responseString;
    var response;
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210)
        .then((RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = false;

      udpSocket.listen((e) {
        Datagram? dg = udpSocket.receive();
        if (dg != null) {
          udpSocket.close();
          print("received :: ${utf8.decode(dg.data)}");
        }
      });
      udpSocket.close();
    });

    return response;
  }
}
/*
  Container(
                      height: MediaQuery.of(context).size.height * .25,
                      color: Color(0xffff5405),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'مرحبا, محمد',
                                  style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),

                            Positioned(
                              child: Container(
                                height: MediaQuery.of(context).size.height * .2,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
*/

/*
  Scaffold(
            backgroundColor: Colors.white,
            appBar: GeneralAppBar(
              title: AppLocalizations.of(context)!.translate("admin_settings").toString(),
            ),
            body: SingleChildScrollView(
              //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color:Color.fromRGBO(247,247,247,1),
                    //color: Color(0xffff5405),
                   // color: Color(0xff0725f6),
                   // padding: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset(
                            'assets/images/gll2.jpg',  // صورة العامل و صفحة الأدمن
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .20,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                    SizedBox(
                      height: 25),
                        //---------------------------------------------client-pass -----------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.translate("client_password").toString(),
                              // AppLocalizations.of(context)!.translate("Comp_Name").toString(),

                              style: NormalTextStyle.display6(context),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              Common.clientPassword.toString(),
                              style: NormalTextStyle.display6(context),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //---------------------------------------------admin_password -----------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.translate("admin_password").toString(),
                              style: NormalTextStyle.display6(context),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              Common.adminPassword.toString(),
                              style: NormalTextStyle.display6(context),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        //---------------------------------------------timer_s -----------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.translate("timer_s").toString(),
                              style: NormalTextStyle.display6(context),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              Common.timer.toString(),
                              style: NormalTextStyle.display6(context),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //--------------------------------------------- SSID -----------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.translate("ssid").toString(),
                              style: NormalTextStyle.display6(context),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              Common.ssid.toString(),
                              style: NormalTextStyle.display6(context),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //--------------------------------------------- Comp_Name -----------------------------------------
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  AppLocalizations.of(context)!.translate("Comp_Name").toString(),
                                style: NormalTextStyle.display6(context),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  Common.Comp_Name.toString(),
                                  //Common.ssid.toString(),
                                  style: NormalTextStyle.display6(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //---------------------------------------------client-pass -----------------------------------------
                  GeneralCard(
                    title: AppLocalizations.of(context)!.translate("change_client_password").toString(),
                    onTap: () {
                      provider.changeClientPasswordDialog(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //---------------------------------------------admin_password -----------------------------------------
                  GeneralCard(
                    title:
                    AppLocalizations.of(context)!.translate("change_admin_password").toString(),
                    onTap: () {
                      provider.changeAdminPasswordDialog(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //---------------------------------------------timer_s -----------------------------------------
                  GeneralCard(
                    title: AppLocalizations.of(context)!.translate("change_timer").toString(),
                    onTap: () {
                      provider.changeTimerDialog(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //--------------------------------------------- SSID -----------------------------------------
                  GeneralCard(
                    title: AppLocalizations.of(context)!.translate("change_ssid").toString(),
                    onTap: () {
                      provider.changeWifiNameDialog(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //--------------------------------------------- Comp_Name -----------------------------------------
                  GeneralCard(
                    title: AppLocalizations.of(context)!.translate("Comp_Name_change").toString(),
                    onTap: () {
                      provider.changeComp_Name_Dialog(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //----------------------------------------------------------------------------
                 /* Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .08,
                    child: Card(
                      color:Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        //splashColor: Color(0xffff5405),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TableScreen();
                          },));
                        },
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.translate("user_passwords").toString(),
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
                  ),*/

                ],

              ),

            ),
          )
  */

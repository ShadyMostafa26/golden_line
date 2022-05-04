import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
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

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({Key? key}) : super(key: key);

  @override
  _AdminSettingsScreenState createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> with WidgetsBindingObserver {
  late AdminProvider provider;
  late var subscription;
  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    provider = Provider.of<AdminProvider>(context, listen: false);
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {

    });
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
    if (_lastLifecycleState == null)
      return WillPopScope(
        onWillPop: () async {

          provider.sendPacket(context, "admin_disconnected");

          return true;
        },

        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: GeneralAppBar(
              title: AppLocalizations.of(context)!.translate("admin_settings").toString(),
            ),
            body: SingleChildScrollView(
             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0xffff5405),
                   // color: Color(0xff0725f6),
                   // padding: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/gll2.jpg',  // صورة العامل و صفحة الأدمن
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .20,
                        ),
                        SizedBox(height: 15),


                    SizedBox(height: 25),
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
                        SizedBox(height: 5),
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
                      provider.sendPacket(context, "client_password_change");  //تغيير كلمة مرور العميل
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
                      provider.sendPacket(context, "admin_password_change");       //تغيير كلمة مرور مدير الحساب
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
                      provider.sendPacket(context, "timer_change");     // تغيير وقت التايمر
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
                      provider.sendPacket(context, "ssid_change");    //تغيير اسم شبكة الوايفاي
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
                      provider.sendPacket(context, "Comp_Name_change");    //تغيير اسم الشركة
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
                  )*/

                ],

              ),

            ),
          ),
        ),
      );
    else {
      provider.sendPacket(context, "admin_disconnected");
      provider.back(context);
      return SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
            title: AppLocalizations.of(context)!.translate("admin_settings").toString(),  // إعدادات مدير الحساب
          ),
          body: Center(
            child: Text(
              AppLocalizations.of(context)!.translate("connection_error").toString(), // تم قطع الاتصال برجاء المحاولة مرة اخري
              style: LargeOrangeTextStyle.display5(context),
            ),
          ),
        ),
      );
    }
  }
  void fixer() {

    var response;
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210).then((
        RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = false;


      udpSocket.close();
    });
    return response;
    }

  Future<dynamic> sendPacket(BuildContext context, String data) async {
    String? responseString;
    var response;
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210).then((
        RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = false;

      udpSocket.listen((e) {
        Datagram? dg = udpSocket.receive();
        if (dg != null) {
          udpSocket.close();
          print("received :: ${utf8.decode(dg.data)}");

        }
      });
      udpSocket.close();

    }
    );

    return response;
  }
  }


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_lines/core/model/json_response.dart';
import 'package:golden_lines/ui/common_widgets/general_input.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/common.dart';
import 'package:golden_lines/util/textstyle.dart';



class AdminProvider extends ChangeNotifier {
  var ipAddress = InternetAddress("192.168.4.1");
  int port = 4210;
  TextEditingController admin_password =TextEditingController();
  TextEditingController client_password =TextEditingController();
  TextEditingController timer_controll =TextEditingController();
  TextEditingController comp_name =TextEditingController();
  TextEditingController ssid_controll =TextEditingController();
  late String clientPassword, adminPassword, timer, ssid, Comp_Name;
  late String clientPasswordResponse, adminPasswordResponse, timerResponse,
      ssidResponse, Comp_NameResponse;

  // List<int> data = utf8.encode('connect');

//********************************************** معالجة زرار تغيير الباسورد ********************************************************
  changeClientPasswordDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Widget cancelButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('cancel').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),
            onPressed: () {
              sendPacket(context, "cancel");
              Navigator.pop(context);
              fixer();
            },
          );

          Widget continueButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('ok').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),

            onPressed: () async {
              if (clientPassword.isNotEmpty &&
                  clientPassword.length > 3 &&
                  clientPassword.length < 5) {
                Common.clientPassword=clientPassword;
                clientPassword = client_password.text;
                sendPacket(context, clientPassword).then((value) {
                  fixer();
                  print("value" + value.toString());
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.translate(
                          "change_success").toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 20.0);
                  Future.delayed(Duration(seconds: 3), () {
                    if (clientPasswordResponse == clientPassword) {
                      Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.translate(
                              "change_success").toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 20.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.translate(
                              "change_failed").toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 20.0);
                    }
                  });
                });
              } else {
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.translate(
                        "wrong_pass_user").toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 20.0);

                sendPacket(context, "cancel");
                fixer();
              }
              fixer();
              Navigator.pop(context);
            },
          );
          return WillPopScope(
            onWillPop: () async {
              sendPacket(context, "cancel");
              fixer();
              return true;
            },
            child: AlertDialog(
                actions: [continueButton, cancelButton],
                backgroundColor: Colors.white,
                title: Text(
                  AppLocalizations.of(context)!.translate(
                      "change_client_password").toString(),
                  style: NormalOrangeTextStyle.display5(context),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GeneralInput(
                          onChange: (value) {
                            clientPassword = client_password.text;
                            clientPassword = value;
                            notifyListeners();
                          },
                          hint: AppLocalizations.of(context)!
                              .translate("change_password_hint")
                              .toString(),
                          textInputType: TextInputType.phone,
                          icon: Icons.lock,
                          enter: client_password,

                        )

                      ],
                    ),
                  ),
                )),
          );
        });
  }

//***********************************************************************************************************************
//*************************************************معالجة زرار تغيير اسم الشبكة *******************************************************
  changeWifiNameDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Widget cancelButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('cancel').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),
            onPressed: () {

              sendPacket(context, "cancel");
              fixer();
              Navigator.pop(context);
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('ok').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),
            onPressed: () {
              if (ssid.length < 15 && ssid != null) {
                Common.ssid=ssid;

                sendPacket(context, ssid);
                fixer();
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.translate(
                        "change_success").toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 20.0);
              } else {
                Fluttertoast.showToast(
                    msg: 'حد اقصي 15 حرف',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 20.0);
              }
              fixer();
              Navigator.pop(context);
            },
          );
          return WillPopScope(
            onWillPop: () async {
              sendPacket(context, "cancel");
              fixer();
              return true;
            },
            child: AlertDialog(
                actions: [continueButton, cancelButton],
                backgroundColor: Colors.white,
                title: Text(
                  AppLocalizations.of(context)!
                      .translate("change_ssid")
                      .toString(),
                  style: NormalOrangeTextStyle.display5(context),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GeneralInput(
                          onChange: (value) {
                            ssid = value; //.split(" ").join(""); ;hkj fjogd lhtda lshti

                            print(ssid);
                            notifyListeners();
                          },
                          hint: AppLocalizations.of(context)!
                              .translate("change_ssid_hint")
                              .toString(),
                          textInputType: TextInputType.name,
                          icon: Icons.wifi_sharp,
                          enter: ssid_controll,
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  //***********************************************************************************************************************
//************************************************معالجة زرار تغيير كلمة مرور الادمن **************************************************
  changeAdminPasswordDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Widget cancelButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('cancel').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),
            onPressed: () {

              sendPacket(context, "cancel");
              fixer();
              Navigator.pop(context);
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('ok').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),
            onPressed: () {
              if (adminPassword.isNotEmpty &&
                  adminPassword.length > 4 &&
                  adminPassword.length < 6) {
                Common.adminPassword=adminPassword;

                sendPacket(context, adminPassword);
                adminPassword = admin_password.text;
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "تم التغيير بنجاح",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 20.0);

                if (adminPasswordResponse != null) {
                  Fluttertoast.showToast(
                      msg: "تم التغيير بنجاح",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 20.0);

                }
              }

              else {
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.translate(
                        "wrong_pass_admin").toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 20.0);

                sendPacket(context, "cancel");
                fixer();
              }

              Navigator.pop(context);
            },
          );
          return WillPopScope(
            onWillPop: () async {

              sendPacket(context, "cancel");
              fixer();
              return true;
            },
            child: AlertDialog(
                actions: [continueButton, cancelButton],
                backgroundColor: Colors.white,
                title: Text(
                  AppLocalizations.of(context)!.translate(
                      "change_admin_password").toString(),
                  style: NormalOrangeTextStyle.display5(context),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GeneralInput(
                          onChange: (value) {
                            adminPassword = value;
                            notifyListeners();
                          },
                          hint: AppLocalizations.of(context)!
                              .translate("change_password_hint")
                              .toString(),

                          textInputType: TextInputType.phone,
                          icon: Icons.lock,
                          enter: admin_password,

                        )

                      ],
                    ),
                  ),
                )),
          );
        });
  }

//*************************************************************************************************************************
// **************************************************معالجة زرار تغيير قيمة التايمر *************************************************

  changeTimerDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Widget cancelButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('cancel').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),

            onPressed: () {

              sendPacket(context, "cancel");
              fixer();
              Navigator.pop(context);
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('ok').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),

            onPressed: () async {
              if (timer.isNotEmpty && timer.length > 1 && timer.length < 3 &&
                  int.parse(timer) != 0) {
                Common.timer=timer;

                timer = timer_controll.text;
                sendPacket(context, timer);
                fixer();
                if (Common.timer == timer) {
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.translate(
                          "change_success").toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 20.0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!
                        .translate("wrong_timer")
                        .toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 20.0);

                sendPacket(context, "cancel");
                fixer();
              }
              fixer();
              Navigator.pop(context);
            },
          );
          return WillPopScope(
            onWillPop: () async {
              sendPacket(context, "cancel");
              fixer();
              return true;
            },
            child: AlertDialog(
                actions: [continueButton, cancelButton],
                backgroundColor: Colors.white,
                title: Text(
                  AppLocalizations.of(context)!
                      .translate("change_timer")
                      .toString(),
                  style: NormalOrangeTextStyle.display5(context),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GeneralInput(
                          onChange: (value) {
                            timer = value;
                            notifyListeners();
                          },
                          hint: AppLocalizations.of(context)!.translate("timer_hint").toString(),
                          textInputType: TextInputType.phone,
                          icon: Icons.timer,
                          enter: timer_controll,

                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }

//***********************************************************************************************************************
//***************************************************معالجة زرار تغيير أسم الشركة **************************************************
  changeComp_Name_Dialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Widget cancelButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('cancel').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),

            onPressed: () {
              // لازم ادوس عليها مرتين علشان تتحفظ هي و تغيير اسم الشبكة
              sendPacket(context, "cancel");
              fixer();
              Navigator.pop(context);
            },

          );
          Widget continueButton = TextButton(
            child: Text(
              AppLocalizations.of(context)!.translate('ok').toString(),
              style: NormalOrangeTextStyle.display5(context),
            ),

            onPressed: () {
              //   if (Comp_NameComp_NameResponse != null && Comp_Name.length < 50 )
              //  if (Comp_Name != null && Comp_Name.length < 50 )
              if (Comp_Name.length < 50 && Comp_Name != null) {
                Common.Comp_Name=Comp_Name;

                Comp_Name = comp_name.text;
                sendPacket(context, Comp_Name);
                fixer();
                Fluttertoast.showToast(
                  msg: AppLocalizations.of(context)!
                      .translate("change_success")
                      .toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 20.0,
                );
              } else {
                Fluttertoast.showToast(
                    msg: 'حد اقصي 50 حرف',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 20.0);
              }
              fixer();
              Navigator.pop(context);
            },
          );
          return WillPopScope(
            onWillPop: () async {

              sendPacket(context, "cancel");
              fixer();
              return true;
            },
            child: AlertDialog(
                actions: [continueButton, cancelButton],
                backgroundColor: Colors.white,
                title: Text(
                  AppLocalizations.of(context)!
                      .translate("Comp_Name_change")
                      .toString(),
                  style: NormalOrangeTextStyle.display5(context),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GeneralInput(
                          onChange: (value) {
                            Comp_Name =
                                value; //.split(" ").join("");  كانت بتخلي مافيش مسافه
                            print(Comp_Name);
                            notifyListeners();
                          },
                          hint: AppLocalizations.of(context)!
                              .translate("change_Comp_Name_hint")
                              .toString(),
                          textInputType: TextInputType.name,
                          icon: Icons.wifi_sharp,
                          enter: comp_name,
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }

//***********************************************************************************************************************

  Future<dynamic> sendPacket(BuildContext context, String data) async {
    String? responseString;
    var response;
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210).then((
        RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = false;

      udpSocket.send(utf8.encode(data), ipAddress, port);
      udpSocket.listen((e) {
        Datagram? dg = udpSocket.receive();
        if (dg != null) {
          udpSocket.close();
          print("received :: ${utf8.decode(dg.data)}");


          response = JsonResponse.fromJson(jsonDecode(utf8.decode(dg.data).toString()));
          clientPasswordResponse = response.clientPassword;
          adminPasswordResponse = response.adminPassword;
          timerResponse = response.timer;
          ssidResponse = response.ssid;
          Comp_NameResponse = response.Comp_Name;


          Common.timer = timerResponse;
          Common.clientPassword = clientPasswordResponse;
          Common.adminPassword = adminPasswordResponse;
          Common.ssid = ssidResponse;
          Common.Comp_Name = Comp_NameResponse;


          responseString = utf8.decode(dg.data).toString();
          notifyListeners();


        }
      });
      udpSocket.close();

    }
    );

    return response;
  }

  Future<void> back(BuildContext context) async {
    Future.delayed(Duration(seconds: 5), () {
      /*  Navigator.pushNamedAndRemoveUntil(
          context, '/home', (Route<dynamic> route) => false);*/

      sendPacket(context, "cancel");

      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  void fixer() {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210).then((
        RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = true;
      udpSocket.close();
    });
  }
}
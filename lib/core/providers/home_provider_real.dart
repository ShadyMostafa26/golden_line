import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_lines/core/model/json_response.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/common.dart';


import 'package:shared_preferences/shared_preferences.dart';





class HomeProvider extends ChangeNotifier {
  var ipAddress = InternetAddress("192.168.4.1");
  late String clientPassword, adminPassword, timer, ssid,Comp_Name;
  List<int> data = utf8.encode('start_connection');
  int port = 4210;
  String? password;
  bool loading = false;
  bool connected = false;
  @override
  void initState() {

  }
  @override
 // void checkConnection() async {}

  Future<void> connect(BuildContext context) async {
    loading = true;
    if (password != null) {
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210).then((RawDatagramSocket udpSocket) {
        udpSocket.broadcastEnabled = true;
        udpSocket.send(data, ipAddress, port);

        udpSocket.listen((e) async {

          Datagram? dg = udpSocket.receive();

          if (dg != null )
          {
            udpSocket.close();
            print("received :: ${utf8.decode(dg.data)}"); //تظهر جميع المتغيرات في الكونسول بمجرد لما بدخل في صفحة الأدمن

            var response = JsonResponse.fromJson(jsonDecode(utf8.decode(dg.data).toString()));

            clientPassword = response.clientPassword;  // بيقوم بقراءة المتغيرات واي فاي و يروح كاتبها علي شلشة الأدمن اول ما يقوم
            adminPassword = response.adminPassword;
            timer = response.timer;
            ssid = response.ssid;
            Comp_Name = response.Comp_Name;  // لكا كانت مش مكتوبة كان اول لما بيدخل صفحة الأدمن كان بيعطيني اسم الشركة "نول"

            Common.timer = timer;
            Common.clientPassword = clientPassword;
            Common.adminPassword = adminPassword;
            Common.ssid = ssid;
            Common.Comp_Name=Comp_Name; // لكا كانت مش مكتوبة كان اول لما بيدخل صفحة الأدمن كان بيعطيني اسم الشركة "نول"

            if (password == clientPassword) {

              loading = false;
              print("clientPassword :: " + clientPassword);

              Fluttertoast.showToast(
                  msg: AppLocalizations.of(context)!.translate("connected").toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 20.0,

              );

              //----------------------- المسئولة عن تخزين أسم الشركة و الباسورد علي التليفون -----------------------------------
              //----------------------------------------------------------------------------------------------
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString("pass", clientPassword);
              await prefs.setString("compName", Comp_Name);
              //----------------------------------------------------------------------------------------------

              Common.pass=clientPassword;
              Common.Comp_Name = Comp_Name;

              sendPacket("connect_user");

              Navigator.pushReplacementNamed(context, "/order").then((value) => udpSocket.close());

            }
            else if (password == adminPassword) {

              loading = false;
              print("adminPassword :: " + adminPassword);
              Fluttertoast.showToast(
                  msg: AppLocalizations.of(context)!.translate("admin_mode").toString(),
                 toastLength: Toast.LENGTH_SHORT,
                 gravity:ToastGravity.TOP ,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 20.0);
              //----------------------- المسئولة عن تخزين أسم الشركة و الباسورد علي التليفون -----------------------------------
              //----------------------------------------------------------------------------------------------
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString("pass", adminPassword);
              await prefs.setString("compName", Comp_Name);
              Common.pass=adminPassword;

              sendPacket("connected_admin");

              Navigator.pushNamed(context, "/admin_settings").then((value) => udpSocket.close());

            }
            else {
              loading = false;
              Fluttertoast.showToast(
                  msg: AppLocalizations.of(context)!.translate("wrong_pass").toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 20.0);
            }
          }
        });

      });
    } else {

      loading = false;
      //print(password!.length.toString());
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.translate("empty_pass").toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 20.0,
      );
    }
    loading = false;

  }

  Future<dynamic> sendPacket(String data) async {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210).then((RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = true;
      udpSocket.send(utf8.encode(data), ipAddress, port);
      udpSocket.close();
      udpSocket.listen((e) {
        Datagram? dg = udpSocket.receive();
        if (dg != null) {
          udpSocket.close();
          print("received :: ${utf8.decode(dg.data)}");

          notifyListeners();
        }
      });
      udpSocket.close();
    });
  }

  }


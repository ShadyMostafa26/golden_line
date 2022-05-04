import 'dart:convert';
import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class UserProvider extends ChangeNotifier {
  var ipAddress = InternetAddress("192.168.4.1");
  int port = 4210;

  bool levelVisible = false;
  bool connected = false;
  CountDownController countDownController = CountDownController();

  Future<void> sendPacket(BuildContext context, String data) async {

    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210).then((RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = false;
      udpSocket.send(utf8.encode(data), ipAddress, port);
      udpSocket.listen((e) {

        Datagram? dg = udpSocket.receive();


        if (dg != null) {

          sendPacket(context, "admin_disconnected");
          print("received :: ${utf8.decode(dg.data)}");
           udpSocket.close;

        }else if(dg != null){
          udpSocket.close();

        }
       });
      udpSocket.close();

     });

  }



 void checkConnection(BuildContext context) async {

    /*var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) {
      connected = true;
      notifyListeners();
    } else {
      connected = false;


      notifyListeners();

    }*/
  }
}

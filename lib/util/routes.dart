import 'package:flutter/material.dart';
import 'package:golden_lines/ui/pages/admin_pages/admin_settings_screen.dart';
import 'package:golden_lines/ui/pages/admin_pages/admin_settings_screen2.dart';
import 'package:golden_lines/ui/pages/guest%20page.dart';
import 'package:golden_lines/ui/pages/home_screen.dart';
import 'package:golden_lines/ui/pages/order_screen.dart';
import 'package:golden_lines/ui/pages/save_screen.dart';
import 'package:golden_lines/ui/pages/splashScreen.dart';


Map<String, WidgetBuilder> routes = {
  "/": (context) => SplashScreen(),
  "/home": (context) => HomeScreen(),
  "/admin_settings": (context) => AdminSettingsScreen(),
  "/admin_settings2": (context) => AdminSettingsScreen2(),

  "/order": (context) => OrderScreen(),
  "/save" : (context) => SaveScreen(),
  "/guest": (context) => guest(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
  "/": (context) => SplashScreen(),
};

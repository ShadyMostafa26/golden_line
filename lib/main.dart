import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:golden_lines/ui/pages/admin_pages/user/cubit.dart';
import 'package:golden_lines/ui/pages/admin_pages/user/states.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/common.dart';
import 'package:golden_lines/util/providers.dart';
import 'package:golden_lines/util/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/providers/languageProvider.dart';
import 'core/providers/theme_provider.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("lang") == null) {
    await prefs.setString("lang", "ar");
  }
  if (prefs.getString("pass") != null) {
   Common.pass=prefs.getString("pass");
  }
  Common.Comp_Name = prefs.getString('compName');

/*  var DESTINATION_ADDRESS=InternetAddress("192.168.4.1");

  RawDatagramSocket.bind(InternetAddress.anyIPv4,4210).then((RawDatagramSocket udpSocket) {
    udpSocket.broadcastEnabled = true;
    udpSocket.listen((e) {
      Datagram? dg = udpSocket.receive();
      if (dg != null) {
        print("received:: ${utf8.decode(dg.data)}");
      }
    });
    List<int> data =utf8.encode('0000');
    udpSocket.send(data, DESTINATION_ADDRESS,4210);
  });*/

  runApp(
    MultiProvider(
      providers: providers,
      builder: (BuildContext context, child) {
        Provider.of<LanguageProvider>(context).getLang();
        Provider.of<ThemeProvider>(context).getTheme();
        // print(Provider.of<LanguageProvider>(context,listen: false).currentLocale);
        return BlocProvider(
          create: (_) => AppCubit()..createDatabase(),
          child: BlocConsumer<AppCubit,AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                title: 'Kas Fi',
                theme: Provider.of<ThemeProvider>(context).currentTheme,
                debugShowCheckedModeBanner: false,
                routes: routes,
                initialRoute: '/',
                // home: AdminSettingsScreen(),
                locale: Provider.of<LanguageProvider>(context).currentLocale,
                supportedLocales: [
                  const Locale('ar', 'EG'),
                  const Locale('en', 'US'),
                ],
                localizationsDelegates: [
                  // A class which loads the translations from JSON files
                  AppLocalizations.delegate,
                  // Built-in localization of basic text for Material widgets
                  GlobalMaterialLocalizations.delegate,
                  // Built-in localization for text direction LTR/RTL
                  GlobalWidgetsLocalizations.delegate,

                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  // Check if the current device locale is supported
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale!.languageCode &&
                        supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },

              );
            },
          ),
        );
      },
    ),
  );
}



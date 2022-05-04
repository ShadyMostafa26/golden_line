import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_lines/core/providers/home_provider.dart';
import 'package:golden_lines/core/providers/theme_provider.dart';
import 'package:golden_lines/ui/common_widgets/general_appbar_with_language.dart';
import 'package:golden_lines/ui/common_widgets/general_button.dart';
import 'package:golden_lines/ui/common_widgets/general_input.dart';
import 'package:golden_lines/ui/pages/admin_pages/admin_settings_screen2.dart';
import 'package:golden_lines/util/app_localizations.dart';
import 'package:golden_lines/util/common.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:open_settings/open_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_pages/admin_settings_screen.dart';
import 'package:http/http.dart' as http;
import 'admin_pages/user/table.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider provider;
  late var subscription;
  bool isVisible = false;
  TextEditingController admin_password =TextEditingController();
  @override
  void initState() {

    super.initState();
    provider = Provider.of<HomeProvider>(context, listen: false);
    print(provider.connected);
    if (Common.pass != null) {
      provider.password=Common.pass;
    }
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        print("سيتم كتابتها عندما تلقط الابلكيشن اي شبكة واي فاي ");

        provider.connected=true;
      } else {
        provider.connected = false;
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!
                .translate("connection_error")
                .toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 20.0);
        Text('ss',style: TextStyle(color: Colors.black),);
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<HomeProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: GeneralAppBarWithLanguage(

          title: AppLocalizations.of(context)!.translate("home").toString(),
        ),
        body: SingleChildScrollView(

          child: LoadingOverlay(

            isLoading: provider.loading,
            color: Colors.orange,
            opacity: .1,
            progressIndicator: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Provider.of<ThemeProvider>(context).currentTheme!.colorScheme.secondary),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               /*   Visibility(
                    visible: !provider.connected,
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          OpenSettings.openWIFISetting();
                          print("click");
                        },
                        child: Text(
                          AppLocalizations.of(context)!.translate("connected_hint").toString(),
                          style: NormalOrangeTextStyle.display5(context),
                        ),
                      ),
                    ),
                  ),*/
                  Column(

                    children: [
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
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          'assets/images/gll3.png', // بيجيب الصورة من هنا
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .30,

                        ),
                      ),
                      SizedBox(height: 10),
                      GeneralInput(
                        isVisible: isVisible,
                          onChange: (value) {
                            provider.password = value;
                          },
                          hint: Common.pass != null
                              ? Common.pass
                              : AppLocalizations.of(context)!.translate("password").toString(),
                          textInputType: TextInputType.phone,
                          icon: (isVisible)? Icons.visibility : Icons.visibility_off,
                        onTap: (){
                            setState(() {
                              isVisible = !isVisible;
                            });
                        },
                      enter: admin_password,

                      ),
                      SizedBox(height: 18),
                      GeneralButton(
                       title: AppLocalizations.of(context)!.translate("connect").toString(),     // زر تفعيل طلبات المصعد
                        onTap: () {
                          provider.connect(context);
                          setState(() {

                          });
                        },
                      ),
                    ],
                  ),

                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Image.asset(
                      'assets/images/down.jpg',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 70,

                    ),
                  ),

                  /* Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextButton(onPressed: (){}, child: Text('نسيت كلمه المرور ؟',textAlign: TextAlign.start,style: TextStyle(),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40  // مسئولة عن ابعاد كلمة احصل علي كلمة المرور و تنزياها اسف و اعلي في نفس الوضع الراسي
                  ),

                ElevatedButton(
                    onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminSettingsScreen2();
                  },));
                }, child: Text('table')),*/
                  /*ElevatedButton(
                      onPressed: () async{
                      http.Response res =await http.get(Uri.parse("https://192.168.4.1"));

                      print(res.toString());
                  },
                      child: Text("Tap")),*/
                 /* Container(
                    margin: EdgeInsets.symmetric(horizontal: 25), //مسئولة عن حجم المربع الذي بداخلة اتحاد الملاك او اسم الشركة
                    child: Column(
                      children: [
                        SizedBox(height: 17),  //مسئولة عن ابعاد كلمة اتحاد الملاك و تنزياها اسف و اعلي في نفس الوضع الراسي
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                         padding: EdgeInsets.all(20),
                               //decoration: BoxDecoration(border: Border.all(width: 5 ,color:Color(0xffe72d0c), )),  // برواز إتحاد الملاك

                                  child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                  *//* children: [
                                     (Common.Comp_Name == null)? Text("اتحاد ملاك العقار او الشركه المسئوله عن المصعد ",style: TextStyle(color: Color(0xffff5405),fontSize: 25),):
                                 Text(' ${Common.Comp_Name}',style: TextStyle(color: Color(0xffff5405),fontSize: 35,height: 1.1),),
                                   ],*//*
                                   children: [
                                     (Common.Comp_Name == null)? Text(' ${AppLocalizations.of(context)!.translate("Default_Company").toString()}',style: TextStyle(color: Color(
                                         0xffe72d0c),fontSize: 30),):
                                     Text( '${Common.Comp_Name}',style: TextStyle(color: Color(
                                         0xffe72d0c),fontSize: 30,height: 1.1 ,fontFamily: 'NotoSansArabic') ,),
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
          ),
        ),
      ),
    );
  }
}

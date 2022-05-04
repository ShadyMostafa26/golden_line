import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_lines/ui/pages/admin_pages/user/cubit.dart';
import 'package:golden_lines/ui/pages/admin_pages/user/mobile.dart';
import 'package:golden_lines/ui/pages/admin_pages/user/states.dart';
import 'package:golden_lines/util/app_localizations.dart';


import 'package:syncfusion_flutter_pdf/pdf.dart';

class TableScreen extends StatefulWidget {
  
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {


  List<dynamic> change = [];

  List<Map> user2 = [];

  List<Map<String, dynamic>> searched = [];



  var nameController = TextEditingController();
  var passController = TextEditingController();
  var searchController = TextEditingController();

  ////////////////////////////////////////////////////////


  
  Future<List<int>> _readFontData() async {
    final ByteData bytes = await rootBundle.load('assets/fonts/arial.ttf');
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  Future<void> createPdf() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    document.pageSettings.size = PdfPageSize.a4;
    String text = change.toString();
    PdfFont font = PdfTrueTypeFont(await _readFontData(), 13);

    page.graphics.drawString(
      text,
      font,
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(
          0, 0, page
          .getClientSize()
          .width, page
          .getClientSize()
          .height),
      format: PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35,
        characterSpacing: 5,
        wordWrap: PdfWordWrapType.word,
      ),
    );

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'names.pdf');
  }
  ////////////////////////////////////////////////////////////////


  bool load = false;
@override
  void initState() {
    super.initState();
   Future.delayed(Duration(seconds: 9),(){
     load = true;
   });
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (load)? Scaffold(
          backgroundColor: Colors.white.withOpacity(0.3),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: FloatingActionButton.extended(
                  heroTag: null,
                  onPressed:(){
                    change = AppCubit.get(context).users.map((e) => e['name'] + ":" + e['pass'] + '\n').toList();
                    createPdf();
                  },
                  icon: Icon(Icons.share),
                  label: Text(AppLocalizations.of(context)!.translate("share").toString()),

                ),
              ),
              FloatingActionButton(
                heroTag:  null,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            TextFormField(
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                hintText: 'الاسم',
                                                hintStyle:
                                                TextStyle(color: Colors.black),
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              controller: passController,
                                              decoration: InputDecoration(
                                                hintText: 'الرقم السري',
                                                hintStyle:
                                                TextStyle(color: Colors.black),
                                                // border: OutlineInputBorder(),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            ElevatedButton(
                                              onPressed: () {
                                                AppCubit.get(context).insertToDatabase(
                                                  name: nameController.text.length > 10? nameController.text.substring(0,10).toLowerCase() : nameController.text ,
                                                  pass: passController.text.length > 4? passController.text.substring(0,4).toLowerCase() : passController.text,
                                                );

                                                Navigator.pop(context);
                                                nameController.clear();
                                                passController.clear();
                                              },
                                              child: Text('اضافه'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.translate("add").toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                               AppCubit.get(context).deleteALl();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.translate("delete_all").toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.keyboard_arrow_up_sharp, size: 30),
              ),

            ],
          ),
          appBar: AppBar(
            elevation: 0,

            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: Colors.blue),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      user2 = AppCubit.get(context).users.where((element) => element['name'].contains(value.toLowerCase())).toList();
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.translate("search").toString(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          body: searchController.text.isEmpty
              ? SingleChildScrollView(
                child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                width: double.infinity,
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('الاسم'),
                            Text(' الرقم'),
                            Text('إلغاء'),
                            Text('حذف مؤقت'),
                          ],
                        ),
                        Divider(height: 2, color: Colors.black),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:   AppCubit.get(context).users.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              hoverColor: Colors.blue,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              AppCubit.get(context).deleteData(AppCubit.get(context).users[index]['id']);
                                              setState(() {
                                                /* model.removeAt(index);*/
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              'حذف',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  buildData(index),
                                ],
                              ),
                            ),
                            Divider(height: 2, color: Colors.black),
                          ],
                        );
                      },
                    ),
                  ],
                ),
            ),
          ),
              )
              : SingleChildScrollView(
                child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                width: double.infinity,
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('الاسم'),
                            Text(' الرقم'),
                            Text('إلغاء'),
                            Text('حذف مؤقت'),
                          ],
                        ),
                        Divider(height: 2, color: Colors.black),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:  /*model.length*/ user2.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              hoverColor: Colors.blue,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              AppCubit.get(context).deleteData(AppCubit.get(context).users[index]['id']);
                                              setState(() {
                                                /* model.removeAt(index);*/
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              'حذف',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  buildData2(index),
                                ],
                              ),
                            ),
                            Divider(height: 2, color: Colors.black),
                          ],
                        );
                      },
                    ),
                  ],
                ),
            ),
          ),
              ),
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }

  Row buildData(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        Text(
        /* model[index].name*/ AppCubit.get(context).users[index]['name'],
          style: TextStyle(fontSize: 20),
        ),
        Text(
            AppCubit.get(context).users[index]['pass'],
          style: TextStyle(fontSize: 15),
        ),
        Checkbox(
          value:AppCubit.get(context).users[index]['cancelUser'] == 0? false : true,
          onChanged: (value) {
            AppCubit.get(context).updateCancel(cancel:AppCubit.get(context).users[index]['cancelUser'], id:AppCubit.get(context).users[index]['id'] );

          },
        ),
        Checkbox(
          value: AppCubit.get(context).users[index]['deleteUser'] == 0? false : true,
          onChanged: (value) {
            AppCubit.get(context).updateDelete(delete:AppCubit.get(context).users[index]['deleteUser'], id:AppCubit.get(context).users[index]['id'] );

          },
        ),
      ],
    );
  }

  Row buildData2(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        Text(
          /* model[index].name*/ user2[index]['name'],
          style: TextStyle(fontSize: 20),
        ),
        Text(
          /*model[index].pass*/ user2[index]['pass'],
          style: TextStyle(fontSize: 15),
        ),
        Checkbox(
          value: /*model[index].cancel*/ user2[index]['cancelUser'] == 0? false : true,
          onChanged: (value) {
            AppCubit.get(context).updateCancel(cancel:user2[index]['cancelUser'], id:user2[index]['id'] );

          },
        ),
        Checkbox(
          value:  /*model[index].delete */user2[index]['deleteUser'] == 0? false : true,
          onChanged: (value) {
            AppCubit.get(context).updateDelete(delete:user2[index]['deleteUser'], id:user2[index]['id'] );

          },
        ),
      ],
    );
  }
}

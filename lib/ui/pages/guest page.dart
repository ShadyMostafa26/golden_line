import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class guest extends StatefulWidget {

  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<guest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,

      home: Scaffold(
backgroundColor: Colors.white,
        appBar: AppBar(
          title:Text('Work Page',style:TextStyle(fontSize: 28,color:Colors.white)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
backgroundColor: Colors.deepOrange,
    ),
    body: Center(


child: Column(
      children: <Widget>[
        SizedBox(height: 160,),
        Text('choose the mode of work:',style:TextStyle(fontSize: 33,color: Colors.black),),
        SizedBox(height: 27,),
        RaisedButton( onPressed: (){
          Navigator.pushReplacementNamed(context, "/order");
        },
          child: Text('User',style:TextStyle(fontSize: 40,color:Colors.white,)),
          padding:EdgeInsets.all(12) ,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),

          ),
        ),
        SizedBox(height: 10,),
        Text('Or',style:TextStyle(fontSize: 32,color: Colors.black),),
        SizedBox(height: 10,),
        RaisedButton(onPressed:(){ Navigator.pushNamed(context, "/admin_settings2");}, child:Text('Admin',style:TextStyle(fontSize: 40,color:Colors.white,)),padding:EdgeInsets.all(12) ,
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),

            ))
      ],),
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.

    ),



// Column is also a layout widget. It takes a list of children and
// arranges them vertically. By default, it sizes itself to fit its
// children horizontally, and tries to be as tall as its parent.
//
// Invoke "debug painting" (press "p" in the console, choose the
// "Toggle Debug Paint" action from the Flutter Inspector in Android
// Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
// to see the wireframe for each widget.
//
// Column has various properties to control how it sizes itself and
// how it positions its children. Here we use mainAxisAlignment to
// center the children vertically; the main axis here is the vertical
// axis because Columns are vertical (the cross axis would be
// horizontal).

),

    );

  }}

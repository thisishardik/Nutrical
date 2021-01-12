import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

//   custom_dialog(context);   Simply add this line to call the dialog box
// import 'package:nutrical/model/custom_dialogbox.dart';    and add this package

Future<Widget> custom_dialog(context){
  return showDialog(
      context: context,
      builder: (_) => AssetGiffyDialog(
         title: Text("Succefully Task Completed",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
         image: Image.asset('images/winner.gif',fit:BoxFit.cover,),
         entryAnimation: EntryAnimation.BOTTOM,
         buttonOkText: Text('Share'),
         onlyOkButton: true,
         buttonOkColor: Colors.orange[300],
         cornerRadius: 20.0,
         onOkButtonPressed: () {},
  ));
}
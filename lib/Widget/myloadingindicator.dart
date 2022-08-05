import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

myLoadingIndicator(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: SizedBox(
      width: 80.0,
      //size.width,
      height: 40.0,
      //size.height*0.08,
      child: Row(
        children: [
          CircularProgressIndicator(),
          const SizedBox(width: 10.0),
          const Text("Loading...")
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

confirmationDialog(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: Text("LogOut", style: TextStyle(fontWeight: FontWeight.bold)),
    content: SizedBox(
      // width: size.width * 0.2,
      height: 100.0,
      //size.height*0.08,
      child: Row(
        children: [
          Text("You are about to logout, please confirm"),
        ],
      ),
    ),
    actions: [
      InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              width: 90.0,
              height: 40.0,
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.7),
              child: Text("Cancel"))),
      SizedBox(
        width: 5.0,
      ),
      InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Get.toNamed("/Splashscreen");
          },
          child: Container(
              width: 90.0,
              height: 40.0,
              alignment: Alignment.center,
              color: Colors.red,
              child: Text("Logout", style: TextStyle(color: Colors.white))))
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

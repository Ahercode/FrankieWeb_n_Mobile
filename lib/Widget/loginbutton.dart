import 'package:flutter/material.dart';
import 'package:frankie_s/API/apis.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:frankie_s/Widget/myloadingindicator.dart';
import 'package:frankie_s/ui/homepage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Model/foodModel.dart';
class LoginButton {
  button(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        if (context.read<Model>().username.text == "" ||
            context.read<Model>().password.text == "") {
          const snackBar = SnackBar(content: Text("Field cannot be Empty"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } /*else if (context.read<Model>().username.text == "admin" &&
            context.read<Model>().password.text == "admin") {
          Get.toNamed("/HomePage");
        } */
        else {
          myLoadingIndicator(context);
          DatabaseAPI().signIn(context);
          /* const snackBar =
              SnackBar(content: Text("Username or password incorrect"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
        }
      },
      child: Container(
        width: size.width * 0.2,
        height: size.height * 0.08,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
        ),
        child: Text("Login",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
      ),
    );
  }
}

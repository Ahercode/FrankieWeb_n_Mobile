import 'package:flutter/material.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:provider/provider.dart';

class SignInPageTextField {
  fieldControllers(BuildContext context, title) {
    if (title == "Username") {
      return context.read<Model>().username;
    } else if (title == "Password") {
      return context.read<Model>().password;
    }
  }

  textField(BuildContext context, text) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.3,
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
        controller: fieldControllers(context, text),
        style: const TextStyle(fontSize: 20.0),
        obscureText: text == "Password" ? true : false,
        decoration: InputDecoration(hintText: text, border: InputBorder.none),
        textAlign: TextAlign.center,
      ),
    );
  }
}

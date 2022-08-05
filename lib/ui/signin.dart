import 'package:flutter/material.dart';
import 'package:frankie_s/Widget/backgroundColor.dart';

import 'package:frankie_s/Widget/logo.dart';
import 'package:frankie_s/Widget/signintextfield.dart';
import 'package:provider/provider.dart';

import '../Model/foodModel.dart';
import '../Model/model.dart';
import '../Widget/loginbutton.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void dispose() {
    context.read<Model>().username.clear();
    context.read<Model>().password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyBackgroundColor().backgroundColor(),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo().logo(),
            SizedBox(height: 20.0),
            SignInPageTextField().textField(context, "Username"),
            SizedBox(height: 20.0),
            SignInPageTextField().textField(context, "Password"),
            SizedBox(
              height: 20.0,
            ),
            LoginButton().button(context),
          ],
        ),
      )),
    );
  }
}

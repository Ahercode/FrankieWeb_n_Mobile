import 'package:flutter/material.dart';
import 'package:frankie_s/Widget/backgroundColor.dart';
import 'package:frankie_s/Widget/logo.dart';
import 'package:frankie_s/Widget/showmeals.dart';
import 'package:frankie_s/ui/menuselection.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Model/foodModel.dart';
import '../Model/model.dart';
import '../Widget/menuoptions.dart';
import '../Widget/optionButtons.dart';

class MenuSelection extends StatelessWidget {
  MenuSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      // appBar: AppBar(
      //     elevation: 0.0,
      //     leading: IconButton(
      //       icon: Icon(Icons.arrow_back_ios),
      //       iconSize: 40.0,
      //       color: Colors.white,
      //       onPressed: () {
      //         Navigator.pushNamed(context, "/HomePage");
      //         //Get.toNamed("/HomePage");
      //       },
      //     ),
      //     title: Text(
      //       "FRANKIE'S",
      //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //     ),
      //     backgroundColor: MyBackgroundColor().backgroundColor(),
      //     actions: [
      //       Logo().logo(),
      //     ]),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(
          top: 10,
          right: 20,
          left: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  // backgroundImage: NetworkImage(
                  //     "frankie_s/assets/profile.png"),

                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            // Container(
            //   color: Colors.transparent,
            //   //MyBackgroundColor().backgroundColor(),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       SystemOptionButton().optionButton(
            //           context, "Type", context.watch<Model>().selectedTab),
            //       SystemOptionButton().optionButton(context, "SelectedTable",
            //           "${context.read<Model>().tableNumber}"),
            //     ],
            //   ),
            // ),
            MenuOptions().category(context),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                width: size.width,
                // height: size.height * 0.81,
                //color: Colors.white.withOpacity(0.9),
                child: Expanded(
                  child: Row(
                    children: [
                      //MenuOptions().meals(context),
                      Meals().meals(context, context.read<Model>().categoryId),
                      MenuOptions().cart(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:frankie_s/Widget/backgroundColor.dart';
import 'package:frankie_s/ui/menuselection.dart';
import '../Model/foodModel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SystemOptionButton {
  optionButton(BuildContext context, title, text) {
    //print(text);
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: title == "Type" || title == "SelectedTable"
          ? () {}
          : () {
              //print(tableNumber);
              context.read<Model>().openTable(text);
              Get.to(() => MenuSelection());
            },
      child: Card(
        child: Container(
          width: size.width * 0.2,
          height: size.height * 0.08,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: /*title == "Type" || title == "SelectedTable"
                ? MyBackgroundColor().backgroundColor()
                : tableNumber == 1 ||
                        tableNumber == 8 ||
                        tableNumber == 16 ||
                        tableNumber == 12
                    ? Colors.redAccent
                    : */
                Colors.lightGreen,
            border: Border.all(),
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: title == "Type"
              ? Text(text,
                  style: TextStyle(fontSize: 20.0, color: Colors.white))
              : title == "SelectedCategory"
                  ? Text("${context.read<Model>().tableNumber}",
                      style: TextStyle(fontSize: 20.0, color: Colors.white))
                  : Text("$text",
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/foodModel.dart';
import '../Model/model.dart';

class MyCheckBox {
  box(BuildContext context, title) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.12,
      child: Card(
        elevation: 5.0,
        child: Row(children: [
          Checkbox(
              value: title == "Cash"
                  ? context.watch<Model>().isCash
                  : title == "Mobile Money"
                      ? context.watch<Model>().isMomo
                      : title == "Card"
                          ? context.watch<Model>().isCard
                          : false,
              onChanged: (value) {
                if (title == "Cash") {
                  context.read<Model>().cashChecked(true);
                } else if (title == "Mobile Money") {
                  context.read<Model>().momoChecked(true);
                } else if (title == "Card") {
                  context.read<Model>().cardChecked(true);
                }
              }),
          Text(title,
              style: TextStyle(
                fontSize: 22.0,
              ))
        ]),
      ),
    );
  }
}

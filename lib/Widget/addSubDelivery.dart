import 'package:flutter/Material.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:provider/provider.dart';
import '../Model/foodModel.dart';
import 'backgroundColor.dart';

deliveryCostbuttons(BuildContext context, size, text, icon) {
  return InkWell(
    onTap: context.watch<Model>().deliveryCost.text == ""
        ? () {}
        : () {
            if (text == "ADD") {
              if (context.read<Model>().totalAmoutDueAndDeliveryCost == null ||
                  context.read<Model>().totalAmoutDueAndDeliveryCost == "") {
                context.read<Model>().computeTotalAndDelivery(
                      double.parse(context.read<Model>().totalAmountDue!) +
                          double.parse(context.read<Model>().deliveryCost.text),
                    );
              } else {
                context.read<Model>().computeTotalAndDelivery(
                      double.parse(context
                              .read<Model>()
                              .totalAmoutDueAndDeliveryCost!) +
                          double.parse(context.read<Model>().deliveryCost.text),
                    );
              }

              //Updates change to give to customer
              if (context.read<Model>().amountPaid.text != "") {
                if (context.read<Model>().change != "0.0" ||
                    context.read<Model>().change != "0.00") {
                  //print(context.read<Model>().change);
                  context.read<Model>().changeToGive(
                        double.parse(context.read<Model>().amountPaid.text) -
                            double.parse(context
                                .read<Model>()
                                .totalAmoutDueAndDeliveryCost!),
                      );
                }
              }
            } else if (text == "SUB") {
              if (context.read<Model>().totalAmoutDueAndDeliveryCost == null ||
                  context.read<Model>().totalAmoutDueAndDeliveryCost == "") {
                context.read<Model>().computeTotalAndDelivery(
                      double.parse(context.read<Model>().totalAmountDue!) -
                          double.parse(context.read<Model>().deliveryCost.text),
                    );
              } else {
                context.read<Model>().computeTotalAndDelivery(
                      double.parse(context
                              .read<Model>()
                              .totalAmoutDueAndDeliveryCost!) -
                          double.parse(context.read<Model>().deliveryCost.text),
                    );
              }

              //Updates change to give to customer
              if (context.read<Model>().amountPaid.text != "") {
                if (context.read<Model>().change != "0.0" ||
                    context.read<Model>().change != "0.00") {
                  context.read<Model>().changeToGive(
                        double.parse(context.read<Model>().amountPaid.text) -
                            double.parse(context
                                .read<Model>()
                                .totalAmoutDueAndDeliveryCost!),
                      );
                }
              }
            }
          },
    child: Container(
      width: size.width * 0.07,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: context.watch<Model>().deliveryCost.text == ""
            ? Colors.grey
            : MyBackgroundColor().backgroundColor(),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 20.0)),
        ],
      ),
    ),
  );
}

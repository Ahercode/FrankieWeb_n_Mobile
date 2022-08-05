import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:provider/provider.dart';
import '../Model/foodModel.dart';
class AmountToBePaid {
  fields(BuildContext context, size, text, control) {
    return Container(
      width: size,
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          text == "Due" || text == "Change"
              ? Card(
                  child: Container(
                      width: size,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                          text == "Due"
                              ? context
                                              .watch<Model>()
                                              .totalAmoutDueAndDeliveryCost ==
                                          null ||
                                      context
                                              .watch<Model>()
                                              .totalAmoutDueAndDeliveryCost ==
                                          ""
                                  ? "Ghc ${context.watch<Model>().totalAmountDue}"
                                  : "Ghc ${context.watch<Model>().totalAmoutDueAndDeliveryCost!}"
                              : "Ghc ${context.watch<Model>().change}",
                          style: TextStyle(fontSize: 22.0))),
                )
              : TextField(
                  controller: control
                  /*context.watch<Model>().isCard
                      ? context.watch<Model>().cardNumber
                      : context.watch<Model>().isMomo
                          ? context.watch<Model>().momoNumber
                          : context.watch<Model>().amountPaid*/
                  ,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: text),
                  onChanged: (value) {
                    try {
                      if (context.read<Model>().amountPaid.text == "") {
                        context.read<Model>().changeToGive(0.0);
                      }
                      if (context.read<Model>().totalAmoutDueAndDeliveryCost ==
                              null ||
                          context.read<Model>().totalAmoutDueAndDeliveryCost ==
                              "") {
                        context.read<Model>().changeToGive(double.parse(
                                context.read<Model>().amountPaid.text) -
                            double.parse(
                                context.read<Model>().totalAmountDue!));
                      } else {
                        context.read<Model>().changeToGive(double.parse(
                                context.read<Model>().amountPaid.text) -
                            double.parse(context
                                .read<Model>()
                                .totalAmoutDueAndDeliveryCost!));
                      }
                    } catch (e) {}
                  }),
        ],
      ),
    );
  }
}

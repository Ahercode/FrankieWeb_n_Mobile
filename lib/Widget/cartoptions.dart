import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/Material.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:frankie_s/Widget/backgroundColor.dart';
import 'package:frankie_s/Widget/printreceipt.dart';
import 'package:frankie_s/ui/paymentpage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_printer/sunmi_printer.dart';

import '../Model/cartlistbloc.dart';

class CartOptions {
  options(BuildContext context, text, List<FoodItem> foodItems) {
    Size size = MediaQuery.of(context).size;
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          foodItems = snapshot.data;
          return InkWell(
            onTap: () {
              if (text == "Proceed") {
                //print(context.read<Model>().totalAmountDue);
                //Receipt().receipt(foodItems);
                if (foodItems.isNotEmpty) {
                  context.read<Model>().changeToGive(0.0);
                  context.read<Model>().amountPaid.clear();
                  context.read<Model>().deliveryCost.clear();
                  context.read<Model>().computeTotalAndDelivery("");
                  Get.to(() => PaymentPage(foodItems));
                }
              } else if (text == "Clear") {
                bloc.emptyCart(foodItems, context);
                (context as Element).markNeedsBuild();
              }
            },
            child: Container(
              width: size.width * 0.06,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                color: foodItems.isNotEmpty
                    ? MyBackgroundColor().backgroundColor()
                    : Colors.grey,
                borderRadius: BorderRadius.circular(7.0),
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
    /*InkWell(
      onTap: () {
        if (text == "Proceed") {
          Receipt().receipt(foodItems);
          //Get.to(() => const PaymentPage());
        }
      },
      child: Container(
        width: size.width * 0.1,
        height: size.height * 0.08,
        color: MyBackgroundColor().backgroundColor(),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
 */
  }
}

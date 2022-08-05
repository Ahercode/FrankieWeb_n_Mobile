import 'package:flutter/material.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:frankie_s/Model/paymentMethodModel.dart';
import 'package:frankie_s/Widget/addSubDelivery.dart';
import 'package:frankie_s/Widget/backgroundColor.dart';
import 'package:frankie_s/Widget/checkbox.dart';
import 'package:frankie_s/Widget/logo.dart';
import 'package:frankie_s/ui/saleagentpage.dart';
import 'package:provider/provider.dart';

import '../Model/foodModel.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage(this.foodItems, {Key? key}) : super(key: key);
  var foodItems;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: MyBackgroundColor().backgroundColor(),
        title: Text("FRANKIE'S",
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [Logo().logo()],
      ),
      body: Row(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.6,
                  //color: Colors.yellow,
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  alignment: Alignment.center,
                  child: ListView(
                    children: [
                      for (var paymentMethod in methodList.paymentmethodList!)
                        Builder(builder: (context) {
                          return SizedBox(
      height: size.height * 0.12,
      child: Card(
        elevation: 5.0,
        child: Row(children: [
          Checkbox(
              value: paymentMethod.name == "Cash"
                  ? context.watch<Model>().isCash
                  : paymentMethod.name == "Mobile Money"
                      ? context.watch<Model>().isMomo
                      : paymentMethod.name == "Card"
                          ? context.watch<Model>().isCard
                          : false,
              onChanged: (value) {
                if (paymentMethod.name == "Cash") {
                  context.read<Model>().cashChecked(true);
                } else if (paymentMethod.name == "Mobile Money") {
                  context.read<Model>().momoChecked(true);
                } else if (paymentMethod.name == "Card") {
                  context.read<Model>().cardChecked(true);
                }
              }),
          Text(paymentMethod.name!,
              style: TextStyle(
                fontSize: 22.0,
              ))
        ]),
      ),
    );
 
                        }),
                    ],
                  ),
                  /*Column(
                    children: [
                      MyCheckBox().box(context, "Cash"),
                      MyCheckBox().box(context, "Mobile Money"),
                      MyCheckBox().box(context, "Card"),
                    ],
                  ),*/
                ),
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.25,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  //color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Delivery cost:",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.15,
                            child: TextField(
                              controller: context.read<Model>().deliveryCost,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "0.0",
                                  hintStyle: TextStyle(fontSize: 30)),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  context
                                      .read<Model>()
                                      .computeTotalAndDelivery("");
                                } else {
                                  (context as Element).markNeedsBuild();
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 15.0),
                          deliveryCostbuttons(context, size, "ADD", Icons.add),
                          SizedBox(width: 15.0),
                          deliveryCostbuttons(
                              context, size, "SUB", Icons.remove),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: size.width * 0.4,
                        height: size.height * 0.1,
                        //padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ListView(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Family",
                                      style: TextStyle(fontSize: 20.0)),
                                  Text("10%", style: TextStyle(fontSize: 20.0))
                                ]),
                            Divider(),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Staff",
                                      style: TextStyle(fontSize: 20.0)),
                                  Text("20%", style: TextStyle(fontSize: 20.0))
                                ]),
                            Divider(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: size.width * 0.6,
              height: size.height,
              child: SaleAgentPage(foodItems)),
        ],
      ),
    );
  }
}

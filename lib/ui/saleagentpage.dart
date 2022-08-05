import 'package:flutter/material.dart';
import 'package:frankie_s/API/apis.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:frankie_s/Widget/amoutpaidfields.dart';
import 'package:frankie_s/Widget/backgroundColor.dart';
import 'package:frankie_s/Widget/paymentoptionmenu.dart';
import 'package:frankie_s/Widget/printreceipt.dart';
import 'package:frankie_s/ui/testPrinter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_printer/sunmi_printer.dart';

import '../Model/foodModel.dart';

class SaleAgentPage extends StatelessWidget {
  SaleAgentPage(this.foodItems, {Key? key}) : super(key: key);
  var foodItems;
  late PrinterStatus _printerStatus;
  late PrinterMode _printerMode;
  Future<void> _getPrinterStatus(BuildContext context) async {
    final PrinterStatus result = await SunmiPrinter.getPrinterStatus();
    _printerStatus = result;
    (context as Element).markNeedsBuild();
  }

  Future<PrinterMode> _getPrinterMode() async {
    final PrinterMode mode = await SunmiPrinter.getPrinterMode();
    return mode;
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Sale agent",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      ),
      body: context.watch<Model>().isCash == false &&
              context.watch<Model>().isMomo == false &&
              context.watch<Model>().isCard == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.read<Model>().totalAmoutDueAndDeliveryCost ==
                                null ||
                            context
                                    .read<Model>()
                                    .totalAmoutDueAndDeliveryCost ==
                                ""
                        ? 'Ghc ${context.watch<Model>().totalAmountDue}'
                        : "Ghc ${context.read<Model>().totalAmoutDueAndDeliveryCost!}",
                    style: TextStyle(
                        fontSize: 120.0,
                        color: MyBackgroundColor().backgroundColor(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Please select a Payment Method",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          : Column(
              children: [
                context.watch<Model>().isCash == false
                    ? Container()
                    : PaymentModePage().paymentPage(context, size, "Cash",
                        "Due", null, "Amount Paid", "Change"),
                context.watch<Model>().isMomo == false
                    ? Container()
                    : PaymentModePage().paymentPage(
                        context,
                        size,
                        "Mobile Money",
                        "Due",
                        "Mobile Money",
                        "Amount Paid",
                        "Change"),
                context.watch<Model>().isCard == false
                    ? Container()
                    : PaymentModePage().paymentPage(context, size, "Card",
                        "Due", "Card", "Amount Paid", "Change"),
              ],
            ),
      floatingActionButton: InkWell(
        onTap: () {
          // print("Post sales");

          DatabaseAPI().postTransaction(context, foodItems);
          
          if (context.read<Model>().isCard != false ||
              context.read<Model>().isCash != false ||
              context.read<Model>().isMomo != false) {
            _bindingPrinter().then((bool? isBind) async => {
                  if (isBind!)
                    {
                      _getPrinterStatus(context),
                      _printerMode = await _getPrinterMode(),
                    }
                });
            Receipt().receipt(context, foodItems);
            // print("sales post");
            // DatabaseAPI().postTransaction(context, foodItems);
          }
        },
        child: Container(
          width: size.width * 0.15,
          height: size.height * 0.1,
          decoration: BoxDecoration(
              color: (context.watch<Model>().isCard == false &&
                          context.watch<Model>().isCash == false &&
                          context.watch<Model>().isMomo == false) ||
                      context.watch<Model>().amountPaid.text == "" ||
                      double.parse(context.watch<Model>().change) < 0
                  ? Colors.grey
                  : MyBackgroundColor().backgroundColor(),
              borderRadius: BorderRadius.circular(7.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

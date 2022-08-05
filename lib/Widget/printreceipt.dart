import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_printer/sunmi_printer.dart';
import 'package:intl/intl.dart';
import '../Model/foodModel.dart';
import '../ui/splashscreen.dart';

/*class PaymentInfo {
  int? id;
  String? taxName;
  double? amount;

  PaymentInfo(
      {@required this.id, @required this.taxName, @required this.amount});
}

class paymentInfoList {
  List<PaymentInfo>? taxes;
  BuildContext context BuildContext;
  paymentInfoList({@required this.taxes},context);
}

double delivery() {
  Builder(builder: (BuildContext context) {
    return 2.4;
  });
  return 0.0;
}

paymentInfoList fooditemList = paymentInfoList(taxes: [
  PaymentInfo(
    id: 1,
    taxName: "SubTotal",
    amount: 0.0,
  ),
  PaymentInfo(
    id: 2,
    taxName: "3% VAT Rate",
    amount: 0.0,
  ),
  PaymentInfo(
    id: 3,
    taxName: "Delivery Charges",
    amount: delivery(),
  ),
  FoodItem(
    id: 4,
    name: "Chilly Cheeze Burger",
    description:
        "Some delicious variety of Continental food made just for you.",
    price: 14.49,
    imgPath: "Hamburger meal, Zinger Tower.png",
  ),
  FoodItem(
    id: 5,
    name: "Beach BBQ Burger",
    description: "Made by the best just for you",
    price: 14.49,
    imgPath: "lebanese.png",
  ),
  FoodItem(
    id: 6,
    name: "Beach BBQ Burger",
    description: "Eat healthy to stay healthy",
    price: 14.49,
    imgPath: "salad.png",
  ),
]);
*/
class Receipt {
  Future<void> receipt(BuildContext context, List<FoodItem> foodItems) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String deliveryCost = context.read<Model>().deliveryCost.text.trim() == ""
        ? "0.00"
        : "${double.parse(context.read<Model>().deliveryCost.text.toString()).toStringAsFixed(2)}";
    String cashAmount =
        double.parse(context.read<Model>().amountPaid.text).toStringAsFixed(2);
    //print(cashAmount);
    String formattedDate = formatter.format(now);
    String formattedTime = DateFormat.Hms().format(now);
    String companyName = "FRANKIES RESTAURANT";
    String companyNumber = "Mobile:0302773567/0249680000";
    String receiptType = "- SALES RECEIPT -";
    String lines = "--------------------------------";
    String doubleLines = "================================";
    List subTotals = [
      ["SubTotal", "${context.read<Model>().totalAmountDue}"],
      ["3% VAT Rate", "0.00"],
      ["Delivery Charges", deliveryCost],
      ["Total", "${context.read<Model>().totalAmountDue}"],
      ["Cash Amount", "$cashAmount"],
      ["Change", "${context.read<Model>().change}"],
      [
        "Payment Method",
        context.read<Model>().isCash
            ? "Cash"
            : context.read<Model>().isMomo
                ? "Mobile Money"
                : "Card"
      ]
    ];
    int count = 1;
    List wordSpacers = [
      "                              ",
      "                             ",
      "                            ",
      "                           ",
      "                          ",
      "                         ",
      "                        ",
      "                       ",
      "                      ",
      "                     ",
      "                    ",
      "                   ",
      "                  ",
      "                 ",
      "                ",
      "               ",
      "              ",
      "             ",
      "            ",
      "           ",
      "          ",
      "         ",
      "        ",
      "       ",
      "      ",
      "     ",
      "    ",
      "   ",
      "  ",
      " ",
      "",
    ];
    var newDateFormat = new DateFormat('dd-MM-yy');
    String formattedDates = newDateFormat.format(now);
    String time = DateFormat.Hms().format(now);
    String receiptNo =
        formattedDates + time + username!.substring(0, 2).toUpperCase();
    String receiptDetails =
        "Server: $username\nType:${context.read<Model>().selectedTab}\nTable:${context.read<Model>().tableNumber}\nDate: ${formattedDate.toString()} ${formattedTime.toString()}\nReceipt No: ${receiptNo.replaceAll(RegExp('[^A-Za-z0-9]'), '')}\nShop:Location";
    String elementType =
        "Items${wordSpacers["Items".length + "Ghc".length - 2]}Ghc";
    String space = """



    """;
    //print(receiptNo.replaceAll(RegExp('[^A-Za-z0-9]'), ''));
    //String otherCalculation =
    //    "===============\nSubTotal              Ghc0.0\n3% VAT Rate                 Ghc0.0\nDelivery charge                Ghc0.0\nAmout Due                Ghc${context.read<Model>().totalAmountDue}";
    //print(test.toList());
    //List check = [];

    //print(foodItems.toList());
    //(_printerStatus);
    final ByteData bytes = await rootBundle.load("assets/Frankie's_Logo.jpeg");
    final Uint8List list = bytes.buffer.asUint8List();
    /*if (_printerStatus == PrinterStatus.NORMAL &&
        _printerMode == PrinterMode.LABEL_MODE) {*/
    //print("Read");
    // must start with this function if you are print with label
    await SunmiPrinter.startLabelPrint();

    /// 0 align left, 1 center, 2 align right.
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    /*await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText("--------------------------------");*/
    // spacing line
    ///await SunmiPrinter.lineWrap(1);
    // print image only support Uint8List
    await SunmiPrinter.printImage(list);
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText(companyName);
    //await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.setAlignment(PrintAlign.LEFT);
    await SunmiPrinter.printText(companyNumber);
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText(receiptType);
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText(lines);
    await SunmiPrinter.setAlignment(PrintAlign.LEFT);
    await SunmiPrinter.printText(receiptDetails);
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText(lines);
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText(elementType);
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText(lines);
    await SunmiPrinter.setAlignment(PrintAlign.LEFT);
    //await SunmiPrinter.lineWrap(1);
    foodItems.forEach((element) async {
      //try {
      /*var val = double.parse(
              element.name!.length.toString() + element.quantity.toString()) +
          double.parse(element.price.toString());*/
      //String names;
      //names = element.name!.replaceRange(20, null, '...');
      //  var computeLengths = names.length +
      //      element.price!.toStringAsFixed(2).length +
      //      element.quantity.toString().length;
      var amout = element.quantity! * element.price!;
      var currentItemTotalAmount = "${amout.toStringAsFixed(2)}";
      var currentTotalAmountLength = currentItemTotalAmount.toString().length;
      var quantityAndPrice =
          "${element.quantity}x ${element.price!.toStringAsFixed(2)}";
      try {
        // print(computeLengths + currentTotalAmountLength);
        //print(computeLengths);
        // print(currentTotalAmountLength);
        //print(formattedDate + formattedTime);
        await SunmiPrinter.printText(
            "${count++}. ${element.name}\n${wordSpacers[29 - (count).toString().length]}$quantityAndPrice${wordSpacers[quantityAndPrice.length + currentItemTotalAmount.length - 1 + (count).toString().length]}$currentItemTotalAmount");
        //count++;
        /*SunmiPrinter.printText(
              "${wordSpacers[currentTotalAmountLength]}$currentItemTotalAmount");*/
      } catch (e) {
        print(e);
        await SunmiPrinter.printText(
            "[${count++}]${element.name}\n$quantityAndPrice${wordSpacers[30]}$currentItemTotalAmount");
        //count++;
        /* print(currentTotalAmountLength);
          print(
              "$names ${wordSpacers[30]}${element.quantity}x ${element.price}");
          print(
              "${wordSpacers[currentTotalAmountLength - 2]}$currentItemTotalAmount");*/
      }
    });
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText(doubleLines);
    await SunmiPrinter.setAlignment(PrintAlign.LEFT);
    for (var item in subTotals) {
      try {
        await SunmiPrinter.printText(
            "${item[0]} ${wordSpacers[item[0].length + item[1].length]} ${item[1]}");
      } catch (e) {
        await SunmiPrinter.printText(
            "${item[0]} ${wordSpacers[30]} ${item[1]}");
      }
    }
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText(doubleLines);
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText("Thank You Enjoy!");
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText("www.frankies.com.gh/delivery");
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText("Delivery Numbers:0276444444 / 0574333333");
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText("0546699999(whatsApp Only)");
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printText(space);
    /* await SunmiPrinter.lineWrap(0);
    await SunmiPrinter.printText(receiptBody);*/
    // only run exitLabelPrint at last index if you need print multiple label at once;
    await SunmiPrinter.exitLabelPrint();
    //}
    foodItems.clear();
    context.read<Model>().dispose();
    Get.toNamed("/Splashscreen");
  }
}

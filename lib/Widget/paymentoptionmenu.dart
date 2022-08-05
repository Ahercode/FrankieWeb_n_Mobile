import 'package:flutter/material.dart';
import 'package:frankie_s/Widget/amoutpaidfields.dart';
import 'package:provider/provider.dart';
import '../Model/foodModel.dart';
import '../Model/model.dart';

class PaymentModePage {
  paymentPage(BuildContext context, size, title, due, mobileOrCardNumber,
      amountPaid, change) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(title,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Due
              AmountToBePaid().fields(context, size.width * 0.13, due, null),
              //Mobile Number
              mobileOrCardNumber == null
                  ? Container()
                  : AmountToBePaid().fields(
                      context,
                      size.width * 0.13,
                      mobileOrCardNumber,
                      mobileOrCardNumber == "Mobile Money"
                          ? context.read<Model>().momoNumber
                          : context.read<Model>().cardNumber),
              //Amount paid
              AmountToBePaid().fields(context, size.width * 0.13, amountPaid,
                  context.read<Model>().amountPaid),
              //Charges
              AmountToBePaid().fields(context, size.width * 0.13, change, null),
            ],
          ),
        ],
      ),
    );
  }
}

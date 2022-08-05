import 'package:flutter/Material.dart';
import 'package:frankie_s/Model/model.dart';

class PaymentMethod {
  int? id;
  String? name;
  String? code;
  //FooditemList? itemList;

  PaymentMethod({
   @required this.id,
   @required this.name,
   @required this.code,
  });

  PaymentMethod.fromMapObject(map) {
    this.id = map['id'];
    this.name = map['name'].toString().trim();
    this.code = map['code'];
  }
  
}

class PaymentMethodlist {
  List<PaymentMethod>? paymentmethodList;

  PaymentMethodlist({@required this.paymentmethodList});
}

PaymentMethodlist methodList = PaymentMethodlist(paymentmethodList: []);

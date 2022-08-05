// To parse this JSON data, do
//
//     final saleModel = saleModelFromJson(jsonString);

import 'dart:convert';

SaleModel saleModelFromJson(String str) => SaleModel.fromJson(json.decode(str));

String saleModelToJson(SaleModel data) => json.encode(data.toJson());

class SaleModel {
  SaleModel({
    this.operatorId,
    this.locationId,
    this.description,
    this.receiptNumber,
    this.discountTypeId,
    this.voucherId,
    this.taxId,
    required this.salesTransactionPaymentMethods,
    required this.salesTransactionProducts,
  });

  int? operatorId;
  int? locationId;
  String? description;
  String? receiptNumber;
  int? discountTypeId;
  int? voucherId;
  int? taxId;
  List<SalesTransactionPaymentMethod> salesTransactionPaymentMethods;
  List<SalesTransactionProduct> salesTransactionProducts;

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        operatorId: json["operatorId"],
        locationId: json["locationId"],
        description: json["description"],
        receiptNumber: json["receiptNumber"],
        discountTypeId: json["discountTypeId"],
        voucherId: json["voucherId"],
        taxId: json["taxId"],
        salesTransactionPaymentMethods:
            List<SalesTransactionPaymentMethod>.from(
                json["salesTransactionPaymentMethods"]
                    .map((x) => SalesTransactionPaymentMethod.fromJson(x))),
        salesTransactionProducts: List<SalesTransactionProduct>.from(
            json["salesTransactionProducts"]
                .map((x) => SalesTransactionProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "operatorId": operatorId,
        "locationId": locationId,
        "description": description,
        "receiptNumber": receiptNumber,
        "discountTypeId": discountTypeId,
        "voucherId": voucherId,
        "taxId": taxId,
        "salesTransactionPaymentMethods": List<dynamic>.from(
            salesTransactionPaymentMethods.map((x) => x.toJson())),
        "salesTransactionProducts":
            List<dynamic>.from(salesTransactionProducts.map((x) => x.toJson())),
      };
}

class SalesTransactionPaymentMethod {
  SalesTransactionPaymentMethod({
    this.paymentMethodId,
    this.amount,
    this.description,
  });

  int? paymentMethodId;
  int? amount;
  String? description;

  factory SalesTransactionPaymentMethod.fromJson(Map<String, dynamic> json) =>
      SalesTransactionPaymentMethod(
        paymentMethodId: json["paymentMethodId"],
        amount: json["amount"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "paymentMethodId": paymentMethodId,
        "amount": amount,
        "description": description,
      };
}

class SalesTransactionProduct {
  SalesTransactionProduct({
    this.productId,
    this.quantity,
  });

  int? productId;
  int? quantity;

  factory SalesTransactionProduct.fromJson(Map<String, dynamic> json) =>
      SalesTransactionProduct(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}

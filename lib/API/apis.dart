import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frankie_s/Model/model.dart';
import 'package:frankie_s/ui/splashscreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/foodModel.dart';

String baseUrl = "https://app.sipconsult.net/SipRestaurantApi";

class DatabaseAPI {
  getCategories(BuildContext context) async {
    var url = Uri.parse('$baseUrl/api/ProductCategories');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  getPaymentMethod(BuildContext context) async {
    var url = Uri.parse('$baseUrl/api/PaymentMethods');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    return jsonDecode(response.body);
  }

  getProductsPerCategories(BuildContext context, id) async {
    var url = Uri.parse('$baseUrl/api/Products');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  getLocation(BuildContext context, id) async {
    var url = Uri.parse('$baseUrl/api/locations');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  postOrders(BuildContext context, List<FoodItem> foodItems) async {
    var url = Uri.parse('$baseUrl/api/Orders');
    var response = await http.post(url, headers: {
      "Content-Type": "application/json"
    }, body: {
      //'order ite'
    });
    return jsonDecode(response.body);
  }

  Future<dynamic> postTransaction(
      BuildContext context, List<FoodItem> foodItems) async {
    var url = Uri.parse('$baseUrl/api/SaleTransaction');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": "4",
          "Locattion": '2',
          "name": "Hi ",
          "price": '24.67',
          "quantity": '6',
          "receiptNum": '17',
          "Username": "Hi",
          "Password": "test",
        }));
    print(response.body);
    return (response.body);
  }

  signIn(BuildContext context) async {
    try {
      var url = Uri.parse('$baseUrl/api/Employees/Authenticate');
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Username": context.read<Model>().username.text,
            //"John001",
            "Password": context.read<Model>().password.text
            //"Password@123",
          }));
      //print(response.statusCode);
      //print(jsonDecode(response.body));
      if (response.statusCode != 200) {
        // Navigator.pop(context);
        // const snackBar =
        //     SnackBar(content: Text("Username or password incorrect"));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

      } else {
        print(jsonDecode(response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username',
            context.read<Model>().username.text.trim().toLowerCase());
        Navigator.pop(context);
        //context.read<Model>().resetVariables();
        //Get.toNamed("/Splashscreen");
        Get.to(() => SplashScreen());
      }
    } catch (e) {
      Navigator.pop(context);
      var snackBar = SnackBar(content: Text("$e"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

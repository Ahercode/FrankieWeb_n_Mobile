import 'dart:async';
import 'package:frankie_s/API/apis.dart';
import 'package:flutter/material.dart';
import 'package:frankie_s/Model/catCustom.dart';
import 'package:frankie_s/Model/paymentMethodModel.dart';
import 'package:frankie_s/Widget/backgroundColor.dart';
import 'package:frankie_s/Widget/logo.dart';
import 'package:frankie_s/ui/signin.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/model.dart';

String? username;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List categories = [];
List items = [];

class _SplashScreenState extends State<SplashScreen> {
  getCatAndItems(BuildContext context) async {
    var catResponse = await DatabaseAPI().getCategories(context);
    categoryList.catList!.clear();
    for (var item in catResponse['data']) {
      //categories.add(item);
      categoryList.catList!.add(ItemCategory(
        catDescription: item['description'],
        catId: item['id'],
        catImg: item['image'],
        catName: item['name'],
      ));
    }
    Map<String, dynamic> itemResponse =
        await DatabaseAPI().getProductsPerCategories(context, 'id');
    fooditemList.foodItems!.clear();
    for (var val in itemResponse['data']) {
      //items.add(val);
      fooditemList.foodItems!.add(
        FoodItem(
            id: val['id'],
            name: val['name'],
            description: val['description'],
            price: val['salePrice'],
            imgPath: val['image'],
            categoryId: val['categoryId'],
           
            quantity: 1),
      );
    }

    var paymentMethodResponse = await DatabaseAPI().getPaymentMethod(context);
    methodList.paymentmethodList!.clear();
    for (var methods in paymentMethodResponse['data']) {
      //print(methods);
      methodList.paymentmethodList!.add(
        PaymentMethod(
          id: methods['id'],
          name: methods['name'],
          code: methods['code'],
        ),
      );
    }
    //test();
  }

/*
var comments = <Comment>[...];
var count = comments.where((c) => c.product_id == someProductId).toList().length;
*/
  /* test() {
    //CatItemlist? cat;
    //print(myData);
    for (var item in items.where((element) => element['categoryId'] == 17)) {
      print(item);
    }
  }*/
  /*Future<List<FoodItem>> getCatAndItems(BuildContext context) async {
    var list =
        await DatabaseAPI().getProductsPerCategories(context, "id");
    //print(list);
    //var data = list["data"];
    //print(data);
    for (var item in list['data']) {
      item['category'].map((e) => CategoryAndItems.fromMapObject(e)).toList();
    }
    return list['data'].map((e) => FoodItem.fromMapObject(e)).toList();
    //.map((food) => FoodItem.fromMapObject(food)).toList();
  }*/

  fetchUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      username = prefs.getString('username');
      if (username != null) {
        await getCatAndItems(context);
        //print(username);
        Get.toNamed("/HomePage");
      } else {
        //print(username);
        Get.toNamed("/SignIn");
      }
    } catch (e) {}
  }

  @override
  void initState() {
    fetchUser();
    /*Timer(const Duration(seconds: 4), () {
      Get.toNamed('/SignIn');
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyBackgroundColor().backgroundColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo().logo(),
          ],
        ),
      ),
    );
  }
}

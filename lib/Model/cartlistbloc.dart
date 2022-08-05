import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/Material.dart';
import 'package:rxdart/rxdart.dart';

import 'cartprovider.dart';
import 'model.dart';

class CartListBloc extends BlocBase {
  CartListBloc();

  var _listController = BehaviorSubject<List<FoodItem>>.seeded([]);

//provider class
  CartProvider provider = CartProvider();

//output
  Stream<List<FoodItem>> get listStream => _listController.stream;

//input
  Sink<List<FoodItem>> get listSink => _listController.sink;

  addToList(FoodItem foodItem) {
    listSink.add(provider.addToList(foodItem));
  }

  countCartItem(FoodItem foodItem) {
    listSink.add(provider.cartCounterReader(foodItem));
  }

  decreaseQuantity(FoodItem foodItem) {
    listSink.add(provider.decreaseQuantityFromList(foodItem));
  }

  removeFromList(FoodItem foodItem) {
    listSink.add(provider.removeFromList(foodItem));
  }

  emptyCart(foodItem, context) {
    //foodItem.clear();
    listSink.add(provider.emptyList(foodItem));
    (context as Element).markNeedsBuild();
  }

//dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }
}

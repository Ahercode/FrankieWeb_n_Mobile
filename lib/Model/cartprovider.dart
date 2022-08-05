import 'package:flutter/cupertino.dart';

import 'model.dart';

class CartProvider {
  //couterProvider only consists of a counter and a method which is responsible for increasing the value of count
  List<FoodItem> foodItems = [];
  List<FoodItem> addToList(FoodItem foodItem) {
    bool isPresent = false;
    if (foodItems.length > 0) {
      for (int i = 0; i < foodItems.length; i++) {
        if (foodItems[i].id == foodItem.id) {
          increaseItemQuantity(foodItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        foodItems.add(foodItem);
      }
    } else {
      foodItems.add(foodItem);
    }

    return foodItems;
  }

  List<FoodItem> removeFromList(FoodItem foodItem) {
    //remove it from the list
    foodItem.quantity = 1;
    foodItems.remove(foodItem);
    return foodItems;
  }

  List<FoodItem> cartCounterReader(FoodItem foodItem) {
    // bool hasBeenCounted = false;

    // if (foodItems.length > 0) {
    //   for (int i = 0; i < foodItems.length; i++) {
    //     if (foodItems[i].id == foodItem.id) {
    //       print("Cart Counter");
    //       cartCounter(foodItem);
    //       // hasBeenCounted = true;

    //       break;
    //     } else {
    //       // hasBeenCounted = false;
    //     }
    //   }

    //   // if (!hasBeenCounted) {
    //   //   foodItems.add(foodItem);
    //   // }
    // } else {
    //   foodItems.add(foodItem);
    // }
    // return foodItems;
    print("Counter clicked!");
    countCartIncrease(foodItem);
    return foodItems;
  }

  List<FoodItem> emptyList(List<FoodItem> foodItem) {
    //remove it from the list
    //foodItems.quantity = 1;
    //clearCart(foodItem)
    print("read");
    //foodItems.length = 0;
    for (var item in foodItem) {
      if (item.quantity! > 1) {
        item.quantity = 1;
      }
    }
    foodItems.clear();
    return foodItems;
  }

  List<FoodItem> decreaseQuantityFromList(FoodItem foodItem) {
    if (foodItem.quantity! > 1) {
      //only decrease the quantity
      decreaseItemQuantity(foodItem);
    } else {
      //remove it from the list
      removeFromList(foodItem);
    }
    return foodItems;
  }

  void increaseItemQuantity(FoodItem foodItem) => foodItem.incrementQuantity();
  void decreaseItemQuantity(FoodItem foodItem) => foodItem.decrementQuantity();
  void countCartIncrease(FoodItem foodItem) => foodItem.countCartIncrease();
  void clearCart(FoodItem foodItem) => foodItem.clearList();
}

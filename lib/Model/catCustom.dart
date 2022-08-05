import 'package:flutter/Material.dart';
import 'package:frankie_s/Model/model.dart';

class ItemCategory {
  int? catId;
  String? catName;
  String? catDescription;
  String? catImg;
  //FooditemList? itemList;

  ItemCategory({
   @required this.catId,
   @required this.catName,
   @required this.catDescription,
   @required this.catImg,
    //this.itemList,
  });

  ItemCategory.fromMapObject(map) {
    this.catId = map['id'];
    this.catName = map['name'].toString().trim();
    this.catDescription = map['description'];
    this.catImg = map['image'];
    //this.itemList = FooditemList(foodItems: map['footItem']);
    //this.quantity = map['quantity'];
  }
}

class CatItemlist {
  List<ItemCategory>? catList;

  CatItemlist({@required this.catList});
}

CatItemlist categoryList = CatItemlist(catList: []);

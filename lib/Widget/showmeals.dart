import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frankie_s/API/apis.dart';
import 'package:frankie_s/ui/splashscreen.dart';
import 'package:provider/provider.dart';

import '../Model/cartlistbloc.dart';
import '../Model/model.dart';

class Meals {
  getLocation(BuildContext context, id) async {
    Map<String, dynamic> list = await DatabaseAPI().getLocation(context, id);
    //print(list);
    List<dynamic> locationData = list["data"];
    //print(data);
    return locationData.map((e) => FoodItem.fromMapObject(e)).toList();
    //.map((food) => FoodItem.fromMapObject(food)).toList();
  }

  meals(BuildContext context, id) {
    Size size = MediaQuery.of(context).size;
    //getFoodElement(context);

    return Container(
      width: size.width * 0.75,
      // height: size.height * 0.81,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border.all()),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 2,
        ),
        children: [
          for (var foodItem in fooditemList.foodItems!.where((element) =>
              element.price! < 35 &&
              element.categoryId == context.watch<Model>().categoryId))
            Builder(
              builder: (context) {
                // print(foodItem);
                return ItemContainer(foodItem: foodItem);
              },
            )
        ],
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  ItemContainer({
    required this.foodItem,
  });

  final FoodItem foodItem;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodItem foodItem) {
    foodItem.timestamp = DateTime.now();
    bloc.countCartItem(foodItem);
    bloc.addToList(foodItem);
  }

  removeFromList(FoodItem foodItem) {
    bloc.removeFromList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);
        /*final snackBar = SnackBar(
          content: Text('${foodItem.name} added to Cart'),
          duration: Duration(milliseconds: 550),
        );*/

        //Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        description: foodItem.description == null ? "" : foodItem.description!,
        itemName: foodItem.name!,
        itemPrice: foodItem.price!,
        imgPath: foodItem.imgPath!,
        leftAligned: (foodItem.id! % 2) == 0 ? true : false,
      ),
    );
  }
}

class Items extends StatelessWidget {
  Items({
    required this.leftAligned,
    required this.imgPath,
    required this.itemName,
    required this.itemPrice,
    required this.description,
  });

  final bool leftAligned;
  final String imgPath;
  final String itemName;
  final double itemPrice;
  final String? description;

  @override
  Widget build(BuildContext context) {
    /*double containerPadding = 45;
    double containerBorderRadius = 10;*/
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 150,
      width: 150.0,
      margin: EdgeInsets.only(right: 4.0, left: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: CachedNetworkImage(
                // width: 60.0,
                // height: 60.0,
                imageUrl: imgPath,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/emptyImage.jpg",
                  // width: 90,
                  // height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              // child: Image.asset(
              //   "assets/food1.jpg",
              //   // width: 90,
              //   // height: 90,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName.toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    (description != "")
                        ? description!
                        : "This product has no description!",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Ghc $itemPrice",
                    style: TextStyle(
                      color: Color(0xff151d2b),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 4.0),
                //   child: Text(
                //     "Ghc $lo",
                //     style: TextStyle(
                //       color: Color(0xff151d2b),
                //       fontSize: 12,
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
    // return Card(
    //   elevation: 5.0,
    //   color: Colors.transparent,
    //   child: Container(
    //     width: size.width * 0.3,
    //     height: size.height * 0.12,
    //     margin: EdgeInsets.all(2),
    //     padding: EdgeInsets.symmetric(horizontal: 10.0),
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(7.0),
    //       //border: Border.all(),
    //       //shape: BoxShape.rectangle
    //     ),
    //     child: Row(
    //       children: [
    //         Container(
    //           width: size.width * 0.15,
    //           alignment: Alignment.topLeft,
    //           padding: EdgeInsets.symmetric(vertical: 5.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Container(
    //                 //width: size.width * 0.2,
    //                 alignment: Alignment.topLeft,
    //                 child: Text(
    //                   itemName,
    //                   style: TextStyle(
    //                       fontSize: 18.0, fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //               Spacer(),
    //               Container(
    //                 alignment: Alignment.topLeft,
    //                 child: Text(
    //                   description,
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: TextStyle(fontSize: 14.0),
    //                 ),
    //               ),
    //               Spacer(),
    //               Container(
    //                 alignment: Alignment.topLeft,
    //                 child: Text("Ghc $itemPrice",
    //                     style: TextStyle(
    //                         color: Colors.green, fontWeight: FontWeight.bold)),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Spacer(),
    //         CachedNetworkImage(
    //           width: 60.0,
    //           height: 60.0,
    //           imageUrl: imgPath,
    //           progressIndicatorBuilder: (context, url, downloadProgress) =>
    //               CircularProgressIndicator(value: downloadProgress.progress),
    //           errorWidget: (context, url, error) => Icon(Icons.error),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

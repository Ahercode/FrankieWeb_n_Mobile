import 'dart:async';
import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frankie_s/API/apis.dart';
import 'package:frankie_s/Model/catCustom.dart';
import 'package:frankie_s/Widget/cartoptions.dart';
import 'package:frankie_s/ui/menuselection.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Model/cartlistbloc.dart';
import '../Model/model.dart';

class MenuOptions {
  final _random = new Random();
  bool catPressed = false;
  List categoryPictures = [
    'african_food.png',
    'chinese.png',
    'continental.png',
    'lebanese.png',
    'salad.png',
    'soup.png'
  ];
  List categoryNames = [
    'African',
    'Chinese',
    'Continental',
    'Lebanese',
    'Salad',
    'Soup'
  ];

  List foodListPicture = [
    'african_food.png',
    'chinese.png',
    'continental.png',
    "Hamburger meal, Zinger Tower.png",
    'lebanese.png',
    'salad.png',
    "Seafood pizza Bacon Ham.png",
    "Shawarma Kebab.png",
    'soup.png',
    "steak.png"
  ];
  List foodListNames = [
    'African',
    'Chinese',
    'Continental',
    "Hamburger meal, Zinger Tower",
    'Lebanese',
    'Salad',
    "Seafood pizza Bacon Ham",
    "Shawarma Kebab",
    'Soup',
    'Steak'
  ];

  List foodDescription = [
    'Dicover the African food.',
    "Let's dicover Chinese dishes together and travel to the promised land of satisfaction.",
    'Some delicious variety of Continental food made just for you.',
    "This Burger is made from the best elements of the region for your pleasure.",
    'Dicover some Lebanese food',
    'Made by the best just for you',
    "For your statisfaction",
    "For your pleasure",
    "Careful, don't drown yourself in this pool of delicious meal",
    'Eat healthy to stay healthy'
  ];
  List foodPrices = [
    '\$25',
    '\$20',
    '\$52',
    "\$14",
    '\$52',
    '\$20',
    "\$10",
    "\$17",
    '\$11',
    '\$60'
  ];

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<FoodItem> foodItems) {
    return GestureDetector(
      onTap: () {
        /*if (length > 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }*/
      },
      child: Container(
        height: 0,
        width: 30,
        margin: EdgeInsets.only(
          right: 30,
          left: 15,
        ),
        child: Center(
          child: Text(length.toString()),
        ),
        // padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.yellow[800], borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  String returnTotalAmount(BuildContext context, List<FoodItem>? foodItems) {
    double totalAmount = 0.0;
    for (int i = 0; i < foodItems!.length; i++) {
      /* print(totalAmount);
      print(foodItems[i].price);
      print(foodItems[i].quantity);
      print(foodItems[i].name);*/
      totalAmount = totalAmount + foodItems[i].price! * foodItems[i].quantity!;
    }
    context.read<Model>().totalAmount(totalAmount.toStringAsFixed(2));
    return totalAmount.toStringAsFixed(2);
  }

  // String returnCartTotal(BuildContext context, List<FoodItem>? foodItems) {
  //   int cartTotal = 0;
  //   for (int i = 0; i < foodItems!.length; i++) {
  //     /* print(totalAmount);
  //     print(foodItems[i].price);
  //     print(foodItems[i].quantity);
  //     print(foodItems[i].name);*/
  //     cartTotal = cartTotal + foodItems.length;
  //   }
  //   context.read<Model>().cartTotal(cartTotal);
  //   return cartTotal.toString();
  // }

  cart(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<FoodItem> foodItems = [];
    // FoodItem foodItem = [];
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return Container(
      width: size.width * 0.21,
      height: size.height * 0.81,
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(width: 5),
              Image.asset(
                'assets/cart.png',
                width: 34.0,
                height: 60.0,
              ),

              StreamBuilder(
                stream: bloc.listStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    foodItems = snapshot.data;
                    int length = foodItems != null ? foodItems.length : 0;
                    //print(length);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // buildGestureDetector(length, context, foodItems),
                        Text(
                          foodItems.length.toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 30),

                        Text(
                          "Total: Ghc ${returnTotalAmount(context, foodItems)}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: Container(
                width: size.width * 0.21,
                // height: size.height * 0.87,
                //color: Colors.white,
                height: 900,
                // color: Colors.red,
                child: StreamBuilder(
                  stream: bloc.listStream,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      foodItems = snapshot.data;
                      foodItems
                          .sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
                      return CartBody(foodItems);
                    } else {
                      return Container(
                        child: Text("Something returned null"),
                      );
                    }
                  },
                )),
          ),
          // Spacer(),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CartOptions().options(context, "Clear", foodItems),
            CartOptions().options(context, "Proceed", foodItems),
          ]),
          // Spacer(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  var currentPage = "African";
  category(BuildContext context) {
    // final Model = Provider.of(context, listen: true);

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      // height: size.height * 0.10,
      height: 100,
      // decoration: BoxDecoration(border: Border.all()),
      child: ListView(
        //var catData = snapshot.data['data'][index];
        scrollDirection: Axis.horizontal,
        children: [
          for (var categories in categoryList.catList!)
            Builder(
              builder: (context) {
                return Card(
                  elevation: 5.0,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("category checked!");

                      (context)
                          .read<Model>()
                          .getFoodCategry(categories.catName);
                      (context).read<Model>().updateCatID(categories.catId);
                      /* if (context.read<Model>().foodCategory == "soups") {
                            context.read<Model>().updateCatID(catData["id"]);
                            //Get.to(() => MenuSelection());
                          } else if (context.read<Model>().foodCategory ==
                              "Salads") {
                            context.read<Model>().updateCatID(catData["id"]);
                          } else if (context.read<Model>().foodCategory ==
                              "Starters") {
                            context.read<Model>().updateCatID(catData["id"]);
                            //Get.to(() => MenuSelection());
                          }*/
                      //Navigator.pop(context);
                      //Navigator.of(context).push(MaterialPageRoute(
                      // builder: (context) => MenuSelection()));
                      //Get.to(() => MenuSelection());
                      //(context as Element).markNeedsBuild();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      // width: size.width * 0.15,
                      // height: size.height * 0.1,
                      //margin: EdgeInsets.all(6.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: context.watch<Model>().foodCategory ==
                                  categories.catName
                              ? Colors.grey.withOpacity(0.7)
                              : Colors.white,
                          //border: Border.all(),
                          borderRadius: BorderRadius.circular(7.0)),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: categories.catImg!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                // Icon(Icons.error),
                                Image.asset(
                              "assets/salad.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                          Text(
                            categories.catName!,
                            //catData["name"],
                            //snapshot.data[index]["id"].toString(),
                            //categoryNames[index],
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          // Spacer(),

                          //Image.network(categories.catImg!)
                          //Image.network(catData["image"])
                          //Image.asset("assets/${categoryPictures[index]}")
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class CartBody extends StatelessWidget {
  final List<FoodItem> foodItems;

  CartBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: Column(
        children: <Widget>[
          Expanded(
            // flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          )
        ],
      ),
    );
  }

  Container noItemContainer() {
    return Container(
      child: Center(
        child: Text(
          "No More Items Left In The Cart",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20),
        ),
      ),
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return DraggableChild(
          foodItem: foodItems[index],
        );
        //CartListItem(foodItem: foodItems[index]);
      },
    );
  }
}

/*class CartListItem extends StatelessWidget {
  final FoodItem? foodItem;

  CartListItem({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      hapticFeedbackOnStart: false,
      maxSimultaneousDrags: 1,
      data: foodItem,
      feedback: Container(),
      //feedback: DraggableChildFeedback(foodItem: foodItem!),
      child: DraggableChild(foodItem: foodItem!),
      childWhenDragging: foodItem!.quantity! > 1
          ? DraggableChild(foodItem: foodItem!)
          : Container(),
    );
  }
}*/

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(
        foodItem: foodItem,
      ),
    );
  }
}

/*class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder(
          stream: null,//colorBloc.colorStream,
          builder: (context,AsyncSnapshot snapshot) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: snapshot.data != null ? snapshot.data : Colors.white,
              ),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.95,
              child: ItemContent(foodItem: foodItem),
            );
          },
        ),
      ),
    );
  }
}
*/
class ItemContent extends StatelessWidget {
  ItemContent({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  removeFromList(FoodItem foodItem) {
    bloc.removeFromList(foodItem);
  }

  idecreaseQuantity(FoodItem foodItem) {
    bloc.decreaseQuantity(foodItem);
  }

  increaseQuantity(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FoodItem currentFoodItem;
    //print(foodItem.timestamp);
    return Container(
      height: 80,
      margin: EdgeInsets.only(
        bottom: 15.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              child: CachedNetworkImage(
                width: 60.0,
                height: 60.0,
                imageUrl: foodItem.imgPath!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/food1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 4, left: 10, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        foodItem.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                      IconButton(
                        onPressed: () {
                          currentFoodItem = foodItem;
                          removeFromList(currentFoodItem);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  Text(
                    "Ghc " + "" + foodItem.price.toString(),
                    style: TextStyle(
                      color: Color(0xff151d2b),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            idecreaseQuantity(foodItem);
                            print("decrease cart item volume");
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 16.0,
                          ),
                          color: Colors.redAccent,
                        ),
                        Text(
                          "${foodItem.quantity}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            increaseQuantity(foodItem);
                            print("increase cart item volume");
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 16.0,
                          ),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    // return Card(
    //   color: Colors.transparent,
    //   elevation: 5.0,
    //   child: Container(
    //     //width: size.width * 0.25,
    //     height: size.height * 0.12,
    //     //margin: EdgeInsets.all(1.0),
    //     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    //     decoration: BoxDecoration(
    //         color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
    //     child: Row(
    //       children: [
    //         CachedNetworkImage(
    //           width: 60.0,
    //           height: 60.0,
    //           imageUrl: foodItem.imgPath!,
    //           progressIndicatorBuilder: (context, url, downloadProgress) =>
    //               CircularProgressIndicator(value: downloadProgress.progress),
    //           errorWidget: (context, url, error) => Icon(Icons.error),
    //         ),
    //         Container(
    //           // alignment: Alignment.topLeft,
    //           width: size.width * 0.16,
    //           //color: Colors.red,
    //           child: Column(
    //             children: [
    //               Container(
    //                 alignment: Alignment.topLeft,
    //                 child: Text(
    //                   foodItem.name!,
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: TextStyle(fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //               Row(
    //                 children: [
    //                   IconButton(
    //                     onPressed: () {
    //                       currentFoodItem = foodItem;
    //                       removeFromList(currentFoodItem);
    //                     },
    //                     icon: Icon(Icons.delete, color: Colors.red),
    //                   ),
    //                   IconButton(
    //                     onPressed: () {
    //                       idecreaseQuantity(foodItem);
    //                     },
    //                     icon: Icon(Icons.remove_circle_outline),
    //                     color: Colors.red,
    //                   ),
    //                   IconButton(
    //                     onPressed: () {
    //                       increaseQuantity(foodItem);
    //                     },
    //                     icon: Icon(Icons.add_circle_outline),
    //                     color: Colors.green,
    //                   ),
    //                   Text("(${foodItem.quantity})",
    //                       style: TextStyle(fontWeight: FontWeight.bold)),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),

    //         /*Image.network(
    //           foodItem.imgPath!,
    //           width: 60.0,
    //           height: 60.0,
    //         ),*/
    //       ],
    //     ),
    //   ),
    // );
  }
}

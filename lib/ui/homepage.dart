import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:frankie_s/ui/menuselection.dart';
import 'package:frankie_s/ui/tables.dart';

import 'package:provider/provider.dart';

import '../API/apis.dart';
import '../Model/catCustom.dart';
import '../Model/model.dart';
import '../Model/paymentMethodModel.dart';
import '../Widget/backgroundColor.dart';
import '../Widget/logo.dart';
import '../Widget/myloadingindicator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

// List categories = [];
// List items = [];

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
      methodList.paymentmethodList!.add(PaymentMethod(
        id: methods['id'],
        name: methods['name'],
        code: methods['code'],
      ));
    }
    //test();
  }

  TabController? _controller;
  //int _selectedIndex = 0;
  List<Widget> _tabs = [
    Tab(
      text: "Restaurant",
      icon: Icon(Icons.restaurant),
    ),
    Tab(
      text: "Take-Away",
      icon: Icon(Icons.takeout_dining),
    ),
    Tab(
      text: "Delivery",
      icon: Icon(Icons.delivery_dining),
    ),
  ];

  getAll() async {
    await getCatAndItems(context);
  }

  @override
  void initState() {
    // Create TabController for getting the index of current tab
    // _controller = TabController(length: _tabs.length, vsync: this);
    getAll();
    // _controller!.addListener(_handleTabSelection);
    // TODO: implement initState
    super.initState();
  }

  // void _handleTabSelection() {
  //   print("read ${_controller!.index}");
  //   print(_controller!.indexIsChanging);
  //   if (_controller!.index == 0) {
  //     context.read<Model>().selectTab("Restaurant");
  //   } else if (_controller!.index == 1) {
  //     context.read<Model>().selectTab("Take-Away");
  //   } else if (_controller!.index == 2) {
  //     context.read<Model>().selectTab("Delivery");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Frankie's",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
        actions: [
          Logo().logo(),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: MenuSelection(),
    );
  }
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: DefaultTabController(
  //       length: 3,
  //       child: Scaffold(
  //         appBar: AppBar(
  //           title: Text(
  //             "Frankie's",
  //             style: TextStyle(
  //                 fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
  //           ),
  //           actions: [
  //             Logo().logo(),
  //           ],
  //         ),
  //         backgroundColor: Colors.grey[200],
  //         // appBar: AppBar(
  //         //   actions: [
  //         //     IconButton(
  //         //       onPressed: () {
  //         //         confirmationDialog(context);
  //         //       },
  //         //       icon: Icon(Icons.logout),
  //         //       iconSize: 30.0,
  //         //       color: Colors.red,
  //         //     )
  //         //   ],
  //         //   // bottom: TabBar(
  //         //   //   // dragStartBehavior: DragStartBehavior.down,
  //         //   //   controller: _controller,
  //         //   //   //physics: NeverScrollableScrollPhysics(),
  //         //   //   isScrollable: false,
  //         //   //   onTap: (index) {
  //         //   //     if (index == 0) {
  //         //   //       context.read<Model>().selectTab("Restaurant");
  //         //   //     } else if (index == 1) {
  //         //   //       context.read<Model>().selectTab("Take-Away");
  //         //   //     } else if (index == 2) {
  //         //   //       context.read<Model>().selectTab("Delivery");
  //         //   //     }
  //         //   //   },
  //         //   //   tabs: _tabs,
  //         //   // ),
  //         //   title: const Text("FRANKIE'S"),
  //         //   leading: Logo().logo(),
  //         //   backgroundColor: MyBackgroundColor().backgroundColor(),
  //         // ),
  //         body: MenuSelection(),
  //         // body: TabBarView(
  //         //   controller: _controller,
  //         //   children: [Tables(), Tables(), Tables()],
  //         // ),
  //       ),
  //     ),
  //   );
  // }
}

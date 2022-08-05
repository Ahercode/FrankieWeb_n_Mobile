import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../Model/foodModel.dart';
import '../../Model/model.dart';
import '../../Widget/backgroundColor.dart';
import '../../Widget/logo.dart';
import '../../Widget/myloadingindicator.dart';
import '../../ui/tables.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    // Create TabController for getting the index of current tab
    _controller = TabController(length: _tabs.length, vsync: this);

    _controller!.addListener(_handleTabSelection);

    // TODO: implement initState
    super.initState();
  }

  void _handleTabSelection() {
    print("read ${_controller!.index}");
    print(_controller!.indexIsChanging);
    if (_controller!.index == 0) {
      context.read<Model>().selectTab("Restaurant");
    } else if (_controller!.index == 1) {
      context.read<Model>().selectTab("Take-Away");
    } else if (_controller!.index == 2) {
      context.read<Model>().selectTab("Delivery");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  confirmationDialog(context);
                },
                icon: Icon(Icons.logout),
                iconSize: 30.0,
                color: Colors.red,
              )
            ],
            bottom: TabBar(
              // dragStartBehavior: DragStartBehavior.down,
              controller: _controller,
              //physics: NeverScrollableScrollPhysics(),
              isScrollable: false,
              onTap: (index) {
                if (index == 0) {
                  context.read<Model>().selectTab("Restaurant");
                } else if (index == 1) {
                  context.read<Model>().selectTab("Take-Away");
                } else if (index == 2) {
                  context.read<Model>().selectTab("Delivery");
                }
              },
              tabs: _tabs,
            ),
            title: const Text("FRANKIE'S"),
            leading: Logo().logo(),
            backgroundColor: MyBackgroundColor().backgroundColor(),
          ),
          // body: TabBarView(
          //   controller: _controller,
          //   // children: [Tables(), Tables(), Tables()],
          // ),
        ),
      ),
    );
  }
}

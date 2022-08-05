import 'package:flutter/material.dart';

class TabAndScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabAndScrollState();
  }
}

/*class PageOne extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Image.asset('asset/family.jpg');
  }
}
class PageTwo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Image.asset('asset/Elcy & Malicka.jpg');
}
}*/
class TabAndScrollState extends State<TabAndScroll>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              //title: Text('Controller example'),
              pinned: true,
              //elevation: 5.0,
              //shadowColor: Colors.red,
              backgroundColor: Colors.blue[900],
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                indicator: BoxDecoration(color: Colors.red),
                tabs: <Widget>[
                  Tab(
                    text: "Home",
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    text: "Example page",
                    icon: Icon(Icons.help),
                  ),
                  Tab(
                    text: "Example page two",
                    icon: Icon(Icons.help),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Container(),
            Container(),
            Container(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }*/
}

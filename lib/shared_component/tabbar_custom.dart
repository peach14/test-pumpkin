import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar(
      {super.key, this.saveProduct, this.checkProduct, this.rePort});
  final Widget? saveProduct;
  final Widget? checkProduct;
  final Widget? rePort;
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorWeight: 3,
            indicatorColor: Colors.blue,
            dividerColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle().copyWith(color: Colors.blue),
            labelColor: Colors.orange,
            unselectedLabelStyle: const TextStyle(color: Colors.pink)
                .copyWith(color: Colors.greenAccent),
            unselectedLabelColor: Colors.black,
            onTap: (value) {},
            tabs: const <Widget>[
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'บันทึกสินค้า',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ตรวจนับสินค้า',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'รายงานสินค้า',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Widgets for Tab 1
                widget.saveProduct ??
                    Container(
                      color: Colors.deepPurple,
                      child: const Text('Tab 1 Content'),
                    ),
                // Widgets for Tab 2
                widget.checkProduct ??
                    Container(
                      color: Colors.green,
                      child: const Text('Tab 2 Content'),
                    ),
                widget.rePort ??
                    Container(
                      color: Colors.pinkAccent,
                      child: const Text('Tab 3 Content'),
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

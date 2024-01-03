import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({Key? key,
    required this.length,
    required this.icons,
    required this.widgets,
  }) : super(key: key);

  final int length;
  final List<Icon> icons;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                ListView.builder(
                  itemCount: icons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Tab(icon: icons[index]);
                  },
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: widgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return widgets[index];
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

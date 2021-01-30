import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetTabs extends StatelessWidget {
  GetTabs({this.totalPage});
  int totalPage;
  @override
  Widget build(BuildContext context) {
    List<Tab> getTabsReturn(totalPage) {
      List<Tab> tab = [];
      for (var i = 0; i < totalPage; i++) {
        tab.add(Tab(text: 'Page ${i + 1}'));
      }
      return tab;
    }

    return TabBar(isScrollable: true, tabs: getTabsReturn(totalPage));
  }
}

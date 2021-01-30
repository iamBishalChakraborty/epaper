import 'package:epaper/screen/desher_katha_new_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../widgets/bottom_navigation.dart';
import '../widgets/downloading_indicator.dart';
import '../widgets/get_tabs.dart';

// ignore: must_be_immutable
class DesherKathaTabController extends StatelessWidget {
  DesherKathaTabController(this.totalPage, this.finalDate, this.displayDate);

  int totalPage;
  String finalDate;
  String displayDate;
  DateTime selectedDate = DateTime.now();

  List<Widget> getTabBarViews(totalPage, date) {
    List<Widget> tab = [];
    for (var i = 0; i < totalPage; i++) {
      tab.add(PDF().cachedFromUrl(
        'http://www.dailydesherkatha.net/epaperimages/$date/$date-MD-HR-${i + 1}.PDF',
        placeholder: (progress) => DownLoadingIndicator(progress: progress),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ));
    }
    return tab;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: GetTabs(totalPage: totalPage),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: getTabBarViews(totalPage, finalDate),
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
            BottomNavigation(
              displayDate: displayDate,
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: selectedDate, // Refer step 1
                  firstDate: DateTime(2019),
                  lastDate: selectedDate,
                )
                    .then((value) => {
                          if (value != null)
                            {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DesherKathaNewDate(date: value)))
                            }
                        })
                    .catchError((error) {
                  print(error);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

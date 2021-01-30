import 'package:connectivity/connectivity.dart';
import 'package:epaper/screen/dainik/dainik_tab_controller.dart';
import 'package:epaper/widgets/loading.dart';
import 'package:epaper/widgets/no_internet.dart';
import 'package:epaper/widgets/no_newspaper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:web_scraper/web_scraper.dart';

import 'dainik_tab_controller.dart';

// ignore: must_be_immutable
class DainikSambadNewDate extends StatefulWidget {
  DateTime date;
  DainikSambadNewDate({Key key, @required this.date}) : super(key: key);
  @override
  _DainikSambadNewDateState createState() => _DainikSambadNewDateState(date);
}

class _DainikSambadNewDateState extends State<DainikSambadNewDate> {
  DateTime date;
  _DainikSambadNewDateState(this.date);

  String newDate;
  String newPage;
  String selectedDate;
  List<Map<String, dynamic>> webNewsDate;
  List<Map<String, dynamic>> webNewsPage;
  bool isLoading = true;
  bool isNewsPaperOut = false;
  var connectivityResult;
  String displayDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
    var formatter = DateFormat('ddMMyyyy');
    var displayFormatter = DateFormat('dd-MM-yyyy');
    selectedDate = formatter.format(date);
    displayDate = displayFormatter.format(date);
    checkNewsPaper(selectedDate);
  }

  getConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  getDataFromNewsWebsite() async {
    final webScraper = WebScraper('https://www.dainiksambad.net');
    if (await webScraper.loadWebPage(
        '/index.php?pagedate=${DateFormat('yyyy-MM-dd').format(date)}&edcode=20&subcode=20&mod=1&pgnum=1&type=a')) {
      setState(() {
        webNewsPage = webScraper.getElement('input#totalpages', ['value']);
        var page = webNewsPage[0]['attributes']['value'];
        newPage = page;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  checkNewsPaper(date) async {
    String dainik =
        'https://www.dainiksambad.net/epaperimages//$date//page-1.jpg';
    var response = await head(dainik);
    print(dainik);
    if (response.statusCode == 200) {
      getDataFromNewsWebsite();
      setState(() {
        isNewsPaperOut = true;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return connectivityResult == ConnectivityResult.none
        ? Scaffold(
            body: NoInternet(),
          )
        : isLoading
            ? LoadingScreen()
            : isNewsPaperOut
                ? DainikTabController(
                    int.parse(newPage), selectedDate, displayDate)
                : NoNewsPaper();
  }
}

import 'package:epaper/const.dart';
import 'package:epaper/model/newspaper_model.dart';
import 'package:epaper/screen/dainik/dainik_tab_controller.dart';
import 'package:epaper/widgets/loading.dart';
import 'package:epaper/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:web_scraper/web_scraper.dart';

import '../../functions.dart';
import 'dainik_tab_controller.dart';

class DainikSambad extends StatefulWidget {
  @override
  _DainikSambadState createState() => _DainikSambadState();
}

class _DainikSambadState extends State<DainikSambad> {
  DateTime now = DateTime.now();
  Box<NewspaperModel> newspaperBox;
  bool isDataInBox;
  bool connectivityResult = true;
  String todayDate;
  bool dateMatchWithHive;
  String newDate;
  String newPage;

  List<Map<String, dynamic>> webNewsDate;
  List<Map<String, dynamic>> webNewsPage;
  bool isLoading = true;
  String displayDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnection();
    todayDate = DateFormat('ddMMyyyy').format(now);
    print(todayDate);
    newspaperBox = Hive.box<NewspaperModel>(newspaperBoxName);
    checkBox();
  }

  getConnection() async {
    connectivityResult = await getConnectivity();
    setState(() {
      connectivityResult = connectivityResult;
    });
  }

  checkBox() async {
    var check = newspaperBox.get(kDainikSambad);
    print(1);
    if (check != null) {
      print(2);
      isDataInBox = true;
      if (todayDate == check.dateTime) {
        print(3);
        loadDataFromHive();
        dateMatchWithHive = true;
      } else {
        print(4);
        dateMatchWithHive = false;
        checkWebStatus();
      }
    } else {
      print(5);
      isDataInBox = false;
      getDataFromNewsWebsite();
    }
  }

  loadDataFromHive() {
    print(9);
    var data = newspaperBox.get(kDainikSambad);
    displayDate = data.displayDate;
    newDate = data.dateTime;
    newPage = '${data.page}';
    setState(() {
      isLoading = false;
    });
  }

  checkWebStatus() async {
    print(6);
    String desherKatha =
        'https://www.dainiksambad.net/epaperimages//$todayDate//page-1.jpg';
    var response = await head(desherKatha);
    if (response.statusCode == 200) {
      await getDataFromNewsWebsite();
    } else {
      print(8);
      loadDataFromHive();
    }
  }

  getDataFromNewsWebsite() async {
    final webScraper = WebScraper('https://www.dainiksambad.net');
    if (await webScraper.loadWebPage('')) {
      setState(() {
        webNewsDate = webScraper.getElement('input#mydate', ['value']);
        webNewsPage = webScraper.getElement('input#totalpages', ['value']);

        displayDate = DateFormat('dd-MM-yyyy').format(DateFormat("yyyy-MM-dd")
            .parse(webNewsDate[0]['attributes']['value']));
        newDate = DateFormat('ddMMyyyy').format(DateFormat("yyyy-MM-dd")
            .parse(webNewsDate[0]['attributes']['value']));
        newPage = webNewsPage[0]['attributes']['value'];
      });
    }
    setState(() {
      isLoading = false;
    });
    newspaperBox.put(kDainikSambad,
        NewspaperModel(int.parse(newPage), newDate, displayDate));
  }

  @override
  Widget build(BuildContext context) {
    return isDataInBox
        ? dateMatchWithHive
            ? DainikTabController(int.parse(newPage), newDate, displayDate)
            : connectivityResult
                ? isLoading
                    ? LoadingScreen()
                    : DainikTabController(
                        int.parse(newPage), newDate, displayDate)
                : DainikTabController(int.parse(newPage), newDate, displayDate)
        : connectivityResult
            ? isLoading
                ? LoadingScreen()
                : DainikTabController(int.parse(newPage), newDate, displayDate)
            : Scaffold(
                body: NoInternet(),
              );
  }
}

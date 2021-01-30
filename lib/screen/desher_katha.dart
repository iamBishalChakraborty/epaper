import 'package:epaper/model/newspaper_model.dart';
import 'package:epaper/screen/desher_katha_tab_controller.dart';
import 'package:epaper/widgets/loading.dart';
import 'package:epaper/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:web_scraper/web_scraper.dart';

import '../const.dart';
import '../functions.dart';

class DesherKatha extends StatefulWidget {
  @override
  _DesherKathaState createState() => _DesherKathaState();
}

class _DesherKathaState extends State<DesherKatha> {
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
    var check = newspaperBox.get(kDesherKatha);
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
    var data = newspaperBox.get(kDesherKatha);
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
        'http://www.dailydesherkatha.net/epaperimages/$todayDate/$todayDate-MD-HR-1.jpg';
    var response = await head(desherKatha);
    if (response.statusCode == 200) {
      // await getDataFromNewsWebsite();
      setState(() {
        isLoading = false;
      });
      displayDate = DateFormat('dd-MM-yyyy').format(now);
      newspaperBox.put(kDesherKatha, NewspaperModel(8, todayDate, displayDate));
    } else {
      print(8);
      loadDataFromHive();
    }
  }

  getDataFromNewsWebsite() async {
    final webScraper = WebScraper('https://www.dailydesherkatha.net/');
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
    newspaperBox.put(
        kDesherKatha, NewspaperModel(int.parse(newPage), newDate, displayDate));
  }

  @override
  Widget build(BuildContext context) {
    return isDataInBox
        ? dateMatchWithHive
            ? DesherKathaTabController(int.parse(newPage), newDate, displayDate)
            : connectivityResult
                ? isLoading
                    ? LoadingScreen()
                    : DesherKathaTabController(
                        int.parse(newPage), newDate, displayDate)
                : DesherKathaTabController(
                    int.parse(newPage), newDate, displayDate)
        : connectivityResult
            ? isLoading
                ? LoadingScreen()
                : DesherKathaTabController(
                    int.parse(newPage), newDate, displayDate)
            : Scaffold(
                body: NoInternet(),
              );
  }
}

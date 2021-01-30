import 'package:connectivity/connectivity.dart';
import 'package:epaper/screen/desher_katha_tab_controller.dart';
import 'package:epaper/widgets/loading.dart';
import 'package:epaper/widgets/no_internet.dart';
import 'package:epaper/widgets/no_newspaper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class DesherKathaNewDate extends StatefulWidget {
  DateTime date;
  DesherKathaNewDate({Key key, @required this.date}) : super(key: key);
  @override
  _DesherKathaNewDateState createState() => _DesherKathaNewDateState(date);
}

class _DesherKathaNewDateState extends State<DesherKathaNewDate> {
  DateTime date;
  _DesherKathaNewDateState(this.date);
  String selectedDate;
  bool isLoading = true;
  bool isNewsPaperOut = false;
  var connectivityResult;
  String displayDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
    selectedDate = DateFormat('ddMMyyyy').format(date);
    displayDate = DateFormat('dd-MM-yyyy').format(date);
    checkNewsPaper(selectedDate);
  }

  checkNewsPaper(date) async {
    String desherKatha =
        'http://www.dailydesherkatha.net/epaperimages/$date/$date-MD-HR-1.jpg';
    var response = await head(desherKatha);
    if (response.statusCode == 200) {
      setState(() {
        isNewsPaperOut = true;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  getConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
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
                ? DesherKathaTabController(8, selectedDate, displayDate)
                : NoNewsPaper();
  }
}

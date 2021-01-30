import 'package:epaper/model/newspaper_model.dart';
import 'package:epaper/widgets/bottom_navigation.dart';
import 'package:epaper/widgets/downloading_indicator.dart';
import 'package:epaper/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../const.dart';
import '../functions.dart';
import 'jagaran_new_date.dart';

class Jagaran extends StatefulWidget {
  @override
  _JagaranState createState() => _JagaranState();
}

class _JagaranState extends State<Jagaran> {
  // For Jagaran Hive
  // 1. Page = Jagaran Year
  // 2. DateTime = Month
  // 3. Display Date = DisplayDate/MainDate

  DateTime now = DateTime.now();
  Box<NewspaperModel> newspaperBox;
  bool isDataInBox;
  bool connectivityResult = true;
  bool dateMatchWithHive;
  String jagaranMonth;
  String jagaranYear;
  bool isLoading = true;
  String displayDate;
  int previous = 0;
  DateTime selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
    newspaperBox = Hive.box<NewspaperModel>(newspaperBoxName);
    displayDate = DateFormat('dd-MM-yyyy').format(now);
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
      if (displayDate == check.displayDate) {
        print(3);
        loadDataFromHive();
        dateMatchWithHive = true;
      } else {
        print(4);
        dateMatchWithHive = false;
        checkWebStatus(now);
      }
    } else {
      print(5);
      isDataInBox = false;
      checkNewsPaper(now);
    }
  }

  checkNewsPaper(DateTime date) async {
    String jagaran =
        'http://www.jagarandaily.com/wp-content/uploads/${date.year}/${date.month.toString().padLeft(2, '0')}/${DateFormat('dd-MM-yyyy').format(date)}.pdf';
    print(jagaran);
    var response = await head(jagaran);
    if (response.statusCode == 200) {
      displayDate = DateFormat('dd-MM-yyyy').format(date);
      jagaranMonth = date.month.toString().padLeft(2, '0');
      jagaranYear = date.year.toString();
      setState(() {
        isLoading = false;
      });
      print('${date.year}' +
          '${date.month.toString().padLeft(2, '0')}' +
          '${DateFormat('dd-MM-yyyy').format(date)}');
      newspaperBox.put(
          kJagaran,
          NewspaperModel(date.year, date.month.toString().padLeft(2, '0'),
              DateFormat('dd-MM-yyyy').format(date)));
    } else {
      ++previous;
      selectedDate = DateTime(now.year, now.month, now.day - previous);
      displayDate = DateFormat('dd-MM-yyyy').format(selectedDate);
      checkNewsPaper(selectedDate);
    }
  }

  checkWebStatus(DateTime date) async {
    String jagaran =
        'http://www.jagarandaily.com/wp-content/uploads/${date.year}/${date.month.toString().padLeft(2, '0')}/${DateFormat('dd-MM-yyyy').format(date)}.pdf';
    print(jagaran);
    var response = await head(jagaran);
    if (response.statusCode == 200) {
      displayDate = DateFormat('dd-MM-yyyy').format(date);
      jagaranMonth = date.month.toString().padLeft(2, '0');
      jagaranYear = date.year.toString();
      setState(() {
        isLoading = false;
      });
      print('${date.year}' +
          '${date.month.toString().padLeft(2, '0')}' +
          '${DateFormat('dd-MM-yyyy').format(date)}');
      newspaperBox.put(
          kJagaran,
          NewspaperModel(date.year, date.month.toString().padLeft(2, '0'),
              DateFormat('dd-MM-yyyy').format(date)));
    } else {
      loadDataFromHive();
    }
  }

  loadDataFromHive() {
    var data = newspaperBox.get(kJagaran);
    print('${data.displayDate} ' + ' ${data.dateTime} ' + ' ${data.page}');
    displayDate = data.displayDate;
    jagaranMonth = data.dateTime;
    jagaranYear = '${data.page}';
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text('Jagaran'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: PDF().cachedFromUrl(
                    'http://www.jagarandaily.com/wp-content/uploads/$jagaranYear/$jagaranMonth/$displayDate.pdf',
                    placeholder: (progress) =>
                        DownLoadingIndicator(progress: progress),
                    errorWidget: (error) =>
                        Center(child: Text(error.toString())),
                  ),
                ),
                BottomNavigation(
                  displayDate: displayDate,
                  onPressed: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: now, // Refer step 1
                      firstDate: DateTime(2019),
                      lastDate: now,
                    )
                        .then((value) => {
                              if (value != null)
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          JagaranNewDate(date: value)))
                                }
                            })
                        .catchError((error) {
                      print(error);
                    });
                  },
                )
              ],
            ),
          );
  }
}

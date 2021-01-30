import 'package:connectivity/connectivity.dart';
import 'package:epaper/model/newspaper_model.dart';
import 'package:epaper/widgets/bottom_navigation.dart';
import 'package:epaper/widgets/downloading_indicator.dart';
import 'package:epaper/widgets/loading.dart';
import 'package:epaper/widgets/no_newspaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class JagaranNewDate extends StatefulWidget {
  DateTime date;
  JagaranNewDate({Key key, @required this.date}) : super(key: key);
  @override
  _JagaranNewDateState createState() => _JagaranNewDateState(date);
}

class _JagaranNewDateState extends State<JagaranNewDate> {
  DateTime date;
  _JagaranNewDateState(this.date);
  String displayDate;
  DateTime now;
  bool isLoading = true;
  bool isNewsPaperOut = false;
  DateTime finalDate;
  var connectivityResult;
  Box<NewspaperModel> newspaperBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
    displayDate = DateFormat('dd-MM-yyyy').format(date);
    checkNewsPaper(date);
  }

  getConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  checkNewsPaper(DateTime date) async {
    String jagaran =
        'http://www.jagarandaily.com/wp-content/uploads/${date.year}/${date.month.toString().padLeft(2, '0')}/${DateFormat('dd-MM-yyyy').format(date)}.pdf';
    var response = await head(jagaran);
    if (response.statusCode == 200) {
      finalDate = date;
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : isNewsPaperOut
            ? Scaffold(
                appBar: AppBar(
                  title: Text('Jagaran'),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: PDF().cachedFromUrl(
                        'http://www.jagarandaily.com/wp-content/uploads/${finalDate.year}/${finalDate.month.toString().padLeft(2, '0')}/${DateFormat('dd-MM-yyyy').format(finalDate)}.pdf',
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
                          initialDate: DateTime.now(), // Refer step 1
                          firstDate: DateTime(2019),
                          lastDate: DateTime.now(),
                        )
                            .then((value) => {
                                  if (value != null)
                                    {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
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
              )
            : NoNewsPaper();
  }
}

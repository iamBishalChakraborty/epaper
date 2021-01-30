import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class Paper extends StatefulWidget {
  static final id = 'paper';
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  String src =
      'https://www.dainiksambad.net/epaperimages//20122020//page-1.pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Container(
        child: PDF(
          enableSwipe: true,
          swipeHorizontal: true,
        ).cachedFromUrl(
          'https://www.careerpower.in/2020/The_Hindu_Review_Novembers_2020.pdf',
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}

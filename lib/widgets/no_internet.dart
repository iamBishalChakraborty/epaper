import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Ooops!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Center(
          child: Text('No Internet Connection Found'),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text('Check Your Internet Connection'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.displayDate, this.onPressed});
  String displayDate;
  Function onPressed;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FlatButton(
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('View By Date'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                displayDate,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

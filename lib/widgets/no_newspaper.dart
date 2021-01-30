import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoNewsPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 80.0),
              child: Image(
                image: AssetImage('assets/images/newspaper.png'),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              "Missing Newspaper",
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text("The Newspaper you are looking for",
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w500)),
            Text(
              "is not available",
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back',
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

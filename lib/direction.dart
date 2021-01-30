import 'package:epaper/screen/dainik/dainik_sambad.dart';
import 'package:epaper/screen/desher_katha.dart';
import 'package:epaper/screen/jagaran.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Direction extends StatefulWidget {
  @override
  _DirectionState createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              'Tripura selected epaper',
              style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
            )),
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Daily",
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Weekly",
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
            ]),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 165,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                image: AssetImage('assets/images/page-1.jpg'),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "Dainik Sambad",
                                    style: GoogleFonts.poppins(
                                        letterSpacing: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DainikSambad()));
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DainikSambad()));
                      },
                      child: Text('Dainik Sambad')),
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DesherKatha()));
                      },
                      child: Text('Desher Katha')),
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Jagaran()));
                      },
                      child: Text('Jagaran')),
                ],
              ),
            ),
            Column(
              children: [
                Icon(Icons.movie),
              ],
            ),
          ]),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueAccent, spreadRadius: 0, blurRadius: 2),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  height: 50.0,
                  color: Colors.grey[800],
                  child: Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 20,
                          color: Colors.redAccent,
                        ),
                        Text(
                          '  AD free',
                          style: GoogleFonts.poppins(),
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              )),
        ));
  }
}

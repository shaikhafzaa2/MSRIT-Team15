import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

bool isSearchingInChat = false;
var stocks;
List companies = [];
List companiesn = [];
Map mapcompany = new Map();

class _DashboardState extends State<Dashboard> {
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/Stock List.json');
    final data = await json.decode(response);

    setState(() {
      stocks = data;

      print(stocks.length);
    });
  }

  getcompanies() {
    for (var i = 0; i < 16000; i++) {
      if (stocks[i]['symbol'] != stocks[i + 1]['symbol']) {
        companies.add(stocks[i]['symbol']);
      }
    }
    // setState(() {
    //   companiesn = companies;
    //   //print(companies);
    //   print(companiesn);
    // });
  }

  @override
  void initState() {
    super.initState();
    readJson();
    //getcompanies();

    //getcompanies();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff212121),
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.085,
          //primary: false,
          backgroundColor: Color(0xff1B1B1B),
          title: ((!isSearchingInChat)
              ? Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                )
              : AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: screenWidth * 0.6,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'Search',
                        fillColor: Color.fromRGBO(43, 43, 43, 1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                )),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextButton(
                    child: Text(
                      'Get Companies',
                      style: TextStyle(fontSize: 14),
                    ),

                    onPressed: () {
                      setState(() {
                        getcompanies();
                      });
                    },
                    //child: Icon(Icons.sort)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ))),
                      onPressed: () {
                        setState(() {
                          isSearchingInChat = !isSearchingInChat;
                        });
                      },
                      child: Icon(Icons.search)),
                ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        body: stocks == null
            ? Container()
            : Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ListView.builder(
                    itemCount: companies.length,
                    itemBuilder: (context, int) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.all(10),
                          color: Colors.grey.shade800,
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.10,
                          child: Center(
                            child: Text(
                              // stocks[int]['symbol'] == stocks[int + 1]['symbol']
                              //     ? {}
                              //stocks[int]['symbol'],
                              companies[int],

                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}

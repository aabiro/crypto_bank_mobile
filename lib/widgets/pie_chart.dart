import 'package:flutter/material.dart';

class StandardCard extends StatelessWidget {
  String text;
  var goTo;
  StandardCard(this.text, [this.goTo]);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Completed", () => 5);
    dataMap.putIfAbsent("In Progress", () => 3);
    
    return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10),

                // child: Hero(
                //   tag: "bike",
                child: Card(
                  child: InkWell(
                    onTap: () => 
                    
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => goTo,
                            maintainState: false)),
                    child: Container(
                      padding: EdgeInsets.all(20),

                      // height: 85,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    text,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ),
              ),
            );
  }
}
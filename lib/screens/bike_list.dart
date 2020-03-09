import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bike_list_item.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/empty_list.dart';
import 'qr_scan.dart';
import '../providers/bikes.dart';
import 'package:provider/provider.dart';

class BikeList extends StatefulWidget {
  static final routeName = '/bike_list';

  @override
  _BikeListState createState() => _BikeListState();
}

class _BikeListState extends State<BikeList> {
  var _init = true;
  var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_init) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Bikes>(context).getUserBikes();
  //     Provider.of<Bikes>(context).getUserBikes(allBikes: true).then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _init = false;
  // }

  BoxDecoration myDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bikesData = Provider.of<Bikes>(context);
    final bikes = bikesData.userBikes;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: new Text(
          'My Bikes',
          style: TextStyle(),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.popAndPushNamed(context, '/home'),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: mediaQuery.size.height * 0.77,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView(
                      children: bikes != null && bikes.length > 0
                          ? bikes?.map<Widget>(
                              (bike) {
                                return ChangeNotifierProvider.value(
                                  value: bike,
                                  child: BikeListItem(bike),
                                );
                              },
                            )?.toList()
                          : [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[EmptyListItem("bikes")],
                                ),
                              ),
                            ].toList()),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.1,
                    child: RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      onPressed: () {
                        _showDialog();
                      },
                      textColor: Colors.white,
                      color: Constants.accentColor,
                      child: Container(
                        padding: EdgeInsets.all(9),
                        decoration: myDecoration(),
                        child: Text('Activate Bike',
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ),
                      // icon: Icon(
                      //   Icons.center_focus_strong,
                      //   size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Have a GivnGo lock?",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlineButton(
                  padding: EdgeInsets.all(20),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, QrScan.routeName,
                        arguments: QrScan());
                  },
                  child: Text(
                    "Yes, activate bike",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
                // SizedBox(height: 10,),
                OutlineButton(
                  padding: EdgeInsets.all(20),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

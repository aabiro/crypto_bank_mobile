import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/screens/bike_list_item.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:http/src/response.dart';
import '../helpers/bike_helper.dart';
import 'bike_detail_view.dart';
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
   var _isLoading = false; //for a loader later see transform fetched data
  //get bikes from the db from the user id

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      // var accessToken = Provider.of<Authentication>(context).accessToken;
      Provider.of<Bikes>(context).getUserBikes().then((_){
        setState((){
          _isLoading = false;
        });
      });
    }
    _init = false;
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
            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed:() => Navigator.popAndPushNamed(context, '/home'),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _showDialog();
                  }),
            ]),
        body: SizedBox(
          height: mediaQuery.size.height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //make this a list view builder!!
            child: ListView(
              children: 
                bikes?.map(
                (bike) {
                  //use .value because items are lost
                  return ChangeNotifierProvider.value(  //notify of changes for each individual bike item
                    value: bike,
                    child: BikeListItem(bike
                      // bike.id, bike.name, bike.isActive, bike.imageUrl
                      ),
                  );                     
                },
              )?.toList() ?? [],
            ),
          ),
        ));
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
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlineButton(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, QrScan.routeName, arguments: QrScan(true));
                  },
                  child: Text(
                    "Yes, activate ride",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
                OutlineButton(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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

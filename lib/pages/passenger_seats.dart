import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:i_Delivery/widgets/appBars.dart';
import 'package:i_Delivery/util.dart';
import 'map.dart';

class passenger_seats extends StatefulWidget {

  final bool canback;
  final FABMode mode;
  final String BusID;
  var booked_numbers = [1, 3, 2, 5, 4,19,25,35,12,32];
  passenger_seats({Key key, @required this.canback,this.mode,this.BusID }) : super(key: key);

  _passenger_seatsState createState() => _passenger_seatsState();
}

class _passenger_seatsState extends State<passenger_seats> {
  final ItemScrollController itemScrollController = ItemScrollController();



  @override
  void initState() {
    super.initState();
  }


  bool initStated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullAppbar(context, false),
      body: new GridView.count(
        crossAxisCount: 4,
        children: new List<Widget>.generate(40, (index) {
          return new GridTile(
            child: GestureDetector(
              onTap: () {
                if (widget.booked_numbers.contains(index)) {
                  Fluttertoast.showToast(msg: "Seat Already Booked");
                } else {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      pageBuilder: (_, __, ___) =>
                          map(
                              canback: false,
                              mode: FABMode.Passenger,
                              BusID: widget.BusID,
                              seateid: index),
                    ),
                  );
                }
              },
              child: new Card(
                  color: Colors.blue.shade200,
                  child: new Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MaterialCommunityIcons.seat_recline_extra, size: 40,
                          color: (widget.booked_numbers.contains(index))
                              ? Colors.grey
                              : Colors.black,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Seat No $index',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color:
                                (widget.booked_numbers.contains(index)) ? Colors
                                    .grey : Colors.black),),
                        ),
                      ],
                    ),
                  )
              ),
            ),
          );
        }),
      ),
    );

    //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //floatingActionButton: customFab(context, FABMode.Search,_add_request ),
    /*  bottomNavigationBar: BottomNavigationBarApp(
          context, bottomNavigationBarIndex),*/

  }

}

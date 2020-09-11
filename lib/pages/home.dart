import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_Delivery/pages/passenger_seats.dart';
import 'package:intl/intl.dart';
import 'package:i_Delivery/widgets/appBars.dart';
import 'package:i_Delivery/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'map.dart';
import 'onboarding.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ItemScrollController itemScrollController = ItemScrollController();

  bool initStated = false;


  @override
  void initState() {
    super.initState();
  }

  Future LogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', "");
    await prefs.setString('email', "");
    await prefs.setString('nickname', "");
    await prefs.setString('photoUrl', "");
    await prefs.setString('mobile', "");
    await prefs.setString('address', "");
    await prefs.setString('is_driver', "");

    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignInAccount googleUser = await _googleSignIn.signOut();

    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (_, __, ___) => Onboarding(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppbar(context),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child:
        StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('bus')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: new CircularProgressIndicator());
              default:
                return new ListView(
                  children: snapshot.data.documents.map((
                      DocumentSnapshot document) {
                    return GestureDetector(
                      onTap: () {
                     /*   Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) => map(canback: false,mode: FABMode.Passenger,BusID:document.documentID ,),
                          ),
                        );
*/
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) => passenger_seats(canback: false,mode: FABMode.Passenger,BusID:document.documentID ,),
                          ),
                        );


                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                MaterialCommunityIcons.bus_clock,
                                color: CustomColors.TextHeader,size: 50,),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Container(
                                    // width: 180,

                                    child: Text(
                                      document['busname'],
                                      style: TextStyle(
                                          color: CustomColors.TextHeader,
                                          fontWeight: FontWeight.w600),
                                    ),

                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.60,
                                    child: Text(document['days'] ==null ? 'N/A' : document['days'].join(', '),
                                      style: TextStyle(
                                          color: CustomColors.BlueLight),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                MaterialCommunityIcons.map_marker_path,
                                color: CustomColors.TextHeader,size: 40,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Ionicons.ios_arrow_forward,
                                color: CustomColors.TextHeader,size: 50,),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            stops: [0.015, 0.015],
                            colors: [CustomColors.GreenIcon, Colors.lightBlue.shade50],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.GreyBorder,
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },


        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   //   floatingActionButton: customFab(context, FABMode.Class),
      // bottomNavigationBar:  BottomNavigationBarApp(context, bottomNavigationBarIndex),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: CustomColors.PurpleLight,
        onPressed: ()   {
          LogOut();
        },
        icon: Icon(AntDesign.logout),
        label: Text("Sign Out"),
      ),
    );
  }

}

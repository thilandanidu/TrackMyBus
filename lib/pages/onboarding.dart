import 'dart:io';
import 'package:i_Delivery/pages/home.dart';
import 'package:i_Delivery/pages/passenger_seats.dart';
import 'package:i_Delivery/pages/user.dart';
import 'package:i_Delivery/widgets/bottomSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key);

  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {


  //Passenger


  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloding = false;
  bool isexpierid = false;
  bool isFristRegister = false;

  @override

  void initState() {
    super.initState();
    _version();
  }

  @override
  void dispose() {
    super.dispose();
  }


    @override
    Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
    child: Column(
    children: <Widget>[


    Expanded(
    flex: 8,
    child: Hero(
    tag: 'Clipboard',
    child: Padding(
    padding: const EdgeInsets.all(50.0),
    child: Image.asset('assets/images/Clipboard.png'),
    ),
    ),
    ),
    //,
    Expanded(
    flex: 1,
    child: RaisedButton(
    onPressed: () {
    setState(() {
    isloding = true;
    });

    _handleSignIn_google(true)
        .then((bool success) {
    if (success) {
    Navigator.of(context).pushReplacement(
    PageRouteBuilder(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (_, __, ___) => (user()),
    ),
    );
    }
    else {
    // Fluttertoast.showToast(msg: "Sign in Fail");
    setState(() {
    isloding = false;
    });
    }
    })
        .catchError((e) {
    print(e);
    Fluttertoast.showToast(msg: "Sign in Fail");
    setState(() {
    isloding = false;
    });
    print(e);
    });
    },
    textColor: Colors.white,
    padding: const EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
    ),
    child: Container(
    width: MediaQuery
        .of(context)
        .size
        .width / 1.2,
    height: 60,
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    colors: <Color>[
    CustomColors.PurpleDark,
    CustomColors.PurpleDark,
    ],
    ),
    borderRadius: BorderRadius.all(
    Radius.circular(8.0),
    ),
    boxShadow: [
    BoxShadow(
    color: CustomColors.PurpleDark,
    blurRadius: 15.0,
    spreadRadius: 1.0,
    offset: Offset(0.0, 0.0),
    ),
    ],
    ),
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        '"DRIVER" Login    ',                                                                     //Driver Login
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500 ),
                      ),
                      Icon(Ionicons.logo_googleplus, size: 35,)
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 40, color: Colors.grey,),
            Expanded(
              flex: 1,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    isloding = true;
                  });

                  _handleSignIn_google(false)
                      .then((bool success) {
                    if (success) {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder: (_, __, ___) => (Home()),
                        ),
                      );
                    }
                    else {
                     // Fluttertoast.showToast(msg: "Sign in Fail");
                      setState(() {
                        isloding = false;
                      });
                    }
                  })
                      .catchError((e) {
                    print(e);
                    Fluttertoast.showToast(msg: "Sign in Fail");
                    setState(() {
                      isloding = false;
                    });
                    print(e);
                  });
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.2,
                  height: 60,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        CustomColors.BlueDark,
                        CustomColors.BlueDark,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.BlueDark,
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        '"PASSENGER" Login       ',                                                                     //Passenger Login
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Icon(Ionicons.logo_googleplus, size: 35,)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Powered By Group No 116',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  //Image.asset('assets/images/logo.png', scale: 4,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _CheckLic() async {
    final DocumentSnapshot documents =
    await Firestore.instance.collection('users').document(User.email).get();

    if (documents != null) {
      DateTime current_time = new DateTime(
          DateTime
              .now()
              .year, DateTime
          .now()
          .month, DateTime
          .now()
          .day);

      DateTime lic_renew_date = documents['lic_renew_date'].toDate() ??
          DateTime.now().add(new Duration(days: -3));

      Duration lap = lic_renew_date.difference(current_time);

      if (lap.inDays > 0) {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  String Version = "";

  Future<void> _version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      Version = packageInfo.version;
    });
  }

  Future<bool> _handleSignIn_google(bool is_driver) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();




//Driver




    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential))
        .user;
    print("signed in " + user.displayName);

    if (user != null) {
      // Check is already sign up
      final DocumentSnapshot documents =
      await Firestore.instance.collection('bus_users').document(user.email).get();
      int trail_days = 60;
      print(documents.exists);
      if (documents.exists == false) {
        isFristRegister=true;
        // Fluttertoast.showToast(msg: "Sign in success. Please Wait");
        // Update data to server if new user
        Firestore.instance.collection('bus_users').document(user.email).setData({
          'nickname': user.displayName,
          'photoUrl': user.photoUrl,
          'mobile': "",
          'address': "",
          'id': user.uid,
          'createdAt': DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          'is_driver': is_driver,
          'is_active': true,
          'lic_renew_date': DateTime.now().add(Duration(days: trail_days)),
        });

        // Write data to local
        // currentUser = firebaseUser;
        await prefs.setString('id', user.uid);
        await prefs.setString('email', user.email);
        await prefs.setString('nickname', user.displayName);
        await prefs.setString('photoUrl', user.photoUrl);
        await prefs.setBool('is_driver', is_driver);
        await prefs.setString('mobile', "");
        await prefs.setString('address', "");


        User.email = user.email;
        User.nickname = user.displayName;
        User.photoUrl = user.photoUrl;
        User.mobile =  "";
        User.address = "";
        User.is_driver = is_driver;

      } else {

        print("123");
         User.is_driver = await documents['is_driver'] ?? false;
        if(User.is_driver != is_driver){
          if(User.is_driver)
            await Fluttertoast.showToast(msg: "Register as Driver");
          else
            await Fluttertoast.showToast(msg: "Register as Pessenger");
          return false;
        }
        // Write data to local
        await prefs.setString('email', documents.documentID);
        await prefs.setString('id', documents['id']);
        await prefs.setString('nickname', documents['nickname']);
        await prefs.setString('photoUrl', documents['photoUrl']);
        await prefs.setBool('is_driver', documents['is_driver']);
        await prefs.setString('mobile', documents['mobile']);
        await prefs.setString('address', documents['address']);

        User.email = documents.documentID;
        User.nickname = documents['nickname'];
        User.photoUrl = documents['photoUrl'];

        User.mobile =  documents['mobile'];
        User.address = documents['address'];
      }
      return true;
    }
    else {
      Fluttertoast.showToast(msg: "Sign in Fail");
      return false;
    }
  }


}

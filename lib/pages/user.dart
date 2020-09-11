import 'dart:io';
import 'package:i_Delivery/pages/passenger_seats.dart';
import 'package:i_Delivery/pages/map.dart';
import 'package:i_Delivery/pages/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_Delivery/pages/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:i_Delivery/widgets/appBars.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util.dart';



class user extends StatefulWidget {

  user({Key key}) : super(key: key);

  _userState createState() => _userState();
}

class _userState extends State<user> {
  //var bottomNavigationBarIndex = 0;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final UsNumberTextInputFormatter _phoneNumberFormatter = UsNumberTextInputFormatter();
  bool initStated = false;
  bool isLoading = false;

  File avatarImageFile;
  static String photoUrl = '';
  static String address = '';
  static String mobile = '';
  static String nickname = '';
  static String  email= '';
  static List<dynamic>  days = [];
  static String  busname= '';


  Future getImage(bool is_camera) async {
    File image = await ImagePicker.pickImage(
            source: is_camera ? ImageSource.camera : ImageSource.gallery,imageQuality: 25,maxHeight: 120);

    if (image != null) {
      setState(() {
        avatarImageFile = image;
        // isLoading = true;
      });
    }
    //uploadFile();
  }

  @override
  void initState() {
    super.initState();
    _readLocal().then((onValue) {
      setState(() {
        initStated = true;
      });
    });
  }

  Future<void> _readLocal() async {
    final DocumentSnapshot documents =
    await Firestore.instance.collection('bus_users').document(User.email).get();

    if (documents != null) {
      // Force refresh input

      nickname = documents['nickname'] ?? '';
      mobile = documents['mobile'] ?? '';
      photoUrl = documents['photoUrl'] ?? '';
      address = documents['address'] ?? '';
      email= User.email ?? '';
      days=  documents['Schedule_Date']==null ? [] : documents['Schedule_Date'].toList();
      busname= documents['busname'] ?? '';

    }
    else {
      print(User.email);
    }
  }

  Future _save() async {
    setState(() {
      isLoading = true;
    });
    if (avatarImageFile != null) {
      String fileName = User.email;
      StorageReference reference = FirebaseStorage.instance.ref().child(
          'profiles/${fileName}');
      StorageUploadTask uploadTask = reference.putFile(avatarImageFile);
      StorageTaskSnapshot storageTaskSnapshot;
      uploadTask.onComplete.then((value) {
        if (value.error == null) {
          storageTaskSnapshot = value;
          storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
            photoUrl = downloadUrl;


            _fbKey.currentState.setAttributeValue('photoUrl', photoUrl.trim().length==0 ?
            "https://firebasestorage.googleapis.com/v0/b/todo-fa3e3.appspot.com/o/blank-profile-picture.png?alt=media&token=7b200eeb-7d0e-4a46-a876-b894580e81f3"
                : photoUrl )  ;//await ;
            print(_fbKey.currentState.value);
            Firestore.instance.collection('bus_users')
                .document(User.email)
                .updateData(_fbKey.currentState.value)
                .then((data) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('photoUrl', photoUrl);
              await prefs.setString('mobile',  _fbKey.currentState.value["mobile"]);
              await prefs.setString('address',  _fbKey.currentState.value["address"]);

              User.mobile =  await prefs.get("mobile") ?? '';
              User.address =  await prefs.get("address") ?? '';
              busname =  _fbKey.currentState.value["busname"];
              days= _fbKey.currentState.value["days"];
              User.photoUrl = photoUrl;

              Fluttertoast.showToast(msg: "Saved success...");
              setState(()  {
                isLoading = false;

              });


        /*      Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => ( User.is_driver ? Home_driver() : Home()),
                ),
              );*/
            }).catchError((err) {
              print(err.toString());
            });
          }, onError: (err) {
            Fluttertoast.showToast(msg: 'This file is not an image');
          });
        } else {
          Fluttertoast.showToast(msg: 'This file is not an image');
        }
      }, onError: (err) {
       print(err.toString());
      });
    }
    else {
      _fbKey.currentState.setAttributeValue('photoUrl', photoUrl.trim().length==0 ?
      "https://firebasestorage.googleapis.com/v0/b/todo-fa3e3.appspot.com/o/blank-profile-picture.png?alt=media&token=7b200eeb-7d0e-4a46-a876-b894580e81f3"
          : photoUrl );
      Firestore.instance.collection('bus_users')
          .document(User.email)
          .updateData(_fbKey.currentState.value)
          .then((data) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('photoUrl', photoUrl);
        await prefs.setString('mobile',  _fbKey.currentState.value["mobile"]);
        await prefs.setString('address',  _fbKey.currentState.value["address"]);
        busname =  _fbKey.currentState.value["busname"];
        days= _fbKey.currentState.value["days"];
        User.photoUrl =  photoUrl;
        User.mobile =  await prefs.get("mobile") ?? '';
        User.address =  await prefs.get("address") ?? '';

        Fluttertoast.showToast(msg: "Saved success");
        setState(() {
          isLoading = false;
        });
     /*   Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => ( User.is_driver ? Home_driver() : Home()),
          ),
        );*/
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppbar(context),
      body: initStated ?
      Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
              child: Center(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.2,
                  child: Column(
                    children: <Widget>[
                      FormBuilder(
                        key: _fbKey,
                        initialValue: {
                          'nickname': nickname,
                          'address': address,
                          'mobile': mobile,
                          'photoUrl': photoUrl,
                          'email': email,
                          'Schedule_Date': days,
                          'busname': busname,
                        },
                        autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            FormBuilderCustomField(
                              attribute: "photoUrl",
                              validators: [
                                // FormBuilderValidators.required(),
                              ],
                              formField: FormField(
                                enabled: true,
                                builder: (FormFieldState<dynamic> field) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: Stack(
                                            children: <Widget>[
                                              (avatarImageFile == null)
                                                  ? (photoUrl != ''
                                                  ? Material(
                                                child: CachedNetworkImage(
                                                  placeholder: (context,
                                                      url) =>
                                                      Container(
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2.0,
                                                          valueColor: AlwaysStoppedAnimation<
                                                              Color>(
                                                              CustomColors
                                                                  .GreyBackground),
                                                        ),
                                                        width: 90.0,
                                                        height: 90.0,
                                                        padding: EdgeInsets
                                                            .all(20.0),
                                                      ),
                                                  imageUrl: photoUrl,
                                                  width: 90.0,
                                                  height: 90.0,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius
                                                    .all(
                                                    Radius.circular(45.0)),
                                                clipBehavior: Clip.hardEdge,
                                              )
                                                  : Icon(
                                                Icons.account_circle,
                                                size: 100.0,
                                                color: CustomColors
                                                    .TextHeaderGrey,
                                              ))
                                                  : Material(
                                                child: Image.file(
                                                  avatarImageFile,
                                                  width: 90.0,
                                                  height: 90.0,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius
                                                    .all(
                                                    Radius.circular(45.0)),
                                                clipBehavior: Clip.hardEdge,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //width: double.infinity,
                                        margin: EdgeInsets.all(20.0),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: CustomColors.PurpleLight
                                                .withOpacity(
                                                0.5),
                                          ),
                                          onPressed: () {
                                            getImage(true);
                                            field.didChange(photoUrl);
                                          },
                                          padding: EdgeInsets.all(30.0),
                                          splashColor: Colors.transparent,
                                          highlightColor: CustomColors.TextGrey,
                                          iconSize: 40.0,
                                        ),
                                      ), 
                                      Expanded (child:   IconButton(
                                        icon: Icon(
                                          Icons.photo_library,
                                          color: CustomColors.PurpleLight
                                              .withOpacity(
                                              0.5),
                                        ),
                                        onPressed: () {
                                          getImage(false);
                                          field.didChange(photoUrl);
                                        },
                                        padding: EdgeInsets.all(30.0),
                                        splashColor: Colors.transparent,
                                        highlightColor: CustomColors.TextGrey,
                                        iconSize: 40.0,
                                      )),
                                    ],
                                  );
                                },
                              ),
                            ),
                            FormBuilderTextField(
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "email@email.com",
                                  icon: Icon(Icons.email)
                              ),
                              attribute: "email",
                              validators: [
                                FormBuilderValidators.required(),
                              ],

                              keyboardType: TextInputType.emailAddress,
                              maxLength: 50,
                            ),
                            SizedBox(height: 5,),
                            FormBuilderTextField(
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  hintText: "abc nimal silva",

                                  icon: Icon(Icons.person)
                              ),
                              attribute: "nickname",
                              validators: [
                                FormBuilderValidators.required(),
                              ],

                              keyboardType: TextInputType.text,
                              maxLength: 50,
                            ),
                            SizedBox(height: 5,),
                            FormBuilderTextField(
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  labelText: "Bus Route",
                                  hintText: "Kandy To Colombo",

                                  icon: Icon(MaterialCommunityIcons.routes)
                              ),
                              attribute: "busname",
                              validators: [
                                FormBuilderValidators.required(),
                              ],

                              keyboardType: TextInputType.text,
                              maxLength: 50,
                            ),
                            SizedBox(height: 5,),
                            FormBuilderTextField(
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  labelText: "Bus Lic No.",
                                  hintText: "ND2478",
                                  icon: Icon(MaterialCommunityIcons.bus)
                              ),
                              attribute: "address",
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                              keyboardType: TextInputType.text,
                              maxLength: 100,
                            ),
                            SizedBox(height: 5,),
                            FormBuilderTextField(
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  labelText: "Mobile",
                                  hintText: "(077) 777-7777",
                                  icon: Icon(Entypo.mobile)
                              ),
                              attribute: "mobile",
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                // Fit the validating format.
                                _phoneNumberFormatter,
                              ],
                              maxLength: 14,
                              validators: [
                                FormBuilderValidators.required(),
                                //FormBuilderValidators.
                              ],
                              keyboardType: TextInputType.phone,

                            ),
                            SizedBox(height: 14,),
                            FormBuilderCheckboxList(
                              decoration:
                              InputDecoration(labelText: "Schedule Date ",
                                  icon: Icon(MaterialIcons.date_range)),
                              attribute: "Schedule_Date",
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                              //initialValue: days,
                              options: [
                                FormBuilderFieldOption(value: "Mon"),
                                FormBuilderFieldOption(value: "Tus"),
                                FormBuilderFieldOption(value: "Wed"),
                                FormBuilderFieldOption(value: "Thu"),
                                FormBuilderFieldOption(value: "Fri"),
                                FormBuilderFieldOption(value: "Sat"),
                                FormBuilderFieldOption(value: "Sun"),
                              ],
                            ),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              )

          ),
          // Loading
          Positioned(
            child: isLoading
                ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              color: Colors.white.withOpacity(0.8),
            )
                : Container(),
          )
        ],
      ) :
      Center(child: new CircularProgressIndicator()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: CustomColors.PurpleLight,
        onPressed: ()   {
            LogOut();

        },
        icon: Icon(AntDesign.logout),
        label: Text("Sign Out"),
      ),
      //bottomNavigationBar: BottomNavigationBarApp(context, bottomNavigationBarIndex),
      bottomNavigationBar: Row(
        children: <Widget>[
            RaisedButton(
            onPressed: () {
              if (_fbKey.currentState.saveAndValidate() && isLoading == false) {
                _fbKey.currentState.setAttributeValue("Coordinates", "") ;
                print(_fbKey.currentState.value);
                _save();
              }
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
                  .width/3 *2,
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.blue,
                    Colors.lightBlue,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(0.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.BlueShadow,
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
                  Icon(Icons.save, size: 35,),
                  Text(
                    isLoading ? '  Saving...' : '  Save',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),

                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Firestore.instance.collection('bus').document(User.email).setData({
                'Code': User.email,
                'busname' : busname,
                'Start': true,
                'days' :days,
                'Start_at': DateTime.now(),
              });

              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => map(canback: false,mode: FABMode.Driver,BusID:User.email ,),
                ),
              );
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
                  .width/3*1,
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    CustomColors.PurpleDark,
                    CustomColors.PurpleDark,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(0.0),
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
                  Icon(MaterialCommunityIcons.map_marker_multiple, size: 35,),
                  Text(
                    ' Start\n Bus',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
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

     if (User.is_driver) {

     }
     else{
       Firestore.instance.collection('bus_users')
           .document(User.email)
           .updateData({
         'lat': 0,
         'lon': 0,
         'last_update': DateTime.now(),
       });
     }

     Navigator.of(context).push(
       PageRouteBuilder(
         transitionDuration: Duration(seconds: 1),
         pageBuilder: (_, __, ___) => Onboarding(),
       ),
     );
  }


}

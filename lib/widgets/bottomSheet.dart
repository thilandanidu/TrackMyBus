
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../util.dart';

class Modal {
  AbountUs(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 100,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height / 13,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(175, 30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 300,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/images/fab-delete.png'),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                CustomColors.PurpleLight,
                                CustomColors.PurpleDark,
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.PurpleShadow,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'About Us',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),

                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 100,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                              ),
                            ),
                            child:  Image.asset('assets/images/logo.png' ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Software by',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(FontAwesome5.building),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'NBiT Software @ 2019',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),


                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Hot-Line',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          //SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[


                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(Icons.call),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '+94 77 77 9 38 48 / +94 77 78 6 92 85',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'E-mail',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(MaterialCommunityIcons.email),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'info@nbitsoftware.net',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Web',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[


                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(MaterialCommunityIcons.web),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'NBiTSoftware.net',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                              ),
                            ),
                            child:  Text("© ${DateTime.now().year} NBiT. All Rights Reserved.",textAlign: TextAlign.center,),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Students(BuildContext context,DocumentSnapshot student,Function callback) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 100,
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height / 13,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(175, 30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 300,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/images/fab-delete.png'),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                CustomColors.PurpleLight,
                                CustomColors.PurpleDark,
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.PurpleShadow,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'About',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),

                          SizedBox(height: 5),
                          /*Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 100,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                              ),
                            ),
                            child:  Image.asset('assets/images/logo.png' ),
                          ),*/
                          Container(
                           // width: 68,
                            padding: EdgeInsets.only(left: 10),
                            child: Stack(
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                        student['photoUrl'])),

                              ],

                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Name',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(FontAwesome5.user),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  student['student_name'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),


                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Hot-Line',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          //SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[


                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(Icons.call),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${student['mobile1']} / ${student['mobile2']}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          /*SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'E-mail',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                         Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(MaterialCommunityIcons.email),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${student['email'].toString().trim().length==0 ? 'N/A' : student['email']}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),*/

                          SizedBox(height: 12),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Address',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[


                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(Entypo.address),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  student['address'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all( 5),
                            child: RaisedButton(
                              onPressed: () {
                               // _classDialog(context);
                                callback(student);
                                Navigator.pop(context);
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                height: 40,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      CustomColors.BlueLight,
                                      CustomColors.BlueLight,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
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
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(MaterialCommunityIcons.memory, size: 25,),
                                    ),
                                    Text(
                                      'Mark Attendance',
                                      style: TextStyle(
                                          fontSize: 11, fontWeight: FontWeight.w400 ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                              ),
                            ),
                            child:   Text("© ${DateTime.now().year} NBiT. All Rights Reserved.",textAlign: TextAlign.center,),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  LicExpires(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 100,
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height / 13,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(175, 30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 300,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/images/fab-delete.png'),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                CustomColors.PurpleLight,
                                CustomColors.PurpleDark,
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.PurpleShadow,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Please Renew Licence',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),

                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 100,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                              ),
                            ),
                            child:  Image.asset('assets/images/logo.png' ),
                          ),


                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Hot-Line',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          //SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[


                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(Icons.call),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '+94 77 77 9 38 48 / +94 77 78 6 92 85',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'E-mail',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(MaterialCommunityIcons.email),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'info@nbitsoftware.net',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Web',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              children: <Widget>[


                                RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(MaterialCommunityIcons.web),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'NBiTSoftware.net',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: CustomColors.GreyBorder,
                                ),
                              ),
                            ),
                            child:  Text("© ${DateTime.now().year} NBiT. All Rights Reserved.",textAlign: TextAlign.center,),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

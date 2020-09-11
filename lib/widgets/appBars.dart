import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:i_Delivery/pages/user.dart';
import '../util.dart';


Widget fullAppbar(BuildContext context,[bool show_user_icon = false,bool automaticallyImplyLeading=true]) {

  return PreferredSize(
    preferredSize: Size.fromHeight(70.0),
    child: GradientAppBar(
      automaticallyImplyLeading: automaticallyImplyLeading, // U
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello ${User.nickname }!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              '${User.email }',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        GestureDetector(
            onTap: (){
              if(show_user_icon) {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    pageBuilder: (_, __, ___) => (user()),
                  ),
                );
              }
            },
          child:  Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: CircleAvatar(
                    backgroundImage: NetworkImage(
                    User.photoUrl)),
          )

        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue, Colors.lightBlue.shade600],
      ),

    ),
  );
}

Widget emptyAppbar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(55.0),
    child: GradientAppBar(
      automaticallyImplyLeading: false, // U
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin: EdgeInsets.only(top: 5,bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello ${User.nickname }!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              '${User.email }',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: (){

          },
          child:
           IconButton(icon:  Container(
             margin: EdgeInsets.only(top: 5,bottom: 5),
             child: Image.asset(
               'assets/images/task.png',
               color: CustomColors.TextWhite,
             ),
           ), onPressed: null)
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue, Colors.lightBlue.shade600],
      ),
    ),
  );
}


class CircleOne extends CustomPainter {
  Paint _paint;

  CircleOne() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(28.0, 0.0), 99.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-30, 20), 50.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

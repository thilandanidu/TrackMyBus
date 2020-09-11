import 'package:flutter/material.dart';

/**
 * This is just a basic `Scaffold` with a centered `CircularProgressIndicator`
 * class right in the middle of the screen.
 *
 * It's copied from the `flutter_gallery` example project in flutter/flutter
 */
class LoadingScreen extends StatefulWidget {
  final int type ;

  LoadingScreen(this.type,{  Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => new _LoadingScreenState(type: this.type);
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  final int type;

  _LoadingScreenState({
    Key key,
    this.type});


  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this
    )..forward();
    _animation = new CurvedAnimation(
        parent: _controller,
        curve: new Interval(0.0, 0.9, curve: Curves.fastOutSlowIn),
        reverseCurve: Curves.fastOutSlowIn
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      } else if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget component = new Scaffold(

        body: new Container(
            child: new AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget child) {

                  //print(this.type);
                  switch(this.type){
                    case 1:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 250.0),
                        child: Center(child: new CircularProgressIndicator()),
                      );

                    default:
                      {
                        return Center(child: new CircularProgressIndicator());
                      }
                      break;
                  }

                }
            )
        )
    );
    return component;
  }
}




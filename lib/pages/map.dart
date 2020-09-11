import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_Delivery/widgets/appBars.dart';

import '../util.dart';
import 'home.dart';

enum ConfirmAction { CANCEL, ACCEPT }


class map extends StatefulWidget {
  final bool canback;
  final FABMode mode;
  final String BusID;
  final int seateid;
  map({Key key, @required this.canback,this.mode,this.BusID, this.seateid = 0 }) : super(key: key);
  @override
  State<map> createState() => mapState();
}

class mapState extends State<map> {
  Completer<GoogleMapController> _controller = Completer();
  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor pinShattelIcon;
  Set<Marker> _markers = {};
  Set<Marker> _markers_added = {};
  Position _currentPosition;
  String _currentAddress;
  Position _ShatelPosition;
  double CAMERA_ZOOM = 13;
  double CAMERA_TILT = 80;
  double CAMERA_BEARING = 30;
  //LatLng SOURCE_LOCATION = LatLng(7.0916,79.9948);
  StreamSubscription<Position> positionStream ;
  StreamSubscription<QuerySnapshot> streamSub ;
  int noOfPesseners=0;

  bool initStated = false;
  bool isLoading = false;
  static CameraPosition _start_location = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    _markers_added={};

      _getCurrentLocation().then((onValue) async {
        await setState(() {
          _start_location = CameraPosition(
            target: LatLng(
                _currentPosition.latitude, _currentPosition.longitude),
            zoom: CAMERA_ZOOM,
          );
          _markers.add(
              Marker(
                  markerId: MarkerId(
                      widget.mode == FABMode.Driver ? widget.BusID : "MYID"),

                  position: LatLng(
                      _currentPosition.latitude, _currentPosition.longitude),
                  icon: widget.mode == FABMode.Driver ? pinShattelIcon : pinLocationIcon
              )
          );
          initStated = true;
        });
      });

      //var geolocator = Geolocator();
      var locationOptions = LocationOptions(
          accuracy: LocationAccuracy.high, distanceFilter: 5);

    positionStream = geolocator.getPositionStream(locationOptions).listen(
              (Position position) {
            _ShatelPosition = position;
            print(position == null ? 'Unknown' : position.latitude.toString() +
                ', ' + position.longitude.toString());
            if (widget.mode == FABMode.Driver) {
              Firestore.instance.collection('bus')
                  .document(widget.BusID)
                  .updateData({
                'lat': position.latitude,
                'lon': position.longitude,
                'last_update': DateTime.now(),
              });
            }
            else{
              Firestore.instance.collection('bus_users')
                  .document(User.email)
                  .updateData({
                'lat': position.latitude,
                'lon': position.longitude,
                'last_update': DateTime.now(),
              });
            }
            updatePinOnMap(position,(widget.mode == FABMode.Driver ? widget.BusID : "MYID"),widget.mode);
          });

      _readLocal().then((onValue) {
        setState(() {
        //  initStated = true;
        });
      });
   // }
  }

  @override
  void dispose() {
    super.dispose();
    positionStream.cancel();
    streamSub.cancel();
    print("dispose");
  }


  Future<void> _readLocal() async {
    if (widget.mode == FABMode.Driver) {
    streamSub =  Firestore.instance
          .collection('bus_users')
          .where("is_driver", isEqualTo: false)
          .snapshots()
          .listen((data) {
        data.documents.forEach((doc) {

          print("+++++++++");
          print(doc.documentID);
          print("+++++++++");
          Position pinPosition = Position( longitude:  doc["lon"] ?? 0 , latitude: doc["lat"] ?? 0 );



          updatePinOnMap(pinPosition,doc.documentID,FABMode.Passenger);

        });
      });
    }


    else{
      streamSub = Firestore.instance
          .collection('bus')
          .where("Code", isEqualTo: widget.BusID)
          .snapshots()
          .listen((data) {
        data.documents.forEach((doc) {
            Position pinPosition = Position( longitude:  doc["lon"] ?? 0 , latitude: doc["lat"] ?? 0 );
             updatePinOnMap(pinPosition,widget.BusID,FABMode.Driver);
        });
      });
    }
  }


  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context,markerId) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick-up the Passanger?'),
          content: const Text(
              'Do you want to Pick-up the Passanger.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('Pick-Up'),
              onPressed: () {

                _markers_added.add(_markers.firstWhere(
                        (m) => m.markerId.value == markerId));

                setState(() {
                  noOfPesseners++;
                });
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/destination_map_marker.png',);

    pinShattelIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/bus.png');
  }

  void updatePinOnMap(Position Position,markerId,mode) async {

    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(Position.latitude,
          Position.longitude),
    );
    final GoogleMapController controller = await _controller.future;
   // controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
     var pinPosition = LatLng(Position.latitude, Position.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere(
              (m) => m.markerId.value == markerId);
      _markers.add(Marker(
          markerId: MarkerId(markerId),
          onTap: () async {
            if( mode== FABMode.Passenger && widget.mode == FABMode.Driver) {

              if(_markers_added.where((item) => item.markerId.value  == markerId).length ==0 ) {
                final ConfirmAction action = await _asyncConfirmDialog(
                    context, markerId);
              }
              else{
                Fluttertoast.showToast(msg: "Already Added.");
              }

            }
          },
          position: pinPosition, // updated position
          icon: mode == FABMode.Driver ? pinShattelIcon : pinLocationIcon
      ));
    });
  }


  @override
  Widget build(BuildContext context) {
    print(widget.canback);
    return new Scaffold(
      appBar: fullAppbar(context, (widget.mode == FABMode.Driver ? true : false),widget.canback),
      body: initStated ? Container(
        color: Colors.black12,
        child: Column(
          children: <Widget>[
            widget.mode == FABMode.Driver ? Container(
              padding: const EdgeInsets.all(8.0),
              child: Text("No of Passengers in bus : ${noOfPesseners}",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.PurpleDark),),
            ):Container(
              padding: const EdgeInsets.all(8.0),
              child: Text("Your Seat No is ${widget.seateid}",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.PurpleDark),),
            ),
            Expanded(
              child: GoogleMap(
                markers: _markers,
                mapType: MapType.normal,
                initialCameraPosition: _start_location,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                zoomGesturesEnabled: true,
                mapToolbarEnabled: true,
               // onTap: _handleTap,
              ),
            ),

          ],
        ),
      ) : Center(child: new CircularProgressIndicator()),
      floatingActionButton: Visibility(
        visible: widget.mode == FABMode.Driver ? false : true,
        child: FloatingActionButton.extended(
          onPressed: (){
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => (Home()),
              ),
            );
          },
          label: Text('Back to List'),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    print("1...");
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position)  {
    //  print("2");
      setState(() {
        _currentPosition = position;
      });

      print(_currentPosition.toJson());

     // await _getAddressFromLatLng();
    }).catchError((e) {
   //   print("3");
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      //  print(_currentPosition.toJson());
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.thoroughfare}, ${place.country}";
      });

      //  print(_currentAddress);
    } catch (e) {
      print(e);
    }
  }
}

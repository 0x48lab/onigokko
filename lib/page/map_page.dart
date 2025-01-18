import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MapPage> {
  Marker? currentMarker;
  GoogleMapController? _mapController;
  Marker? myHome;
  Marker? visitor;
  // Set, List, Map, etc...  内側の多角形の座標を設定
  final Set<Polygon> _polygons = {
    Polygon(
        polygonId: PolygonId('poly_1'),
        points: [
          LatLng(35.685175, 139.7528),
          LatLng(35.6821, 139.7758),
          LatLng(35.6791, 139.7725),
          LatLng(35.678, 139.7495),
        ],
        strokeColor: Colors.green,
        strokeWidth: 2,
        fillColor: Colors.green.withOpacity(0.35)
    )
  };

//////////////////////////////
  Future<Uint8List> _resizeMarkerImages(String asset, int width, int height) async {
    ByteData data = await rootBundle.load(asset);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width, targetHeight: height);
    FrameInfo fi = await codec.getNextFrame();
    ByteData? byteData = await fi.image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List> _getBytesFromUrl(String url, int width, int height) async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      Uint8List data = response.bodyBytes;
      Codec codec = await instantiateImageCodec(data, targetWidth: width, targetHeight: height);
      FrameInfo fi = await codec.getNextFrame();
      ByteData? byteData = await fi.image.toByteData(format: ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } else {
      return _resizeMarkerImages("assets/images/t_icon_1.png", width, height);
    }
  }
//////////////////////////////
  Future<Marker> createMarker(String markerId, LatLng position, String imageName) async {
    final image = await _getBytesFromUrl(imageName, 256, 256);
    final icon = BitmapDescriptor.fromBytes(image);

    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      icon: icon,
    );

    return marker;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void locatePilot(){
    Geolocator.getPositionStream().listen((onData) async {
      final newMarker = await createMarker(
          "Visitor",
          LatLng(onData.latitude,onData.longitude),
          "https://pbs.twimg.com/profile_images/1336142714182586370/A9PVLfgf_400x400.jpg"
      );
      setState(() {
        visitor = newMarker;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    createMarker(
      "my_home",
      LatLng(34.8713237,136.4907969),
      "https://pbs.twimg.com/profile_images/1336142714182586370/A9PVLfgf_400x400.jpg",
    ).then((value){
      myHome = value;
    });

    _determinePosition().then((value) async{
      final position = LatLng(value.latitude, value.longitude);

      setState(() {
        _mapController?.moveCamera(CameraUpdate.newLatLng(position));
      });

      createMarker(
        "Visitor",
        position,
        "https://pbs.twimg.com/profile_images/1336142714182586370/A9PVLfgf_400x400.jpg",
      ).then((value){
        setState(() {
          visitor = value;
        });
      });

    });

    locatePilot();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> marker = {};
    if(myHome!=null) marker.add(myHome!);
    if(visitor!=null) marker.add(visitor!);
    return Scaffold(
      /***appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Maps"),
          ),***/
        body: Center(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 14.4746,
            ),
            markers: marker,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            polygons: _polygons,
            onTap: (LatLng point){
              showIdoKeido(context, point);
            },
          ),
        ));
  }

  bool isPointInPolygon(LatLng point, List<LatLng> polygon){
    int intersections = 0;
    for(int i = 0; i < polygon.length; i++) {
      int j = ( i + 1 ) % polygon.length;
      if(doIntersect(polygon[i], polygon[j], point)) {
        intersections++;
      }
    }
    return intersections % 2 == 1;
  }

  bool doIntersect(LatLng p1, LatLng p2, LatLng point) {
    if (p1.latitude > point.latitude != p2.latitude > point.latitude) {
      double slope = (p2.longitude - p1.longitude) / (p2.latitude - p1.latitude);
      double xIntersection = p1.longitude + slope * (point.latitude - p1.latitude);
      return point.longitude < xIntersection;
    }
    return false;
  }

  void showIdoKeido(BuildContext context, LatLng tappedPoint){
    bool isInside = isPointInPolygon(tappedPoint, _polygons.first.points);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Location"),
            content: Text("入っている　入っていない ${isInside}"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: (){
                  Navigator.of(context).pop();
                },)
            ],
          );
        }
    );
  }
}
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:datingsample/component/MapMarker.dart';
import 'package:datingsample/component/ProfileItem.dart';
import 'package:datingsample/component/customui/CustomPageView.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/controller.dart';
import 'package:mapbox_gl/overlay.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MapboxOverlayController mapController = MapboxOverlayController();
  final random = Random();

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Nguyen Duc Duy',
      'title': 'Software Engineer @ 6Mui',
      'intersections': [
        [12.976321, 77.591332],
        [12.966321, 77.591332],
        [12.965321, 77.592332],
        [12.985321, 77.592432],
        [12.976321, 77.581332],
        [12.966321, 77.571332],
        [12.965321, 77.598332],
        [12.985321, 77.593432]
      ],
      'image':
          'https://www.seducewithpersonality.com/wp-content/uploads/2013/08/Tests-from-women.jpg',
    },
    {
      'name': 'Dang Minh Hieu',
      'title': 'Musician',
      'intersections': [
        [12.966321, 77.571332],
        [12.965321, 77.598332]
      ],
      'image':
          'https://screenshotscdn.firefoxusercontent.com/images/4ac934d7-383a-4886-b7f9-fc05b491b386.png',
    },
    {
      'name': 'Phan Duy Duc',
      'title': 'He atac. He protec',
      'intersections': [
        [12.976321, 77.591332],
        [12.966321, 77.591332],
        [12.965321, 77.592332],
      ],
      'image':
      'https://i.imgur.com/pxU5DyD.png',
    },
    {
      'name': 'Luong The Minh Quang',
      'title': 'Failure. Broke af :(',
      'intersections': [
        [12.985321, 77.593432]
      ],
      'image': 'https://3vnqw32fta3x1ysij926ljs3-wpengine.netdna-ssl.com/wp-content/uploads/2003/03/Talking-Trash-576x360.jpg',
    },
  ];

  final markersOnMap = <Widget>[];

  _initUser() {
    int maxIntersection = 0;
    for (int i = 0; i < users.length; ++i) {
      maxIntersection =
          max(maxIntersection, (users[i]['intersections'] as List).length);
    }
    for (int i = 0; i < maxIntersection; ++i) {
      markersOnMap.add(AnimatedPositioned(
          child: AnimatedOpacity(
              child: MapMarker(),
              opacity: .0,
              duration: Duration(milliseconds: 700)),
          duration: Duration(milliseconds: 100)));
    }
  }

  @override
  void initState() {
    super.initState();
    _initUser();
    Future.delayed(Duration(seconds: 3), () => _getMarkers(0));
  }

  Widget _buildProfileList() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: CustomPageView(
        itemBuilder: (_, index) {
          return ProfileItem(user: users[index]);
        },
        itemCount: users.length,
        width: 400,
        height: 250,
        viewportFraction: .65,
        onPageChanged: _getMarkers,
      ),
    );
  }

  Widget _buildImageOverlayGradient() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: const LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: const [
            Colors.white30,
            Colors.transparent,
          ],
          tileMode: TileMode.clamp,
        ),
      ),
      child: _buildProfileList(),
    );
  }

  Widget _buildMap() {
    return MapboxOverlay(
      controller: mapController,
      options: MapboxMapOptions(
        style: Style.light,
        camera: CameraPosition(
          target: LatLng(lat: 12.986321, lng: 77.591332),
          zoom: 12.0,
          bearing: 0.0,
          tilt: 0.0,
        ),
      ),
    );
  }

  Future<Null> _getMarkers(int page) async {
    int intersectionLength = (users[page]['intersections'] as List).length;
    for (int i = 0; i < markersOnMap.length; ++i) {
      int index = i;
      if (i >= intersectionLength) index = random.nextInt(intersectionLength);
      List<double> c = users[page]['intersections'][index];
      final offset =
          await mapController.getOffsetForLatLng(LatLng(lat: c[0], lng: c[1])) /
              window.devicePixelRatio;
      markersOnMap[i] = AnimatedPositioned(
        child: AnimatedOpacity(
          opacity: i < intersectionLength ? 1.0 : 0.0,
          duration: Duration(milliseconds: 600),
          child: MapMarker(),
        ),
        left: offset.dx,
        top: offset.dy,
        duration: Duration(milliseconds: 700),
      );
    }
    debugPrint(page.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildMap(),
          _buildImageOverlayGradient(),
          // _buildProfileList(),
          Stack(
            children: markersOnMap,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.near_me),
        elevation: 20.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.score), title: Text("Stats")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("Date")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Setting"))
        ],
        currentIndex: 1,
      ),
    );
  }
}

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

  Widget _buildProfileList() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: CustomPageView(
        itemBuilder: (_, index) {
          return ProfileItem();
        },
        itemCount: 5,
        width: 400,
        height: 250,
        viewportFraction: .65,
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
            Colors.black26,
            const Color(0x00000000),
            const Color(0x00000000),
            const Color(0x00000000),
          ],
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
          target: LatLng(lat: 12.976321, lng: 77.591332),
          zoom: 12.0,
          bearing: 0.0,
          tilt: 0.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildMap(),
          _buildImageOverlayGradient(),
          // _buildProfileList(),
          Positioned(child: MapMarker(), left: 150.0, top: 450.0,),
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

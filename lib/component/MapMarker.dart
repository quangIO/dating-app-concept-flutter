import 'package:flutter/material.dart';

class MapMarker extends StatelessWidget {
  const MapMarker({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7.0,
      shape: CircleBorder(side: BorderSide(color: Colors.red)),
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: SizedBox(width: 12.0, height: 12.0),
        ),
      ),
    );
  }
}

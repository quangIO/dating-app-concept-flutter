import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({this.user});

  final Map<String, dynamic> user;
  final ScrollController controller = ScrollController();

  Widget _buildImageOverlayGradient(BuildContext context) {
    return Hero(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: const [Colors.black87, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: const Alignment(.0, .3)),
        ),
        position: DecorationPosition.foreground,
        child: Image.network(user['image']),
      ),
      tag: 'image-${user['name']}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buildImageOverlayGradient(context),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      user['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  bottom: 10.0,
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, top: 20.0),
                      child: Text(
                        "Hanoi, Vietnam",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        "20",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 26.0),
                      child: Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
                        style: TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  child: HeartButton(userId: 1),
                  top: -35.0,
                  right: 16.0,
                )
              ],
              overflow: Overflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}

class HeartButton extends StatefulWidget {
  final int userId;

  const HeartButton({Key key, @required this.userId}) : super(key: key);

  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    if (liked) {
      return FloatingActionButton(
        child: Icon(
          Icons.favorite,
          color: Colors.red,
          size: 32.0,
        ),
        onPressed: () {
          setState(() {
            liked = false;
          });
        },
        backgroundColor: Colors.white,
      );
    }
    return FloatingActionButton(
      child: Icon(
        Icons.favorite,
        color: Colors.white,
        size: 32.0,
      ),
      onPressed: () {
        setState(() {
          liked = true;
        });
      },
    );
  }
}

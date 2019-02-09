import 'package:datingsample/screen/ProfileScreen.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfileItem({Key key, @required this.user}) : super(key: key);

  factory ProfileItem.forDesignTime() {
    // TODO: add arguments
    return new ProfileItem(user: {
      'name': 'Haha',
      'title': 'CEO',
      'image':
          'https://www.seducewithpersonality.com/wp-content/uploads/2013/08/Tests-from-women.jpg'
    });
  }

  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  Widget _buildAvatarPicture() {
    return Hero(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: const [Colors.black26, Colors.transparent],
              begin: Alignment.topCenter,
              end: const Alignment(.0, -.3)),
        ),
        position: DecorationPosition.foreground,
        child: Image.network(widget.user['image']),
      ),
      tag: 'image-${widget.user['name']}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Hero(
          child: Text(
            widget.user['name'],
            style: TextStyle(color: Colors.blueGrey, fontSize: 32.0),
          ),
          tag: 'name-${widget.user['name']}',
        ),
      ),
    );
    final title = Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
      child: Text(
        widget.user['title'],
        style: TextStyle(fontSize: 12.0),
      ),
    );
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          type: MaterialType.card,
          child: Column(
            children: <Widget>[
              Flexible(
                child: _buildAvatarPicture(),
                flex: 1,
              ),
              Divider(color: Colors.transparent),
              name,
              title,
            ],
          ),
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10.0),
          shadowColor: Colors.black54,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(user: widget.user),
          ),
        );
      },
    );
  }
}

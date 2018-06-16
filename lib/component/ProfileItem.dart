import 'package:flutter/material.dart';

class ProfileItem extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfileItem({Key key, this.user}) : super(key: key);

  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  Widget _buildAvatarPicture() {
    return Container(
      child: Image.network(
        "https://www.seducewithpersonality.com/wp-content/uploads/2013/08/Tests-from-women.jpg",
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          "Mai Phuong Thuy Tien",
          style: TextStyle(color: Colors.purpleAccent, fontSize: 32.0),
        ),
      ),
    );
    final title = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        "CEO at Rudicaf",
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
              Flexible(child: _buildAvatarPicture(), flex: 1,),
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
    );
  }
}

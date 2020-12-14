import 'package:flutter/material.dart';



class AvatarPerfil extends StatelessWidget {
  final String imgUrl;

  const AvatarPerfil({
    Key key,
    @required this.imgUrl,
  }) : super (key: key);



  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.0,
      backgroundColor: Colors.grey,
      backgroundImage: NetworkImage(imgUrl),
    );
  }
}

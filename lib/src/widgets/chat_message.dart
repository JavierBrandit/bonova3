import 'package:bonova0002/src/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key key,
    @required this.animationController, 
    @required this.texto, 
    @required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation( parent: animationController, curve: Curves.easeOut ),
        child: Container(
          child: this.uid == authService.usuario.uid
            ? _myMessage(isDarkTheme)
            : _otherMessage(isDarkTheme),
        ),
      ),
    );
  }

  Widget _myMessage(bool dark) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only( bottom: 2, left: 50, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text( this.texto, style: TextStyle( fontWeight: FontWeight.w400, letterSpacing: -0.4, fontSize: 14 ), ),
        decoration: BoxDecoration( 
          color: dark? Colors.teal[800] : Colors.tealAccent.withOpacity(0.34),
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }

  Widget _otherMessage(bool dark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only( bottom: 2, right: 50, left: 20),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text( this.texto, style: TextStyle( fontWeight: FontWeight.w400, letterSpacing: -0.4, fontSize: 14 ) ),
        decoration: BoxDecoration( 
          color: dark? Colors.blueGrey[800] : Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}
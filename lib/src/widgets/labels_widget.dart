import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
final String ruta;
final String titulo;
final String subtitulo;

const Labels({
  @required this.ruta,
  @required this.titulo,
  @required this.subtitulo

  });

  @override
  Widget build(BuildContext context) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      child: Column( children: <Widget>[
        Text(this.titulo, style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300, fontFamily: 'Montserrat'),),
        SizedBox(height: 10,),
        GestureDetector( 
          child: Text( this.subtitulo , style: TextStyle(color: Colors.teal[400], fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.3 ),),
          onTap: () => Navigator.pushReplacementNamed(context, this.ruta)
          ),        
        //GestureDetector()
      ],),
    );
  }
}
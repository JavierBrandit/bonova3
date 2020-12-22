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
    return Container(
      child: Column( children: <Widget>[
        Text(this.titulo, style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Montserrat'),),
        SizedBox(height: 10,),
        GestureDetector( 
          child: Text( this.subtitulo , style: TextStyle(color: Colors.teal[400], fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.3 ),),
          onTap: () => Navigator.pushReplacementNamed(context, this.ruta)
          ),        
        //GestureDetector()
      ],),
    );
  }
}
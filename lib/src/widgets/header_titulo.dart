import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class HeaderTitulo extends StatelessWidget {
  final String titulo;
  final String paginaDestino;

  const HeaderTitulo({
    Key key,
    @required this.titulo,
    @required this.paginaDestino,
  }) : super (key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [

          SizedBox(height: 18.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(width: 28 ),
                  Text(titulo, style: TextStyle(fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),),
                ],
              ),
              Row(
                children: [
                  Icon(FluentSystemIcons.ic_fluent_chevron_right_regular,
                    color: Colors.teal, size: 19,),
                  SizedBox(width: 28,),
                ],
              )
            ],),
          SizedBox(height: 20.0,),

        ],
      ),
      onTap: () => Navigator.pushNamed(context, paginaDestino),
    );
  }

}

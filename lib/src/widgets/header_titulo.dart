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

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      child: Container(
        color: isDarkTheme? Colors.grey[850] : Colors.white,
        child: Column(
          children: [

            SizedBox(height: 18.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(width: 30 ),
                    Text(titulo,
                      style: TextStyle(fontSize: 17.5,
                        fontWeight: FontWeight.w400, letterSpacing: 0.7,
                        color: isDarkTheme? Colors.white : Colors.grey[850]
                    ))],
                ),
                Row(
                  children: [
                    Icon(FluentSystemIcons.ic_fluent_chevron_right_regular,
                      color: isDarkTheme? Colors.white : Colors.teal, size: 19,),
                    SizedBox(width: 28,),
                  ],
                )
              ],),
            SizedBox(height: 20.0,),

          ],
        ),
      ),
      onTap: () => Navigator.pushNamed(context, paginaDestino),
    );
  }

}

import 'package:bonova0002/theme.dart';
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
        color: isDarkTheme? BonovaColors.azulNoche[900].withOpacity(0.25) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
                    Text(titulo,
                      style: TextStyle(fontSize: 13.5,
                        fontWeight: FontWeight.w500, letterSpacing: 0.5,
                        color: isDarkTheme? Colors.white : Colors.grey[850]
                    )),
                    Icon(FluentSystemIcons.ic_fluent_chevron_right_regular, size: 17,),

            
          ]
      )),
      onTap: () => Navigator.pushNamed(context, paginaDestino),
    );
  }

}

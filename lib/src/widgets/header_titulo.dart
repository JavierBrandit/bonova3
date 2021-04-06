import 'package:bonova0002/theme.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
        decoration: BoxDecoration( border: Border(
                                              bottom: BorderSide(width: .07, color: Colors.grey[500]),
                                              // top: BorderSide(width: .05, color: Colors.white ),
                                               ),
        // color: isDarkTheme? BonovaColors.azulNoche[900].withOpacity(0.25) : Colors.white,
        ),
        padding: EdgeInsets.only(right: 25, left: 25, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Text( titulo,
                  style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w500, letterSpacing: 0,
                // color: isDarkTheme? Colors.white : Colors.grey[850]
            )),
            Icon(FluentIcons.chevron_right_24_regular, size: 17,),

            
          ]
      )),
      onTap: () => Navigator.pushNamed(context, paginaDestino),
    );
  }

}

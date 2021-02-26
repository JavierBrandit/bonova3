import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrearPortadas extends StatelessWidget {
  final Size pantalla;

  const CrearPortadas({
    Key key,
    @required this.pantalla,
  }) : super (key: key);


  @override
  Widget build(BuildContext context) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        HeaderTitulo(titulo: 'Materias', paginaDestino: ''),
        SizedBox( height: 10),

        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            portada( context, isDarkTheme? 'assets/portadaMatematicaNoche.png' : 'assets/portadaMatematica.png', 'matematica'),
            portada( context, isDarkTheme? 'assets/portadaFisicaNoche.png' : 'assets/portadaFisica.png', 'fisica'),
        ]),
        
      ],
    );
  }

  Widget portada( BuildContext context, String img, String path ) {

    return Container(
      margin: EdgeInsets.only(right: 0, left: 25, top: 7, bottom: 10),
      width: 110,
      child: GestureDetector(
        onTap: (){
          CursoService cursoService = Provider.of<CursoService>(context, listen: false );
          cursoService.ramo = path;

          Navigator.pushNamed(context, 'ramo'); 
        },
        child: Image.asset(img)
      ),
    );
  }


}

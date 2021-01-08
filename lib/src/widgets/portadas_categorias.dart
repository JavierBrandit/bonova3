import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
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
      children: <Widget>[

        HeaderTitulo(titulo: 'Materias', paginaDestino: '',),
        SizedBox( height: 25 ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              portada( context, isDarkTheme? 'assets/portadaMatematicaNoche.png' : 'assets/portadaMatematica.png', 'matematica'),
              portada( context, isDarkTheme? 'assets/portadaFisicaNoche.png' : 'assets/portadaFisica.png', 'fisica'),
            ],),
        ),
        SizedBox( height: 25 ),
        
      ],
    );
  }

  Widget portada( BuildContext context, String img, String path ) {

    CursoService cursoService = Provider.of<CursoService>(context, listen: false );
    return Container(
      margin: EdgeInsets.symmetric( vertical:10.0 ),
      width: pantalla.width * 0.35,
      // decoration: BoxDecoration( boxShadow: [BoxShadow(
      //     color: Colors.grey[100],
      //     offset: Offset.fromDirection(-10.0),
      //     blurRadius: 10
      // )]),
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

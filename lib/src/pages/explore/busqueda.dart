import 'package:flutter/material.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/services/videos_service.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:bonova0002/theme.dart';



class CursosSearchDelegate extends SearchDelegate<Curso> {

  @override
  final String searchFieldLabel;
  final List<Curso> historial;

  CursosSearchDelegate(this.searchFieldLabel, this.historial);
  
  @override
  ThemeData appBarTheme(BuildContext context) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    assert(context != null);
    final ThemeData theme = ThemeData(

      // primarySwatch: Colors.teal,
      // scaffoldBackgroundColor: Colors.grey[50],
      // brightness: Brightness.light,

      // appBarTheme: AppBarTheme(  elevation: 0 ),
      // inputDecorationTheme: InputDecorationTheme(
      //   hintStyle: TextStyle(color: Colors.white),
      //   labelStyle: TextStyle(color: Colors.white),
      // ),
      
      // canvasColor: Colors.white,
      // accentColor: Colors.grey,
      primaryColor: isDarkTheme? BonovaColors.azulNoche[600] : Colors.white,

      // primaryColorBrightness: Brightness.dark,
      // accentIconTheme: IconThemeData(color: Colors.black),

      );
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          padding: EdgeInsets.only(right: 20),
          icon: Icon( Icons.clear, size: 16, color: Colors.grey[400],), 
          onPressed: () => this.query = ''
        )
      ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(left: 10),
      icon: Icon( FluentIcons.chevron_left_24_filled, size: 16,),
      onPressed: () => this.close(context, null )
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if ( query.trim().length == 0 ) {
      return Text('no hay valor en el query');
    }


    final videoService = new VideoService();
    // query!
    return FutureBuilder(
      // future: videoService.getCountryByName( query ),
      builder: ( _ , AsyncSnapshot snapshot) {
        
        if ( snapshot.hasError ) {
          return ListTile( title: Text('No hay nada con ese término') );
        }

        if ( snapshot.hasData ) {
          // crear la lista
          return _mostrarCursos( snapshot.data );
        } else {
          // Loading
          return Center(child: CircularProgressIndicator( strokeWidth: 1 ));
        }
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _mostrarCursos( this.historial );
  }





  Widget _mostrarCursos( List<Curso> cursos ) {

    return ListView.builder(
      itemCount: cursos.length,
      itemBuilder: ( context , i) {

        final curso = cursos[i];

        return ListTile(
          // leading: (curso.flag != null ) ? SvgPicture.network( curso.flag, width: 45 ) : '',
          title: Text( curso.titulo ),
          subtitle: Text( curso.ramo ),
          trailing: Text( curso.profesor ),
          onTap: () {
            // print( pais );
            this.close(context, curso);
          },
        );

      },
    );

  }



}
import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/foto_service.dart';
import 'package:bonova0002/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
 
 
class Foto extends StatelessWidget {

  Usuario usuario;
  FotoService fotoService;

  @override
  Widget build(BuildContext context) {

    usuario = ModalRoute.of(context).settings.arguments;
    final authService = Provider.of<AuthService>(context);
    final yo = authService.usuario;

    return Scaffold(
      backgroundColor: BonovaColors.azulNoche[900],
      appBar: AppBar(
        title: Text(usuario.nombre, style: TextStyle( fontSize: 23, letterSpacing: -1, fontWeight: FontWeight.w400 )),
        elevation: 0,
        backgroundColor: Colors.black45,
        actions: [
          usuario == yo ?
          IconButton(
            icon: Icon(FluentIcons.edit_24_filled, size: 20,),
             padding: EdgeInsets.only(right: 10),
            onPressed: (){
              // Navigator.pushNamed(context, 'subir');
              // fotoService.subirImagen();
            }
          ) : Container()
        ],
      ),
      body: Center(
        child: Expanded( child: Hero(
          tag: 'foto',
          child: PhotoView(imageProvider: NetworkImage(usuario.foto),)))
      ),
    );
  }
}
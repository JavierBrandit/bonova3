import 'dart:io';

import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
 
 
class Foto extends StatefulWidget {

  @override
  _FotoState createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  Usuario usuario;

  bool _guardando = false;

  File foto;

  @override
  Widget build(BuildContext context) {

    usuario = ModalRoute.of(context).settings.arguments;
    final authService = Provider.of<AuthService>(context);
    final yo = authService.usuario;
    ThemeData(brightness: Brightness.dark);

    return Scaffold(
      backgroundColor: BonovaColors.azulNoche[900],
      appBar: AppBar(
        iconTheme: IconThemeData( color: Colors.white ),
        brightness: Brightness.dark,
        foregroundColor: Colors.white,
        title: Text(usuario.nombre, style: TextStyle( fontSize: 23, letterSpacing: -1, fontWeight: FontWeight.w400, color: Colors.white )),
        elevation: 0,
        backgroundColor: Colors.black45,
        actions: [
          usuario == yo ?
          IconButton(
            icon: Icon(FluentIcons.edit_24_filled, size: 20, color: Colors.white),
             padding: EdgeInsets.only(right: 10),
            onPressed: _seleccionarFoto
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

  _seleccionarFoto() async {
    _procesarImagen( ImageSource.gallery );
  }

  _tomarFoto() async {
    _procesarImagen( ImageSource.camera );
  }

  _procesarImagen( ImageSource origen ) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    foto = await ImagePicker.pickImage(
      source: origen
    );
    print('ontap');
    CircularProgressIndicator();

    if (foto != null ){
      CircularProgressIndicator();
      await authService.editarFoto(context, foto);
    }
    // Navigator.pop(context, true);
    Navigator.pushReplacementNamed(context, 'home');

    // if ( foto != null ) {
    //   producto.fotoUrl = null;
    // }

    // setState(() {});

  }
}
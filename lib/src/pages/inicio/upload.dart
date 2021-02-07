import 'dart:io';

import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:bonova0002/src/services/foto_service.dart';
// import 'package:bonova0002/src/provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class SubirFoto extends StatefulWidget {
  @override
  _SubirFotoState createState() => _SubirFotoState();
}

class _SubirFotoState extends State<SubirFoto> {
  final formKey     = GlobalKey<FormState>();
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // final productoProvider = new VideosProvider();
  FotoService fotoService;
  Usuario usuario;
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {

    // final Usuario prodData = ModalRoute.of(context).settings.arguments;
    // if ( prodData != null ) {
    //   usuario = prodData;
    // }

    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.photo_size_select_actual ),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                // _mostrarFoto(),
                // _crearNombre(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );

  }

  // Widget _crearNombre() {

  //   return TextFormField(
  //     initialValue: usuario.nombre,
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(
  //         labelText: 'Producto'
  //     ),
  //     onSaved: (value) => usuario.nombre = value,
  //     validator: (value) {
  //       if ( value.length < 3 ) {
  //         return 'Ingrese el nombre del producto';
  //       } else {
  //         return null;
  //       }
  //     },
  //   );

  // }





  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon( Icons.save ),
      onPressed: ( _guardando ) ? null : _submit,
    );
  }

  void _submit() async {



    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    setState(() {_guardando = true; });

    if ( foto != null ) {
      usuario.foto = await fotoService.subirImagen(foto);
    }



    // if ( usuario.id == null ) {
    //   productoProvider.crearProducto(usuario);
    // } else {
    //   productoProvider.editarProducto(usuario);
    // }


    setState(() {_guardando = false; });
    // mostrarSnackbar('Registro guardado');

    Navigator.pop(context);

  }


  // void mostrarSnackbar(String mensaje) {

  //   final snackbar = SnackBar(
  //     content: Text( mensaje ),
  //     duration: Duration( milliseconds: 1500),
  //   );

  //   scaffoldKey.currentState.showSnackBar(snackbar);

  // }


  // Widget _mostrarFoto() {

  //   if ( usuario.fotoUrl != null ) {

  //     return FadeInImage(
  //       image: NetworkImage( usuario.fotoUrl ),
  //       placeholder: AssetImage('assets/jar-loading.gif'),
  //       height: 300.0,
  //       fit: BoxFit.contain,
  //     );

  //   } else {

  //     return Image(

  //       image: AssetImage( foto?.path ?? 'assets/no-image.png'),
  //       height: 300.0,
  //       fit: BoxFit.cover,

  //     );

  //   }

  // }


  _seleccionarFoto() async {

    _procesarImagen( ImageSource.gallery );

  }


  _tomarFoto() async {

    _procesarImagen( ImageSource.camera );

  }

  _procesarImagen( ImageSource origen ) async {

    // foto = await ImagePicker().getImage(source: origen)
    foto = await ImagePicker.pickImage(
        source: origen
    );

    // if ( foto != null ) {
    //   usuario.foto = null;
    // }

    setState(() {});

  }


}

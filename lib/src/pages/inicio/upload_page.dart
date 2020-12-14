// import 'dart:io';

// import 'package:fluentui_icons/fluentui_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// //import 'package:formvalidation/src/utils/utils.dart' as utils;


// class UploadPage extends StatefulWidget {

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {

//   final formKey     = GlobalKey<FormState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   //final videosProvider = new VideosProvider();

//   //VideoModelo videoModelo = new VideoModelo();
//   bool _guardando = false;
//   File video;

//   @override
//   Widget build(BuildContext context) {

//     //final VideoModelo prodData = ModalRoute.of(context).settings.arguments;
//     //if ( prodData != null ) {
//     //  videoModelo = prodData;
//    // }

//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: Text('Subir Video'),
//       ),
//       floatingActionButton: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: FloatingActionButton(child: Icon(FluentSystemIcons.ic_fluent_video_filled), onPressed: _tomarVideo,),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: FloatingActionButton(child: Icon(FluentSystemIcons.ic_fluent_movies_and_tv_filled), onPressed: _seleccionarVideo,),
//             )
//           ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(15.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: <Widget>[
//                 SizedBox(height: 20.0,),
//                 _mostrarFoto(),
//                 SizedBox(height: 20.0,),
//                 _crearNombre(),
//                 SizedBox(height: 20.0,),
//                 //_crearFoto(),
//                 SizedBox(height: 20.0,),
//                 _crearBoton()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );

//   }

//   Widget _crearNombre() {

//     return TextFormField(
//       initialValue: videoModelo.tituloVideo,
//       textCapitalization: TextCapitalization.sentences,
//       decoration: InputDecoration(
//           labelText: 'Nombre Video'
//       ),
//       onSaved: (value) => videoModelo.tituloVideo = value,
//       validator: (value) {
//         if ( value.length < 3 ) {
//           return 'Ingrese el nombre del video';
//         } else {
//           return null;
//         }
//       },
//     );

//   }

//   Widget _crearFoto() {

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         RaisedButton.icon(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0)
//           ),
//           label: Text('Tomar Foto'),
//           icon: Icon( FluentSystemIcons.ic_fluent_camera_add_filled ),
//           onPressed: () => _tomarFoto(),
//         ),

//         RaisedButton.icon(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0)
//           ),
//           label: Text('Seleccionar'),
//           icon: Icon( FluentSystemIcons.ic_fluent_image_add_filled ),
//           onPressed: ( ) => _seleccionarFoto(),
//         ),


//       ],
//     );

//   }

//   Widget _crearBoton() {
//     return RaisedButton.icon(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0)
//       ),
//       color: Colors.teal,
//       textColor: Colors.white,
//       label: Text('Guardar'),
//       icon: Icon( Icons.save ),
//       onPressed: ( _guardando ) ? null : _submit,
//     );
//   }

//   Widget _mostrarFoto() {

//     if ( videoModelo.videoUrl != null ) {

//       return FadeInImage(
//         image: NetworkImage(videoModelo.fotoUrl),
//         placeholder: AssetImage('assets/jar-loading.gif'),
//         height: 200.0,
//         fit: BoxFit.contain,
//       );

//     } else {

//       return Image(

//         image: AssetImage('assets/no-image.png'),
//         height: 200.0,
//         fit: BoxFit.cover,

//       );

//     }

//   }

//   void _submit() async {



//     if ( !formKey.currentState.validate() ) return;

//     formKey.currentState.save();

//     setState(() {_guardando = true; });

//     if ( video != null ) {
//       //videoModelo.videoUrl = await videosProvider.subirVideo(video);
//       //videoModelo.fotoUrl = await videosProvider.subirFoto(video)
//     }



//     if ( videoModelo.id == null ) {
//       //videosProvider.crearProducto(videoModelo);
//     } else {
//       //videosProvider.editarProducto(videoModelo);
//     }


//     // setState(() {_guardando = false; });
//     mostrarSnackbar('Registro guardado');

//     Navigator.pop(context);

//   }

//   void mostrarSnackbar(String mensaje) {

//     final snackbar = SnackBar(
//       content: Text( mensaje ),
//       duration: Duration( milliseconds: 1500),
//     );

//     scaffoldKey.currentState.showSnackBar(snackbar);

//   }






//   _seleccionarFoto() async {

//     _procesarImagen( ImageSource.gallery );

//   }
//   _tomarFoto() async {

//     _procesarImagen( ImageSource.camera );

//   }
//   _procesarImagen( ImageSource origen ) async {

//     video = await ImagePicker.pickImage(
//         source: origen
//     );

//     if ( video != null ) {
//       videoModelo.videoUrl = null;
//     }

//     setState(() {});

//   }


//   _seleccionarVideo() async {

//     _procesarVideo( ImageSource.gallery );

//   }
//   _tomarVideo() async {

//     _procesarVideo( ImageSource.camera );

//   }
//   _procesarVideo( ImageSource origen ) async {

//     video = await ImagePicker.pickVideo(
//         source: origen
//     );

//     if ( video != null ) {
//       videoModelo.videoUrl = null;
//     }

//     setState(() {});

//   }


// }




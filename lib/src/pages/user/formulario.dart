import 'dart:io';

import 'package:bonova0002/src/helpers/mostrar_alerta.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Formulario extends StatefulWidget {

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final cursoCtrl = TextEditingController();
  final colegioCtrl = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final auth = AuthService();
  File foto;
  GlobalKey<FormState> keyForm = GlobalKey();

  bool _subiendo = false;

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Editar Información', style: TextStyle( fontSize: 22, letterSpacing: -0.7, fontWeight: FontWeight.w400 )),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  nombre('Foto perfil'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'foto',
                        child: GestureDetector(
                          child: _subiendo
                          ? CircleAvatar( radius: 65, backgroundColor: Colors.teal,)
                          : CircleAvatar(backgroundImage: NetworkImage(usuario.foto), radius: 65),
                        onTap: _seleccionarFoto,
                      )),
                    ],
                  ),
                  // nombre('Nombre'),
                  // input(usuario.nombre, FluentIcons.text_font_16_regular, TextInputType.name, nameCtrl),
                  // nombre('Cumpleaños'),
                  // input('', FluentIcons.food_cake_20_regular, TextInputType.datetime, TextEditingController()),
                  // nombre('Curso'),
                  // input('', FluentIcons.backpack_20_regular, TextInputType.number, cursoCtrl),
                  // nombre('Colegio'),
                  // input('', FluentIcons.hat_graduation_20_regular, TextInputType.name, colegioCtrl),

                  formulario(usuario),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: RaisedButton(
                      child: Text('subir'),
                      shape: StadiumBorder(),
                      onPressed: () async {

                        if (keyForm.currentState.validate()) {
                          
                          if (nameCtrl.text != ''.trim() && nameCtrl.text != null ){
                            print("Nombre ${nameCtrl.text}");
                            await authService.editarNombre(context, nameCtrl.text);               
                          }
                          if (colegioCtrl.text != ''.trim() && colegioCtrl.text != null ){
                            print("Colegio ${colegioCtrl.text}");
                            await authService.editarColegio(context, colegioCtrl.text);               
                          }
                          if (cursoCtrl.text != ''.trim() && cursoCtrl.text != null ){
                            print("Curso ${cursoCtrl.text}");
                            await authService.editarCurso(context, cursoCtrl.text);               
                          }
                          Navigator.pushReplacementNamed(context, 'home');
                          // // print("Telefono ${mobileCtrl.text}");
                          // print("Correo ${emailCtrl.text}");
                          // await auth.editarColegio(context, colegioCtrl.text);               
                          // await auth.editarCurso(context, cursoCtrl.text);   
                          // // authService.autenticando = true;          
                          // // keyForm.currentState.reset();
                        }
                      }
                    ),
                  )

        ])))
    ]));
  }

  formulario(Usuario usuario){
    return Column(
      children: [
        Form(
          key: keyForm,
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            nombre('Nombre'),
            input(usuario.nombre, FluentIcons.text_font_16_regular, TextInputType.name, nameCtrl),
            nombre('Cumpleaños'),
            input(usuario.antiguedad.timeZoneName, FluentIcons.food_cake_20_regular, TextInputType.datetime, TextEditingController()),
            nombre('Curso'),
            input(usuario.curso, FluentIcons.backpack_20_regular, TextInputType.number, cursoCtrl),
            nombre('Colegio'),
            input(usuario.colegio, FluentIcons.hat_graduation_20_regular, TextInputType.name, colegioCtrl),
          ])
        ),
      ],
    );
  }

  nombre(String nombre){
    return Padding(
      padding: EdgeInsets.only( top: 30, bottom: 17),
      child: Text(
        nombre,
        style: TextStyle( fontSize: 14, letterSpacing: -.3, fontWeight: FontWeight.w500),
      ),
    );
  }

  input( String hint, IconData icon, TextInputType keyboardType, TextEditingController ctrl, ){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
     padding: EdgeInsets.symmetric(horizontal: 10),
     decoration: BoxDecoration(
      //  color: Colors.white, 
       borderRadius: BorderRadius.circular(30),
       border: Border.all(width: .6, color: Colors.grey[600] )
     ),
     child: TextFormField(
       controller: ctrl,
       keyboardType: keyboardType,
       textAlignVertical: TextAlignVertical.center,
       decoration: InputDecoration(
         prefixIcon: Icon( icon, size: 18 ),
         contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
         focusedBorder: InputBorder.none,
         border: InputBorder.none,
         hintText: hint,
         hintStyle: TextStyle( fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: -.2)
    )));
  }

  _seleccionarFoto() async {
    _procesarImagen( ImageSource.gallery );
  }

  _tomarFoto() async {
    _procesarImagen( ImageSource.camera );
  }

  _procesarImagen( ImageSource origen ) async {

    _subiendo = true;
    final authService = Provider.of<AuthService>(context, listen: false);
    foto = await ImagePicker.pickImage(
      source: origen
    );
    print('ontap');

    if (foto != null ){
      await authService.editarFoto(context, foto);
    }
    // Navigator.pop(context, true);
    // Navigator.pushReplacementNamed(context, 'home');

    // if ( foto != null ) {
    //   producto.fotoUrl = null;
    // }

    _subiendo = false;
    setState(() {});

  }
}
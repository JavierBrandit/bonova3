import 'package:bonova0002/src/helpers/mostrar_alerta.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Formulario extends StatelessWidget {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final cursoCtrl = TextEditingController();
  final colegioCtrl = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();
  AuthService auth = AuthService();

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
                        child: CircleAvatar(backgroundImage: NetworkImage(usuario.foto), radius: 65)),
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

                  formulario(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: RaisedButton(
                      child: Text('subir'),
                      shape: StadiumBorder(),
                      onPressed: () async {
                        if (keyForm.currentState.validate()) {
                          print("Nombre ${nameCtrl.text}");
                          // print("Telefono ${mobileCtrl.text}");
                          print("Correo ${emailCtrl.text}");
                          final editOk = await auth.editarInfo(context, nameCtrl.text, emailCtrl.text.trim(), passCtrl.text.trim(), '', colegioCtrl.text, cursoCtrl.text, '', 'descripcion', 'celular');                    
                          // keyForm.currentState.reset();
                          if ( editOk ) {
                            Navigator.pushReplacementNamed(context, 'user');
                          } else {
                            mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
                          }
                        }
                      }
                    ),
                  )

        ])))
    ]));
  }

  formulario(){
    return Column(
      children: [
        Form(
          key: keyForm,
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            nombre('Nombre'),
                      input('nombre', FluentIcons.text_font_16_regular, TextInputType.name, nameCtrl),
                      nombre('Cumpleaños'),
                      input('', FluentIcons.food_cake_20_regular, TextInputType.datetime, TextEditingController()),
                      nombre('Curso'),
                      input('', FluentIcons.backpack_20_regular, TextInputType.number, cursoCtrl),
                      nombre('Colegio'),
                      input('', FluentIcons.hat_graduation_20_regular, TextInputType.name, colegioCtrl),
          ])
        ),
      ],
    );
  }

  nombre(String nombre){
    return Padding(
      padding: EdgeInsets.only( top: 30, bottom: 12),
      child: Text(
        nombre,
        style: TextStyle( fontSize: 12, letterSpacing: -.3, fontWeight: FontWeight.w500),
      ),
    );
  }

  input( String nombre, IconData icon, TextInputType keyboardType, TextEditingController ctrl ){
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
         hintText: nombre,
         hintStyle: TextStyle( fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: -.2)
    )));
  }


}
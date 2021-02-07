import 'package:bonova0002/src/helpers/mostrar_alerta.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/src/widgets/btn_azul.dart';
import 'package:bonova0002/src/widgets/custom_input.dart';
import 'package:bonova0002/src/widgets/labels_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.symmetric( vertical: 20 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                //Logo(titulo: 'Registro',),
                SizedBox( height: 10),
                Image.asset('assets/bv_login.png', height: 160,),

                Form(),

                Labels(titulo: '¿Ya tienes una cuenta?', subtitulo: 'Ingresar', ruta: 'login' ),

                Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w500, fontFamily: 'Montserrat', fontSize: 11, color: Colors.grey[700]) ),
                
              ],
            ),
          ),
      ),
      ),
    );
  }
}

class Form extends StatefulWidget {
  @override
  FormState createState() => FormState();
}

class FormState extends State<Form> {

  final nameCtrl  = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
       child: Column( children: <Widget>[
        
        CustomInput(
          icon: Icons.person,
          placeholder: 'Nombre',
          keyboardType: TextInputType.text,
          textController: nameCtrl,
        ),
        CustomInput(
          icon: Icons.mail_outline,
          placeholder: 'Correo',
          keyboardType: TextInputType.emailAddress,
          textController: emailCtrl,
        ),
        CustomInput(
          icon: Icons.lock_outline,
          placeholder: 'Contraseña',
          isPassword: true,
          textController: passCtrl,
        ),

         BtnAzul(
           txt:'Crear Cuenta', 
           callBack: authService.autenticando ? null : () async {
             //FocusScope.of(context).unfocus(); 
              
              final registroOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim()); 
              //trim() para que no se pasen espacios o tabs
              
              if ( registroOk == true ) {
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                mostrarAlerta(context, 'Registro incorrecto', registroOk);
              }
           }
         ),
       ],),
    );
  }
}





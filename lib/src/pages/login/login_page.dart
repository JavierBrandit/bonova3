// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:bonova0002/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonova0002/src/helpers/mostrar_alerta.dart';
import 'package:bonova0002/src/widgets/btn_azul.dart';
import 'package:bonova0002/src/widgets/custom_input.dart';
import 'package:bonova0002/src/widgets/labels_widget.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkTheme ? BonovaColors.azulNoche[800] : Colors.grey[100],
      body: SafeArea( 
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric( vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Logo(titulo: 'Messenger'),
                  SizedBox(height: 10),
                  Image.asset('assets/bv_login.png', height: 140,),
                  Form(),
                  Labels(titulo: '¿Aun no tienes una cuenta?', subtitulo: 'Registrate Ahora', ruta: 'register' ),
                  Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w500, fontFamily: 'Montserrat', fontSize: 11, color: Colors.grey[700])),
                ],
              ),
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

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      // height: 280,
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(horizontal: 50),
       child: Column( children: <Widget>[
        
        CustomInput(
          icon: FluentIcons.mail_16_regular,
          placeholder: 'Correo',
          keyboardType: TextInputType.emailAddress,
          textController: emailCtrl,
        ),
        CustomInput(
          icon: FluentIcons.lock_closed_12_regular,
          placeholder: 'Contraseña',
          isPassword: true,
          textController: passCtrl,
        ),


         BtnAzul(
           txt:'Continuar', 
           callBack: authService.autenticando ? null : () async {
              
              FocusScope.of(context).unfocus(); 
              
              final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim()); //trim() para que no se pasen espacios o tabs
              
              if ( loginOk ) {
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
              }
           }
         ),
       ],),
    );
  }
}





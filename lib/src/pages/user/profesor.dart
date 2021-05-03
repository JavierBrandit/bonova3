import 'package:bonova0002/src/helpers/mostrar_alerta.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class Profesor extends StatefulWidget {
  @override
  _ProfesorState createState() => _ProfesorState();
}

class _ProfesorState extends State<Profesor> {

  AuthService auth;
  SocketService socketService;
  Usuario usuario;

  @override
  void initState() { 
    super.initState();
    this.socketService = Provider.of<SocketService>(context, listen: false );
    this.socketService.socket.on('editar-usuario', (payload){
      this.usuario = Usuario.fromJson(payload);
      print('print: ${usuario.profesor}');
      auth.setUsuario(usuario);
      Navigator.of(context).pushNamed('home');
      // setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {

    auth = Provider.of<AuthService>(context);
    var usuario = auth.usuario;
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profesor', style: TextStyle( fontSize: 22, letterSpacing: -0.7, fontWeight: FontWeight.w400 )),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
        
        SliverToBoxAdapter(
          child: Column( children: [

            SizedBox( height: 30),
            Opacity(
              opacity: isDarkTheme? .9 : 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Image.asset(
                  'assets/profesor.png',        
                ),
              ),
            ),

            SizedBox( height: 15),

                Container(
                  width: MediaQuery.of(context).size.width * .88,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20 ),
                  child: Text( '¡Enseña lo que más sabes hacer!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, letterSpacing: -.5, wordSpacing: 2), 
                   ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .7,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5 ),
                  child: Text( 'Conviertete en un profe Bonova',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, wordSpacing: .5), 
                   ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * .88,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: Text( 'Lorem Ipsum es simplemente texto de relleno de la industria de la impresión y la composición tipográfica.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: -.1, wordSpacing: .5, height: 1.9), 
                   ),
                ),

            SizedBox( height: 60),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDarkTheme? Colors.blueGrey[900].withOpacity(.9) : Colors.blueGrey[100].withOpacity(.6),
              
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(auth.getUsuario().profesor?? usuario.profesor ? 'Profesor' : 'Alumno', style: TextStyle( fontSize: 17.5, letterSpacing: -0.4, fontWeight: FontWeight.w500 )),
                  FlutterSwitch(
                    value: auth.getUsuario().profesor?? usuario.profesor,
                    activeColor: isDarkTheme? Colors.teal[300] : Colors.teal,
                    activeToggleColor: isDarkTheme? Colors.blueGrey[50] : null,
                    onToggle: (val) {
                      print(val);
                      // val == true
                      // ? mostrarAlerta(context, 'Estas a Punto de ser Profesor', 'Felicitaciones') //quiere ser profesor
                      // : mostrarAlerta(context, '¿Estas seguro?', 'No te vayas :('); //quiere dejar de ser profesor
                      
                      final socketService = Provider.of<SocketService>(context, listen: false );

                      socketService.emit('editar-usuario', {
                        'profesor': val
                      });
                      // setState(() {});
                      // await authService.editarProfesor(context, val);
                      // Navigator.pushReplacementNamed(context, 'home');

                  }),
                ],
              ),
            )
          ]),
        ),
        ])
    );
    
  }
}
import 'dart:io';

import 'package:bonova0002/src/models/mensajes_response.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/chat_service.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/src/widgets/chat_message.dart';
import 'package:bonova0002/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  
  ChatService chatService;
  SocketService socketService;
  AuthService authService;
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false );
    this.socketService = Provider.of<SocketService>(context, listen: false );
    this.authService = Provider.of<AuthService>(context, listen: false );
    this.socketService.socket.on('mensaje-personal', _escucharMensaje );
    _cargarHistorial( this.chatService.usuarioPara.uid );
  }

  void _cargarHistorial( String usuarioID) async {

    List<Mensaje> chat = await this.chatService.getChat(usuarioID);

    final history = chat.map((m) => ChatMessage(
      texto: m.mensaje,
      uid: m.de,
      animationController: new AnimationController(vsync: this, duration: Duration(milliseconds: 0))..forward(),
    ));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje( dynamic payload ) {
    
    ChatMessage message = new ChatMessage(
      texto: payload['mensaje'],
      uid: payload['de'],
      animationController: AnimationController(vsync: this, duration: Duration( milliseconds: 300 ))
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
      backgroundColor: isDarkTheme? BonovaColors.azulNoche[800] : Colors.blueGrey[50],
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0,
        title: Text(usuarioPara.nombre, style: TextStyle( fontSize: 23, letterSpacing: -1, fontWeight: FontWeight.w400 ),),
        actions: <Widget>[
            _itemUsuario(usuarioPara),
            IconButton( padding: EdgeInsets.zero, icon: Icon(Icons.more_vert), onPressed: (){},),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: _messages.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
                ) 
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child:Container( 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                      color: isDarkTheme ? Colors.blueGrey[800] : Colors.white
                        ),
                  child: _inputChat(isDarkTheme),
                ),
              ),
          ],
        ),
      ),
    );
  }


  Widget _inputChat(bool dark) {
    return SafeArea(
      child: Container(
        // margin: EdgeInsets.all( 18 ),
        padding: EdgeInsets.only(left: 22, right: 2),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSumit,
                onChanged: ( texto ){
                  setState(() {
                     if ( texto.trim().length > 0 ) {
                       _estaEscribiendo = true;
                     } else {
                       _estaEscribiendo = false;
                     }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'escribe un mensaje...',
                  hintStyle: TextStyle(fontSize: 13,  )
                ),
                focusNode: _focusNode,
              )
            ),

            IconTheme(
              data: IconThemeData( color:  dark? Colors.tealAccent[400] : Colors.tealAccent[700]),
              child: IconButton(
                padding: EdgeInsets.zero,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon( FluentIcons.send_20_filled ),
                onPressed: _estaEscribiendo
                    ? () => _handleSumit( _textController.text.trim() )
                    : null,
              ),
            ),
          ],
        ),
      )
    );
  }

  _itemUsuario( Usuario u ) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Navigator.pushNamed( context, 'perfil', arguments: u ),
      child: Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // SizedBox(height: 8),
            CircleAvatar(
              radius: 23,
              backgroundColor: isDarkTheme ? Colors.teal[800] : Colors.tealAccent[100],
              child: Text( u.nombre.substring(0,2), style: TextStyle( color: isDarkTheme ? Colors.white : Colors.teal[900] ))
            ),
            // SizedBox(height: 8),

          ],
        ),
      ),
    );
  }

  _handleSumit( String texto ) {

    if ( texto.length == 0 ) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: authService.usuario.uid, 
      texto: texto, 
      animationController: AnimationController( vsync: this, duration: Duration(milliseconds: 200))
      );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward(); 

    setState(() { _estaEscribiendo = false; });

    this.socketService.emit('mensaje-personal', {
      'de': this.authService.usuario.uid,
      'para': this.chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() { 
    for( ChatMessage message in _messages ) {
      message.animationController.dispose(); 
    }
    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }


  
}

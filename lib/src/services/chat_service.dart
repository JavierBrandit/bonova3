
import 'package:bonova0002/src/global/environment.dart';
import 'package:bonova0002/src/models/mensajes_response.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'auth_services.dart';

class ChatService with ChangeNotifier {

  Usuario usuarioPara; //Hacia quien va?

  Future<List<Mensaje>> getChat( String usuarioID ) async {

    final resp = await http.get('${Environment.apiUrl}/mensajes/$usuarioID',
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      }
    );
    
    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }


}
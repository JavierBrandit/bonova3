

import 'dart:async';
import 'dart:convert';

import 'package:bonova0002/src/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:bonova0002/src/global/environment.dart';
import 'package:bonova0002/src/models/historial.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:video_player/video_player.dart';

class HistorialService {

  // Historial historial;
  // VideoPlayerController playerController;
  // final _storage = new FlutterSecureStorage();
  // final auth = AuthService();

  // Stream<Duration> get xx async* {
  // playerController.position.asStream();
  // } 

  // Stream<Historial> get agregarHistorial async* {
    
  //   final data = {
  //     'curso': historial.curso,
  //     'guardado': historial.guardado,
  //     'largo': historial.largo,
  //     'progeso': historial.progreso,
  //     'prefs': historial.prefs
  //   };

  //   final token = await this._storage.read(key: 'token');

  
  //   final resp = await http.put('${ Environment.apiUrl }/usuarios/historial/${ historial.curso }',
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'x-token': token
  //     }
  //   );

  //   if ( resp.statusCode == 200 ) {
  //     final editResponse = historialesFromJson(resp.body).historial; //jsonDecode(resp.body);
  //     print(editResponse.toString());  
  //     yield editResponse;
  //   } else {
  //     final respBody = jsonDecode(resp.body);
  //     yield respBody['msg'];
  //   }
  // }

  // StreamController<double> _streamController = new StreamController<double>();
  // Stream<double> get nuevoStream => _streamController.stream;

  // HistorialService(){
  //   xx.listen(
  //     (position) {
  //     _streamController.add( position.inSeconds.toDouble() );
  //     auth.agregarHistorial(historial);
  //   }
  //   );

  //   agregarHistorial.listen(
  //     (historial) {
  //       _streamController.add( historial.progreso );
  //     }
  //   );
  // }

  // dispose(){
  //   _streamController.close();
  // }




}
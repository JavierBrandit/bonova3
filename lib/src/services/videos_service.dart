import 'package:bonova0002/src/global/environment.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/curso_response.dart';
import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:bonova0002/src/models/video_response.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'auth_services.dart';


class VideoService with ChangeNotifier {

  Curso _curso;
  Video _video;
  int _indexVideo = 0;

    Curso get curso => _curso;
    set curso(Curso curso) {
      _curso = curso;
    }
    Video get video => _video;
    set video(Video video) {
      _video = video;
      notifyListeners();
    }
    int get indexVideo => _indexVideo;
    set indexVideo(int indexVideo) {
      _indexVideo = indexVideo;
      notifyListeners();
    }

  Future<List<Video>> getVideos() async {
    
    try {

      final resp = await http.get('${ Environment.apiUrl }/video',
        headers: {
          'Content-Type': 'application/json',
          'x-token' : await AuthService.getToken()
        }
      );

      final videosResponse = videoResponseFromJson( resp.body );
      return videosResponse.videos;
    
    } catch (e) {
      return [];
    }
   
  }

}

class CursoService with ChangeNotifier {

  String ramo = '';
  String nivel = '';

  Future<List<Curso>> getCursos( String ramox, String nivelx ) async {
    
    try {

      final resp = await http.get('${ Environment.apiUrl }/curso/$ramox/$nivelx',
        headers: {
          'Content-Type': 'application/json',
          'x-token' : await AuthService.getToken()
        }
      );

      final cursosResponse = cursosResponseFromJson( resp.body );
      return cursosResponse.cursos;
    
    } catch (e) {
      print(e);
      return [];
    }
   
  }

}
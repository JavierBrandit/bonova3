import 'dart:convert';
import 'package:bonova0002/src/models/video_modelo.dart';

Curso cursoFromJson(String str) => Curso.fromJson(json.decode(str));
String cursoToJson(Curso data) => json.encode(data.toJson());

class Curso {
    Curso({
        this.guardado,
        this.videos,
        this.comentario,
        this.titulo,
        this.ramo,
        this.nivel,
        this.portada,
        this.profesor,
        this.rate,
        this.descripcion,
        this.thumbnail,
        this.views,
        this.likes,
        this.compartido,
        this.precio,
        this.createdAt,
        this.updatedAt,
    });

    bool guardado;
    List<Video> videos;
    List<dynamic> comentario;
    String titulo;
    String ramo;
    String nivel;
    String portada;
    String profesor;
    int rate;
    String descripcion;
    String thumbnail;
    int views;
    int likes;
    int compartido;
    String precio;
    DateTime createdAt;
    DateTime updatedAt;

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        guardado: json["guardado"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        comentario: List<dynamic>.from(json["comentario"].map((x) => x)),
        titulo: json["titulo"],
        ramo: json["ramo"],
        nivel: json["nivel"],
        portada: json["portada"],
        profesor: json["profesor"],
        rate: json["rate"],
        descripcion: json["descripcion"],
        thumbnail: json["thumbnail"],
        views: json["views"],
        likes: json["likes"],
        compartido: json["compartido"],
        precio: json["precio"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "guardado": guardado,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "comentario": List<dynamic>.from(comentario.map((x) => x)),
        "titulo": titulo,
        "ramo": ramo,
        "nivel": nivel,
        "portada": portada,
        "profesor": profesor,
        "rate": rate,
        "descripcion": descripcion,
        "thumbnail": thumbnail,
        "views": views,
        "likes": likes,
        "compartido": compartido,
        "precio": precio,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
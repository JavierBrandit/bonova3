import 'package:bonova0002/src/models/video_modelo.dart';

class Curso {
    Curso({
        this.titulo,
        this.ramo,
        this.nivel,
        this.videos,
        this.createdAt,
        this.updatedAt,
        this.capitulo,
        this.guardado,
        this.portada,
        this.profesor,
        this.progress,
        this.rate,
    });

    String titulo;
    String ramo;
    String nivel;
    List<Video> videos;
    DateTime createdAt;
    DateTime updatedAt;
    int capitulo;
    bool guardado;
    String portada;
    String profesor;
    double progress;
    double rate;

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        titulo: json["titulo"],
        ramo: json["ramo"],
        nivel: json["nivel"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        capitulo: json["capitulo"],
        guardado: json["guardado"],
        portada: json["portada"],
        profesor: json["profesor"],
        progress: json["progress"].toDouble(),
        rate: json["rate"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "ramo": ramo,
        "nivel": nivel,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "capitulo": capitulo,
        "guardado": guardado,
        "portada": portada,
        "profesor": profesor,
        "progress": progress,
        "rate": rate,
    };
}
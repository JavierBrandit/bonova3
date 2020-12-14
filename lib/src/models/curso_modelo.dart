import 'package:bonova0002/src/models/video_modelo.dart';


class Curso {
    Curso({
        this.titulo,
        this.ramo,
        this.nivel,
        this.videos,
        this.createdAt,
        this.updatedAt,
    });

    String titulo;
    String ramo;
    String nivel;
    List<Video> videos;
    DateTime createdAt;
    DateTime updatedAt;

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        titulo: json["titulo"],
        ramo: json["ramo"],
        nivel: json["nivel"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "ramo": ramo,
        "nivel": nivel,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
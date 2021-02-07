class Video {
    Video({
        this.comentario,
        this.apunte,
        this.titulo,
        this.descripcion,
        this.path,
        this.tituloMod,
        this.views,
        this.likes,
        this.compartido,
        this.adjunto,
        this.createdAt,
        this.updatedAt,
    });

    List<dynamic> comentario;
    List<dynamic> apunte;
    String titulo;
    String descripcion;
    String path;
    String tituloMod;
    int views;
    int likes;
    int compartido;
    String adjunto;
    DateTime createdAt;
    DateTime updatedAt;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        comentario: List<dynamic>.from(json["comentario"].map((x) => x)),
        apunte: List<dynamic>.from(json["apunte"].map((x) => x)),
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        path: json["path"],
        tituloMod: json["tituloMod"],
        views: json["views"],
        likes: json["likes"],
        compartido: json["compartido"],
        adjunto: json["adjunto"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "comentario": List<dynamic>.from(comentario.map((x) => x)),
        "apunte": List<dynamic>.from(apunte.map((x) => x)),
        "titulo": titulo,
        "descripcion": descripcion,
        "path": path,
        "tituloMod": tituloMod,
        "views": views,
        "likes": likes,
        "compartido": compartido,
        "adjunto": adjunto,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
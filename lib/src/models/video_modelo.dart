

class Video {
    Video({
        this.titulo,
        this.descripcion,
        this.path,
        this.curso,
        this.size,
    });

    String titulo;
    String descripcion;
    String path;
    String curso;
    int size;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        path: json["path"],
        curso: json["curso"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "descripcion": descripcion,
        "path": path,
        "curso": curso,
        "size": size,
    };
}

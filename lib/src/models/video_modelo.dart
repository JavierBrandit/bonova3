class Video {
    Video({
        this.titulo,
        this.descripcion,
        this.path,
        this.curso,
        this.size,
        this.numMod,
        this.tituloMod,
    });

    String titulo;
    String descripcion;
    String path;
    String curso;
    dynamic size;
    int numMod;
    String tituloMod;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        path: json["path"],
        curso: json["curso"],
        size: json["size"],
        numMod: json["numMod"],
        tituloMod: json["tituloMod"],
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "descripcion": descripcion,
        "path": path,
        "curso": curso,
        "size": size,
        "numMod": numMod,
        "tituloMod": tituloMod,
    };
}
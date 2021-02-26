import 'dart:convert';
import 'usuario.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.ok,
        this.usuario,
        this.token,
    });

    bool ok;
    Usuario usuario;
    String token;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
    };
}

EditResponse editResponseFromJson(String str) => EditResponse.fromJson(json.decode(str));

String editResponseToJson(EditResponse data) => json.encode(data.toJson());

class EditResponse {
    EditResponse({
        this.ok,
        this.usuario,
    });

    bool ok;
    Usuario usuario;

    factory EditResponse.fromJson(Map<String, dynamic> json) => EditResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
    };
}


import 'dart:convert';

import 'package:bonova0002/src/models/video_modelo.dart';

VideoResponse videoResponseFromJson(String str) => VideoResponse.fromJson(json.decode(str));

String videoResponseToJson(VideoResponse data) => json.encode(data.toJson());

class VideoResponse {
    VideoResponse({
        this.ok,
        this.videos,
    });

    bool ok;
    List<Video> videos;

    factory VideoResponse.fromJson(Map<String, dynamic> json) => VideoResponse(
        ok: json["ok"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    };
}
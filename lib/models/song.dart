// ignore_for_file: constant_identifier_names

class Song {
    String id;
    String name;
    String year;
    dynamic releaseDate;
    int duration;
    String url;
    Album album;
    Artists artists;
    String language;
    List<DownloadUrl> image;
    List<DownloadUrl> downloadUrl;

    Song({
        required this.id,
        required this.name,
        required this.year,
        required this.releaseDate,
        required this.duration,
        required this.url,
        required this.album,
        required this.artists,
        required this.language,
        required this.image,
        required this.downloadUrl,
    });

    factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        year: json["year"] ?? "",
        releaseDate: json["releaseDate"] ?? "",
        duration: json["duration"] ?? 0,
        url: json["url"] ?? "",
        album: Album.fromJson(json["album"]),
        language: json["language"] ?? "",
        artists: Artists.fromJson(json["artists"]),
        image: List<DownloadUrl>.from(json["image"].map((x) => DownloadUrl.fromJson(x))),
        downloadUrl: List<DownloadUrl>.from(json["downloadUrl"].map((x) => DownloadUrl.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year": year,
        "releaseDate": releaseDate,
        "duration": duration,
        "url": url,
        "album": album.toJson(),
        "language": language,
        "artists": artists.toJson(),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "downloadUrl": List<dynamic>.from(downloadUrl.map((x) => x.toJson())),
    };
}

class Album {
    String id;
    String name;
    String url;

    Album({
        required this.id,
        required this.name,
        required this.url,
    });

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        url: json["url"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
    };
}

class Artists {
    List<All> primary;
    List<All> featured;
    List<All> all;

    Artists({
        required this.primary,
        required this.featured,
        required this.all,
    });

    factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        primary: List<All>.from(json["primary"].map((x) => All.fromJson(x))),
        featured: List<All>.from(json["featured"].map((x) => All.fromJson(x))),
        all: List<All>.from(json["all"].map((x) => All.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "primary": List<dynamic>.from(primary.map((x) => x.toJson())),
        "featured": List<dynamic>.from(featured.map((x) => x.toJson())),
        "all": List<dynamic>.from(all.map((x) => x.toJson())),
    };
}

class All {
    String id;
    String name;
    Role role;
    List<DownloadUrl> image;
    AllType type;
    String url;

    All({
        required this.id,
        required this.name,
        required this.role,
        required this.image,
        required this.type,
        required this.url,
    });

    factory All.fromJson(Map<String, dynamic> json) => All(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        role: roleValues.map[json["role"]]!,
        image: List<DownloadUrl>.from(json["image"].map((x) => DownloadUrl.fromJson(x))),
        type: allTypeValues.map[json["type"]]!,
        url: json["url"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": roleValues.reverse[role],
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "type": allTypeValues.reverse[type],
        "url": url,
    };
}

class DownloadUrl {
    Quality quality;
    String url;

    DownloadUrl({
        required this.quality,
        required this.url,
    });

    factory DownloadUrl.fromJson(Map<String, dynamic> json) => DownloadUrl(
        quality: qualityValues.map[json["quality"]]!,
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "quality": qualityValues.reverse[quality],
        "url": url,
    };
}

enum Quality {
    THE_12_KBPS,
    THE_150_X150,
    THE_160_KBPS,
    THE_320_KBPS,
    THE_48_KBPS,
    THE_500_X500,
    THE_50_X50,
    THE_96_KBPS
}

final qualityValues = EnumValues({
    "12kbps": Quality.THE_12_KBPS,
    "150x150": Quality.THE_150_X150,
    "160kbps": Quality.THE_160_KBPS,
    "320kbps": Quality.THE_320_KBPS,
    "48kbps": Quality.THE_48_KBPS,
    "500x500": Quality.THE_500_X500,
    "50x50": Quality.THE_50_X50,
    "96kbps": Quality.THE_96_KBPS
});

enum Role {
    FEATURED_ARTISTS,
    LYRICIST,
    MUSIC,
    PRIMARY_ARTISTS,
    SINGER,
    STARRING
}

final roleValues = EnumValues({
    "featured_artists": Role.FEATURED_ARTISTS,
    "lyricist": Role.LYRICIST,
    "music": Role.MUSIC,
    "primary_artists": Role.PRIMARY_ARTISTS,
    "singer": Role.SINGER,
    "starring": Role.STARRING
});

enum AllType {
    ARTIST
}

final allTypeValues = EnumValues({
    "artist": AllType.ARTIST
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

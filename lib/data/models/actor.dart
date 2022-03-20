
class Actor {
  Actor({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );
}

class Cast {
  Cast({
    required this.name,
    required this.originalName,
    this.profilePath,
  });

  String name;
  String originalName;
  String? profilePath;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        name: json["name"],
        originalName: json["original_name"],
        profilePath: json["profile_path"],
      );


}

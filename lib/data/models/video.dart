class Video {
  Video({
    required this.key,
  });

  String key;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
      };
}

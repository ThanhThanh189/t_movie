import 'package:intl/intl.dart';

const String tableFavoriteFilm = 'tableFilm';
const String tableCartFilm = 'tableCartFilm';

class FilmDataFields {
  static final List<String> values = [
    adult,
    backdropPath,
    id,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount
  ];
  static String adult = 'adult';
  static String backdropPath = 'backdropPath';
  static String id = 'id';
  static String originalLanguage = 'originalLanguage';
  static String originalTitle = 'originalTitle';
  static String overview = 'overview';
  static String popularity = 'popularity';
  static String posterPath = 'posterPath';
  static String releaseDate = 'releaseDate';
  static String title = 'title';
  static String video = 'video';
  static String voteAverage = 'voteAverage';
  static String voteCount = 'voteCount';
}

class FilmData {
  FilmData({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  // factory FilmData.fromJson(Map<String, dynamic> json) => FilmData(
  //       adult: json["adult"],
  //       backdropPath: json["backdrop_path"],
  //       id: json["id"],
  //       originalLanguage: json["original_language"],
  //       originalTitle: json["original_title"],
  //       overview: json["overview"],
  //       popularity: json["popularity"].toDouble(),
  //       posterPath: json["poster_path"],
  //       releaseDate: DateFormat("dd-MM-yyyy").parse(json["release_date"]),
  //       title: json["title"],
  //       video: json["video"],
  //       voteAverage: json["vote_average"].toDouble(),
  //       voteCount: json["vote_count"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "adult": adult,
  //       "backdrop_path": backdropPath,
  //       "id": id,
  //       "original_language": originalLanguage,
  //       "original_title": originalTitle,
  //       "overview": overview,
  //       "popularity": popularity,
  //       "poster_path": posterPath,
  //       "release_date": DateFormat("dd-MM-yyyy").format(releaseDate),
  //       "title": title,
  //       "video": video,
  //       "vote_average": voteAverage,
  //       "vote_count": voteCount,
  //     };
  factory FilmData.fromJson(Map<String, dynamic> json) => FilmData(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateFormat("dd-MM-yyyy").parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": DateFormat('dd-MM-yyyy').format(releaseDate),
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };

  //DB
  factory FilmData.fromJsonDB(Map<String, dynamic> json) => FilmData(
        adult: json[FilmDataFields.adult] == 0 ? false : true,
        backdropPath: json[FilmDataFields.backdropPath].toString(),
        id: json[FilmDataFields.id] as int,
        originalLanguage: json[FilmDataFields.originalLanguage].toString(),
        originalTitle: json[FilmDataFields.originalTitle].toString(),
        overview: json[FilmDataFields.overview].toString(),
        popularity: json[FilmDataFields.popularity] as double,
        posterPath: json[FilmDataFields.posterPath].toString(),
        releaseDate: DateFormat("dd-MM-yyyy").parse(json[FilmDataFields.releaseDate]),
        title: json[FilmDataFields.title].toString(),
        video: json[FilmDataFields.video] == 0 ? false : true,
        voteAverage: json[FilmDataFields.voteAverage] as double,
        voteCount: json[FilmDataFields.voteCount] as int,
      );
  factory FilmData.fromJsonDB2(Map<String, dynamic> json) => FilmData(
        adult: json[FilmDataFields.adult] == 0 ? false : true,
        backdropPath: json[FilmDataFields.backdropPath],
        id: json[FilmDataFields.id],
        originalLanguage: json[FilmDataFields.originalLanguage],
        originalTitle: json[FilmDataFields.originalTitle],
        overview: json[FilmDataFields.overview],
        popularity: json[FilmDataFields.popularity],
        posterPath: json[FilmDataFields.posterPath],
        releaseDate: DateTime.parse(json[FilmDataFields.releaseDate]),
        title: json[FilmDataFields.title],
        video: json[FilmDataFields.video] == 0 ? false : true,
        voteAverage: json[FilmDataFields.voteAverage],
        voteCount: json[FilmDataFields.voteCount],
      );

  Map<String, dynamic> toJsonDB() => {
        FilmDataFields.adult: adult,
        FilmDataFields.backdropPath: backdropPath,
        FilmDataFields.id: id,
        FilmDataFields.originalLanguage: originalLanguage,
        FilmDataFields.originalTitle: originalTitle,
        FilmDataFields.overview: overview,
        FilmDataFields.popularity: popularity,
        FilmDataFields.posterPath: posterPath,
        FilmDataFields.releaseDate: DateFormat("dd-MM-yyyy").format(releaseDate),
        FilmDataFields.title: title,
        FilmDataFields.video: video,
        FilmDataFields.voteAverage: voteAverage,
        FilmDataFields.voteCount: voteCount,
      };
}

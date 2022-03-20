// To parse this JSON data, do
//
//     final similar = similarFromJson(jsonString);

import 'dart:convert';

import 'package:movie_ticket/data/models/film_data.dart';

Similar similarFromJson(String str) => Similar.fromJson(json.decode(str));

String similarToJson(Similar data) => json.encode(data.toJson());

class Similar {
    Similar({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<FilmData> results;
    int totalPages;
    int totalResults;

    factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        page: json["page"],
        results: List<FilmData>.from(json["results"].map((x) => FilmData.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/data/models/actor.dart';
import 'package:movie_ticket/data/models/detail.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_ticket/data/models/review.dart';
import 'package:movie_ticket/data/models/similar.dart';
import 'package:movie_ticket/data/models/video.dart';

abstract class FilmRepository {
  Future<List<FilmData>?> getListFilm(String name, int page);
  Future<Detail?> getDetail(int id);
  Future<Review?> getReview(int id, int page);
  Future<Actor?> getActor(int id);
  Future<Similar?> getSimilar(int id, int page);
  Future<List<FilmData>?> getListFilmByName(String name, int page);
  Future<List<Video>?> getListVideo(int id);
}

class FilmRepositoryImp implements FilmRepository {
  //https://api.themoviedb.org/3/movie/top_rated?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US&page=1

  @override
  Future<List<FilmData>?> getListFilm(String name, int page) async {
    Uri url = Uri.http(Global.baseURL, "/3/movie/$name",
        {'api_key': Global.apiKey, 'language': 'en-US', 'page': '$page'});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<FilmData> listFilmData = [];
        var jsonResponse = jsonDecode(response.body);
        for (var item in jsonResponse['results']) {
          listFilmData.add(FilmData.fromJson(item));
        }
        return listFilmData;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Detail?> getDetail(int id) async {
    // details: https://api.themoviedb.org/3/movie/634649?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US
    Uri url = Uri.http(Global.baseURL, "/3/movie/$id",
        {'api_key': Global.apiKey, 'language': 'en-US'});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Detail detail = Detail.fromJson(jsonResponse);
        return detail;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Review?> getReview(int id, int page) async {
    // reviews: https://api.themoviedb.org/3/movie/634649/reviews?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US&page=1
    Uri url = Uri.http(Global.baseURL, "/3/movie/$id/reviews",
        {'api_key': Global.apiKey, 'language': 'en-US', 'page': '$page'});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = await jsonDecode(response.body);
        Review review = Review.fromJson(jsonResponse);
        return review;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Actor?> getActor(int id) async {
    // actor: https://api.themoviedb.org/3/movie/634649/credits?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US
    Uri url = Uri.http(Global.baseURL, "/3/movie/$id/credits",
        {'api_key': Global.apiKey, 'language': 'en-US'});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Actor actor = Actor.fromJson(jsonResponse);
        return actor;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Similar?> getSimilar(int id, int page) async {
    // similar: https://api.themoviedb.org/3/movie/634649/similar?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US&page=1
    Uri url = Uri.http(Global.baseURL, "/3/movie/$id/similar",
        {'api_key': Global.apiKey, 'language': 'en-US', 'page': '$page'});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Similar similar = Similar.fromJson(jsonResponse);
        return similar;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<FilmData>?> getListFilmByName(String name, int page) async {
    //https://api.themoviedb.org/3/search/movie?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US&query=spider&page=1&include_adult=false
    Uri url = Uri.http(Global.baseURL, "/3/search/movie", {
      'api_key': Global.apiKey,
      'language': 'en-US',
      'query': name,
      'page': '$page',
      'include_adult': '${false}'
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<FilmData> listFilmData = [];
        var jsonResponse = jsonDecode(response.body);
        for (var item in jsonResponse['results']) {
          listFilmData.add(FilmData.fromJson(item));
        }
        return listFilmData;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Video>?> getListVideo(int id) async {
    //https://api.themoviedb.org/3/movie/634649/videos?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US
    Uri url = Uri.http(
      Global.baseURL,
      "/3/movie/$id/videos",
      {
        'api_key': Global.apiKey,
        'language': 'en-US',
      },
    );
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<Video> listVideo = [];
        for (var item in jsonResponse['results']) {
          listVideo.add(Video.fromJson(item));
        }
        return listVideo;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}

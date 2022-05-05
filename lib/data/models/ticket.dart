import 'package:intl/intl.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class Ticket {
  String id;
  String cinemaName;
  DateTime dateTime;
  String cinemaTime;
  List<String> listSeat;
  int total;
  FilmData filmData;

  Ticket({
    required this.id,
    required this.cinemaName,
    required this.dateTime,
    required this.cinemaTime,
    required this.listSeat,
    required this.total,
    required this.filmData,
  });

  Map<String, dynamic> toJson() {
    return {
      'idFilm': id,
      'cinemaName': cinemaName,
      'dateTime': DateFormat('yyyy-MM-dd').format(dateTime),
      'cinemaTime': cinemaTime,
      'listSeat': listSeat,
      'total': total,
      'filmData': filmData.toJson(),
    };
  }

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['idFilm'] ?? '',
      cinemaName: json['cinemaName'] ?? '',
      dateTime: DateFormat('yyyy-MM-dd').parse(json["dateTime"]),
      cinemaTime: json['cinemaTime'] ?? '',
      listSeat: List<String>.from(json['listSeat']),
      total: json['total']?.toInt() ?? 0,
      filmData: FilmData.fromJson(json['filmData']),
    );
  }
}

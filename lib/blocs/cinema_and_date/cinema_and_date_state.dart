import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class CinemaAndDateState {
  List<DateTime> listDateTime;
  CinemaName cinemaName;
  CinemaTime? time;
  DateTime? day;

  CinemaAndDateState({
    required this.listDateTime,
    required this.cinemaName,
    this.time,
    this.day,
  });

  CinemaAndDateState copyWith({
    List<DateTime>? listDateTime,
    CinemaName? cinemaName,
    CinemaTime? time,
    DateTime? day,
  }) {
    return CinemaAndDateState(
      listDateTime: listDateTime ?? this.listDateTime,
      cinemaName: cinemaName ?? this.cinemaName,
      time: time ?? this.time,
      day: day ?? this.day,
    );
  }
}

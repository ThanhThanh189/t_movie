class ChooseSeatState {
  List<String> listSeatSelected;
  List<String> listSeatBooked;
  ChooseSeatState({
    required this.listSeatSelected,
    required this.listSeatBooked,
  });

  ChooseSeatState copyWith({
    String? seatSelected,
    List<String>? listSeatSelected,
    List<String>? listSeatBooked,
  }) {
    return ChooseSeatState(
      listSeatSelected: listSeatSelected ?? this.listSeatSelected,
      listSeatBooked: listSeatBooked ?? this.listSeatBooked,
    );
  }
}

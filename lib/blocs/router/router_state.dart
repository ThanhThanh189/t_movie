class RouterState {
  int index;
  RouterState({
    required this.index,
  });

  factory RouterState.initial() => RouterState(index: 0);

  RouterState update({
    int? index,
  }) {
    return RouterState(
      index: index ?? this.index,
    );
  }
}

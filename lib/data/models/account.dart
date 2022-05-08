class Account {
  final String? id;
  final String? displayName;
  final String? email;
  final String? photo;
  final int? wallet;
  Account({
    this.id,
    this.displayName,
    this.email,
    this.photo,
    this.wallet,
  });

  Account copyWith({
    String? id,
    String? displayName,
    String? email,
    String? photo,
    int? wallet,
  }) {
    return Account(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      wallet: wallet ?? this.wallet,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photo': photo,
      'wallet': wallet,
    };
  }

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      displayName: map['displayName'],
      email: map['email'],
      photo: map['photo'],
      wallet: map['wallet']?.toInt(),
    );
  }
}

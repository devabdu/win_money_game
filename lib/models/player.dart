class Player {
  final String nickname;
  final String socketID;
  final double points;
  final String playerType;
  final String uId;
  final int coins;
  final int avatar;

  Player({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.playerType,
    required this.uId,
    required this.coins,
    required this.avatar,

  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
      'uId': uId,
      'coins': coins,
      'avatar': avatar,

    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? '',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerType: map['playerType'] ?? '',
      uId: map['uId'] ?? '',
      coins: map['coins'] ?? '',
      avatar: map['avatar'] ?? '',

    );
  }

  Player copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerType,
    String? uId,
    int? coins,
    int? avatar,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
      uId: uId ?? this.uId,
      coins: coins ?? this.coins,
      avatar: avatar ?? this.avatar,
    );
  }
}
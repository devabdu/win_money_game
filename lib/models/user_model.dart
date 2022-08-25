class UserModel
{
  late String name;
  late String email;
  late String uId;
  late int amount;
  late double exp;
  late int coins;
  late int level;
  late int avatar;
  late Map<String, dynamic> dailyCounts;
  late Map<String, dynamic> weeklyCounts;
  late bool isAdmin;
  late int chessTwins;
  late int chessRwins;
  late int xoTwins;
  late int xoRwins;

  UserModel({
    required this.name,
    required this.email,
    required this.uId,
    required this.amount,
    required this.exp,
    required this.coins,
    required this.level,
    required this.avatar,
    required this.dailyCounts,
    required this.weeklyCounts,
    required this.isAdmin,
    required this.chessTwins,
    required this.chessRwins,
    required this.xoTwins,
    required this.xoRwins,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    uId = json['uId'];
    amount = json['amount'];
    exp = json['exp'];
    coins = json['coins'];
    level = json['level'];
    avatar = json['avatar'];
    dailyCounts = json['dailyCounts'];
    weeklyCounts = json['weeklyCounts'];
    isAdmin = json['isAdmin'];
    chessTwins = json['chessTwins'];
    chessRwins = json['chessRwins'];
    xoTwins = json['xoTwins'];
    xoRwins = json['xoRwins'];
  }

  Map<String, dynamic> toJson()
  {
    return {
      'name' : name,
      'email' : email,
      'uId' : uId,
      'amount' : amount,
      'exp' : exp,
      'coins' : coins,
      'level' : level,
      'avatar' : avatar,
      'dailyCounts' : dailyCounts,
      'weeklyCounts' : weeklyCounts,
      'isAdmin' : isAdmin,
      'chessTwins' : chessTwins,
      'chessRwins' : chessRwins,
      'xoTwins' : xoTwins,
      'xoRwins' : xoRwins,
    };
  }
}
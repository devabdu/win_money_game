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
  });

  // static UserModel fromJson(Map<String, dynamic> json) => UserModel(
  //   name: json['name'],
  //   email: json['email'],
  //   uId: json['uId'],
  //   amount : json['amount'],
  //   exp : json['exp'],
  //   coins : json['coins'],
  //   level : json['level'],
  //   avatar : json['avatar'],
  //   dailyCounts: json['dailyCounts'],
  //   weeklyCounts: json['weeklyCounts'],
  //   isAdmin: json['isAdmin'],
  // );

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
    };
  }
}
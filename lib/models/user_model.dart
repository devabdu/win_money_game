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
  late int firstDMCount;
  late int secondDMCount;
  late int thirdDMCount;
  late int firstWMCount;
  late int secondWMCount;
  late int thirdWMCount;
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
    required this.firstDMCount,
    required this.secondDMCount,
    required this.thirdDMCount,
    required this.firstWMCount,
    required this.secondWMCount,
    required this.thirdWMCount,
    required this.isAdmin,
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'],
    email: json['email'],
    uId: json['uId'],
    amount : json['amount'],
    exp : json['exp'],
    coins : json['coins'],
    level : json['level'],
    avatar : json['avatar'],
    firstDMCount : json['firstDMCount'],
    secondDMCount : json['secondDMCount'],
    thirdDMCount : json['thirdDMCount'],
    firstWMCount : json['firstWMCount'],
    secondWMCount : json['secondWMCount'],
    thirdWMCount : json['thirdWMCount'],
    isAdmin: json['isAdmin'],
  );

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
      'firstDMCount' : firstDMCount,
      'secondDMCount' : secondDMCount,
      'thirdDMCount' : thirdDMCount,
      'firstWMCount' : firstWMCount,
      'secondWMCount' : secondWMCount,
      'thirdWMCount' : thirdWMCount,
      'isAdmin' : isAdmin,
    };
  }
}
class MissionsModel
{
  late String name;
  late String mId;
  late bool isPublished;
  late int count;

  MissionsModel({
    required this.name,
    required this.mId,
    required this.isPublished,
    required this.count,
  });

  static MissionsModel fromJson(Map<String, dynamic> json) => MissionsModel(
    name: json['name'],
    mId: json['mId'],
    isPublished: json['isPublished'],
    count : json['count'],
  );

  Map<String, dynamic> toJson()
  {
    return {
      'name' : name,
      'mId' : mId,
      'isPublished' : isPublished,
      'count' : count,
    };
  }
}
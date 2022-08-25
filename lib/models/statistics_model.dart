class StatisticsModel
{
  late int targetWins;

  StatisticsModel({
    required this.targetWins,
  });

  StatisticsModel.fromJson(Map<String, dynamic>? json) {
    targetWins = json!['targetWins'];
  }

  Map<String, dynamic> toJson()
  {
    return {
      'targetWins' : targetWins,
    };
  }
}
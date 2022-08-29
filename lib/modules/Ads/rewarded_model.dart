import 'package:admob_flutter/admob_flutter.dart';
import 'package:win_money_game/modules/Ads/adsManager.dart';
class AdRewarded{

  late AdmobReward rewardAd;

   void loadAd(){
     rewardAd = AdmobReward(
       adUnitId: AdsManager.rewardedAdUnitIdEx,
       listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
         if (event == AdmobAdEvent.closed) rewardAd.load();
       },
     );
     rewardAd.load();
   }
}
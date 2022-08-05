import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';

class AdsManager{
  static bool _testMode = true;

  static String get bannerAdUnitIdEx{
    if(_testMode ==  true){
      return AdmobBanner.testAdUnitId;
    }else if(Platform.isAndroid){
      return "ca-app-pub-4177465946741319/7040083620";
    }else if(Platform.isIOS){
      return "";
    }else{
      throw new UnsupportedError("unsupported platform");
    }
  }

  static String get interstitialAdUnitIdEx {
    if(_testMode ==  true){
      return AdmobInterstitial.testAdUnitId;
    }else if(Platform.isAndroid){
      return "ca-app-pub-4177465946741319/6082225174";
    }else if(Platform.isIOS){
      return "";
    }else{
      throw new UnsupportedError("unsupported platform");
    }
  }

  static String get rewardedAdUnitIdEx {
    if(_testMode ==  true){
      return AdmobReward.testAdUnitId;
    }else if(Platform.isAndroid){
      return "ca-app-pub-4177465946741319/6082225174";
    }else if(Platform.isIOS){
      return "";
    }else{
      throw new UnsupportedError("unsupported platform");
    }
  }


}
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/main.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/modules/Ads/adsManager.dart';
import 'package:win_money_game/modules/NavigatorDrawer/navigation_drawer_widget.dart';
import 'package:win_money_game/modules/chess/Old/components/home_screen.dart';
import 'package:win_money_game/modules/chess/chess_game.dart';
import 'package:win_money_game/modules/ludo/ludo_screen.dart';
import 'package:win_money_game/modules/missions/daily_missions.dart';
import 'package:win_money_game/modules/missions/weekly_missions.dart';
import 'package:win_money_game/modules/selectScreens/play_on_off.dart';
import 'package:win_money_game/providers/users_provider.dart';
import 'package:win_money_game/shared/components/components.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {

  ///////////////////////////////////////
  //ads
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

  @override
  void initState() {

    super.initState();

    setState(() {});

    // You should execute `Admob.requestTrackingAuthorization()` here before showing any ad.

    bannerSize = AdmobBannerSize.FULL_BANNER; //initializing banner size

    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitIdEx,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    ); //interstital Ad init

    rewardAd = AdmobReward(
      adUnitId: AdsManager.rewardedAdUnitIdEx,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    ); //rewardAd init

    interstitialAd.load();
    rewardAd.load();
  }

  void handleEvent(AdmobAdEvent event, Map<String, dynamic>? args,
      String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog( //msg shown when finishing the 7 sec video ad
          context: scaffoldState.currentContext!,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                return true;
              },
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args!['type']}'),
                    Text('Amount: ${args['amount']}'),
                    //amount to be stored in db
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
    }
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data;
          return user == null ? const Center(child: Text('No User')) : Scaffold(
            backgroundColor: Colors.deepPurple,
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              backgroundColor: Colors.amberAccent,
              iconTheme: const IconThemeData(
                color: Colors.deepPurple,
              ),
              // title: const Text("Win Money Game",
              //   style: TextStyle(color: Colors.deepPurple),
              // ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    right: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on,
                        color: Colors.deepPurple,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${user.coins}'.replaceAllMapped(reg, mathFunc),
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.money_outlined,
                        color: Colors.deepPurple,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${user.cash}'.replaceAllMapped(reg, mathFunc),
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, right: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              if (selectTasaly) {
                                final isLoaded = await interstitialAd.isLoaded;
                                if (isLoaded ?? false) {
                                  interstitialAd.show(); //interstital ad show
                                } else {
                                  showSnackBar(
                                      'Interstitial ad is still loading...');
                                }
                              }
                              navigateTo(context, DailyMissionsScreen());
                              if(!dailyMissionsShown) {
                                showDialog<String>(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text(
                                          'Hint',
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        content: Text(
                                          'Complete Daily Missions to Win ${user
                                              .dailyAmount} Cash and 5k Coins!!',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        backgroundColor: Colors.amberAccent,
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                );
                                dailyMissionsShown = true;
                              }
                            },
                            child: Image.asset(
                              "assets/images/daily_missions.png",
                              height: 90,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (selectTasaly) {
                                final isLoaded = await interstitialAd.isLoaded;
                                if (isLoaded ?? false) {
                                  interstitialAd.show(); //interstital ad show
                                } else {
                                  showSnackBar(
                                      'Interstitial ad is still loading...');
                                }
                              }
                              navigateTo(context, WeeklyMissionsScreen());
                              if(!weeklyMissionsShown) {
                                showDialog<String>(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text(
                                          'Hint',
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        content: Text(
                                          'Complete Weekly Missions to Win ${user
                                              .weeklyAmount} Cash and 10k Coins!!',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        backgroundColor: Colors.amberAccent,
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                );
                                weeklyMissionsShown = true;
                              }
                            },
                            child: Image.asset(
                              "assets/images/weekly_missions.png",
                              height: 90,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (await rewardAd.isLoaded) {
                                rewardAd.show(); // showing rewarded ad
                                //look below
                                setState(() {});
                                stopMusic();
                                ////////////
                                final provider = Provider.of<UsersProvider>(
                                    context, listen: false);
                                await provider.updateUserDailyMissionProgress(
                                  userCounts: user.dailyCounts,
                                  missionName: 'Watch 3 ads',
                                );
                                await provider.updateUserWeeklyMissionProgress(
                                  userCounts: user.weeklyCounts,
                                  missionName: 'Watch 12 ads',
                                );
                                await provider.watchAdReward();

                                showDialog<String>(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text(
                                          'Congratulations!',
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        content: Text(
                                          'You got 1,000 coins!',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        backgroundColor: Colors.amberAccent,
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              //look below
                                              final provider = Provider.of<UsersProvider>(
                                                  context, listen: false);
                                              provider.turnOnMusicAfterBackground();
                                              setState(() {});
                                              /////////////
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                );
                              } else {
                                showSnackBar('Reward ad is still loading...');
                              }
                            },
                            child: Image.asset(
                              "assets/images/reward.png",
                              height: 90,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                          // IconButton(
                          //     onPressed: () {
                          //       navigateTo(context, SelectRoom());
                          //     },
                          //     icon: Icon(Icons.ads_click)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60,
                        horizontal: 100,
                    ),
                    child: Column(
                      children: [

                        InkWell(
                          onTap: () async {
                            if (selectTasaly) {
                              final isLoaded = await interstitialAd.isLoaded;
                              if (isLoaded ?? false) {
                                interstitialAd.show(); //interstital ad show
                              } else {
                                showSnackBar(
                                    'Interstitial ad is still loading...');
                              }
                            }
                            navigateTo(context, Play_On_Off());
                          },
                          child: Image.asset("assets/images/xo.png",
                            fit: BoxFit.fill,
                            width: 200,
                            height: 180,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            if (selectTasaly) {
                              final isLoaded = await interstitialAd.isLoaded;
                              if (isLoaded ?? false) {
                                interstitialAd.show(); //interstital ad show
                              } else {
                                showSnackBar(
                                    'Interstitial ad is still loading...');
                              }
                            }
                            navigateTo(context, MainMenuScreen());
                          },
                          child: Image.asset("assets/images/chess.png",
                            fit: BoxFit.fill,
                            width: 200,
                            height: 180,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            if (selectTasaly) {
                              final isLoaded = await interstitialAd.isLoaded;
                              if (isLoaded ?? false) {
                                interstitialAd.show(); //interstital ad show
                              } else {
                                showSnackBar(
                                    'Interstitial ad is still loading...');
                              }
                            }
                            navigateTo(context, LudoScreen());
                          },
                          child: Image.asset("assets/images/LUDO Game.png",
                            fit: BoxFit.fill,
                            width: 200,
                            height: 180,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar:  Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: AdmobBanner( //banners init
                adUnitId: AdsManager.bannerAdUnitIdEx,
                adSize: bannerSize!,
                listener: (AdmobAdEvent event,
                    Map<String, dynamic>? args) {
                  handleEvent(event, args, 'Banner');
                },
                onBannerCreated:
                    (AdmobBannerController controller) {
                  // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                  // Normally you don't need to worry about disposing this yourself, it's handled.
                  // If you need direct access to dispose, this is your guy!
                  // controller.dispose();
                },
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
  //////////////
  //ads
  @override
  void dispose() {

    interstitialAd.dispose();
    rewardAd.dispose();
    super.dispose();
  }
}





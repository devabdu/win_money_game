import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
// import 'package:admob_flutter_example/extensions.dart';
import 'package:win_money_game/Provider/adsManager.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize without device test ids
  Admob.initialize();

  // Add a list of test ids.
  // Admob.initialize(testDeviceIds: ['YOUR DEVICE ID']);

  runApp(MyMaterialApp());
}

class MyMaterialApp extends StatefulWidget {
  @override
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

  @override
  void initState() {
    super.initState();

    // You should execute `Admob.requestTrackingAuthorization()` here before showing any ad.

    bannerSize = AdmobBannerSize.BANNER; //initializing banner size

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

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
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
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args!['type']}'),
                    Text('Amount: ${args['amount']}'), //amount to be stored in db
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
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            title: const Text('AdmobFlutter'),
          ), // .withBottomAdmobBanner(context),
          bottomNavigationBar: Builder(
            builder: (BuildContext context) {
              return Container(
                color: Colors.blueGrey,
                child: SafeArea(
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              final isLoaded = await interstitialAd.isLoaded;
                              if (isLoaded ?? false) {
                                interstitialAd.show(); //interstital ad show
                              } else {
                                showSnackBar(
                                    'Interstitial ad is still loading...');
                              }
                            },
                            child: Text(
                              'Show Interstitial',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              if (await rewardAd.isLoaded) {
                                rewardAd.show(); // showing rewarded ad
                              } else {
                                showSnackBar('Reward ad is still loading...');
                              }
                            },
                            child: Text(
                              'Show Reward',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: PopupMenuButton(
                            initialValue: bannerSize,
                            offset: Offset(0, 20),
                            onSelected: (AdmobBannerSize newSize) {
                              setState(() {
                                bannerSize = newSize;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<AdmobBannerSize>>[ //banner size control
                              PopupMenuItem(
                                value: AdmobBannerSize.BANNER,
                                child: Text('BANNER'),
                              ),
                              PopupMenuItem(
                                value: AdmobBannerSize.LARGE_BANNER,
                                child: Text('LARGE_BANNER'),
                              ),
                              PopupMenuItem(
                                value: AdmobBannerSize.MEDIUM_RECTANGLE,
                                child: Text('MEDIUM_RECTANGLE'),
                              ),
                              PopupMenuItem(
                                value: AdmobBannerSize.FULL_BANNER,
                                child: Text('FULL_BANNER'),
                              ),
                              PopupMenuItem(
                                value: AdmobBannerSize.LEADERBOARD,
                                child: Text('LEADERBOARD'),
                              ),
                              PopupMenuItem(
                                value: AdmobBannerSize.SMART_BANNER(context),
                                child: Text('SMART_BANNER'),
                              ),
                              PopupMenuItem(
                                value: AdmobBannerSize.ADAPTIVE_BANNER(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width
                                      .toInt() -
                                      40, // considering EdgeInsets.all(20.0)
                                ),
                                child: Text('ADAPTIVE_BANNER'),
                              ),
                            ],
                            child: Center(
                              child: Text(
                                'Banner size',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    padding: EdgeInsets.all(20.0),
                    itemCount: 1000,
                    itemBuilder: (BuildContext context, int index) {
                      if (index != 0 && index % 6 == 0) {
                        return Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 20.0),
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
                            Container(
                              height: 100.0,
                              margin: EdgeInsets.only(bottom: 20.0),
                              color: Colors.cyan,
                            ),
                          ],
                        );
                      }
                      return Container(
                        height: 100.0,
                        margin: EdgeInsets.only(bottom: 20.0),
                        color: Colors.cyan,
                      );
                    },
                  ),
                ),
              ),
              // Another option is to fix a banner ad to the top or bottom of your content.
              // Notice that banners are not scrolling, which is a violation of admob policy.
              //
              // See: https://github.com/kmcgill88/admob_flutter/issues/194
              // "banner ads should not move as a user scrolls, as users may try to
              // click on the menu but end up clicking on the ad accidentally instead.
              // This specific implementation is against policy and we reserve the right
              // to disable ad serving to your app."

              // Builder(
              //   builder: (BuildContext context) {
              //     final size = MediaQuery.of(context).size;
              //     final height = max(size.height * .05, 50.0);
              //     return Container(
              //       width: size.width,
              //       height: height,
              //       child: AdmobBanner(
              //         adUnitId: getBannerAdUnitId(),
              //         adSize: AdmobBannerSize.ADAPTIVE_BANNER(
              //           width: size.width.toInt(),
              //         ),
              //         listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              //           handleEvent(event, args, 'Banner');
              //         },
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
    // .withBottomAdmobBanner(context);
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    super.dispose();
  }
}





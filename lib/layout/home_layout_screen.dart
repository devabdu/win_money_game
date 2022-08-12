import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/Ads/adsManager.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/modules/NavigatorDrawer/navigation_drawer_widget.dart';
import 'package:win_money_game/modules/chess/components/home_screen.dart';
import 'package:win_money_game/modules/ludo/ludo_screen.dart';
import 'package:win_money_game/modules/xo/xo_selecct_level_xo_screen.dart';
import '../shared/components/components.dart';

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
  /////////////////////////////////////////
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot){
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? Center(child:Text('No User')) : Scaffold(
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
                  padding: const EdgeInsets.only(top:4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const Icon(Icons.monetization_on,
                        color: Colors.deepPurple,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${user.coins}',
                        style:const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_bag_rounded,),color: Colors.deepPurple,),
              ],
            ),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 5),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (_) => defaultMissionDialog(
                                  function: (){
                                    Navigator.pop(context);
                                  }
                              ),
                              barrierDismissible: false,
                            );
                            // navigateTo(context, TestScreen());
                          },
                          child: Image.asset(
                            "assets/images/missions.png",
                            height: 90,
                            width: 90,
                            fit: BoxFit.fill,
                          ),
                        ),
                        InkWell(
                          onTap: ()async {
                            if (await rewardAd.isLoaded) {
                              rewardAd.show(); // showing rewarded ad
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 70,
                      horizontal: 100
                  ),
                  child: Column(
                    children: [

                      InkWell(
                        onTap: () {
                          navigateTo(context, const SelectLevelXoScreen());
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
                        onTap: () {
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
                        onTap: () {
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child:
                  Container(
                     margin: EdgeInsets.only(bottom: 6.0),
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
                ),
              ],
            ),
            // bottomNavigationBar: Builder(
            //   builder: (BuildContext context) {
            //     return Container(
            //       color: Colors.blueGrey,
            //       child: SafeArea(
            //         child: SizedBox(
            //           height: 60,
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Expanded(
            //                 child: TextButton(
            //                   onPressed: () async {
            //                     final isLoaded = await interstitialAd.isLoaded;
            //                     if (isLoaded ?? false) {
            //                       interstitialAd.show(); //interstital ad show
            //                     } else {
            //                       showSnackBar(
            //                           'Interstitial ad is still loading...');
            //                     }
            //                   },
            //                   child: Text(
            //                     'Show Interstitial',
            //                     style: TextStyle(color: Colors.white),
            //                   ),
            //                 ),
            //               ),
            //               Expanded(
            //                 child: TextButton(
            //                   onPressed: () async {
            //                     if (await rewardAd.isLoaded) {
            //                       rewardAd.show(); // showing rewarded ad
            //                     } else {
            //                       showSnackBar('Reward ad is still loading...');
            //                     }
            //                   },
            //                   child: Text(
            //                     'Show Reward',
            //                     style: TextStyle(color: Colors.white),
            //                   ),
            //                 ),
            //               ),
            //               // Expanded(
            //               //   child: PopupMenuButton(
            //               //     initialValue: bannerSize,
            //               //     offset: Offset(0, 20),
            //               //     onSelected: (AdmobBannerSize newSize) {
            //               //       setState(() {
            //               //         bannerSize = newSize;
            //               //       });
            //               //     },
            //               //     itemBuilder: (BuildContext context) =>
            //               //     <PopupMenuEntry<AdmobBannerSize>>[ //banner size control
            //               //       PopupMenuItem(
            //               //         value: AdmobBannerSize.BANNER,
            //               //         child: Text('BANNER'),
            //               //       ),
            //               //       PopupMenuItem(
            //               //         value: AdmobBannerSize.LARGE_BANNER,
            //               //         child: Text('LARGE_BANNER'),
            //               //       ),
            //               //       PopupMenuItem(
            //               //         value: AdmobBannerSize.MEDIUM_RECTANGLE,
            //               //         child: Text('MEDIUM_RECTANGLE'),
            //               //       ),
            //               //       PopupMenuItem(
            //               //         value: AdmobBannerSize.FULL_BANNER,
            //               //         child: Text('FULL_BANNER'),
            //               //       ),
            //               //       PopupMenuItem(
            //               //         value: AdmobBannerSize.LEADERBOARD,
            //               //         child: Text('LEADERBOARD'),
            //               //       ),
            //               //       PopupMenuItem(
            //               //         value: AdmobBannerSize.SMART_BANNER(context),
            //               //         child: Text('SMART_BANNER'),
            //               //       ),
            //               //       PopupMenuItem(
            //               //         value: AdmobBannerSize.ADAPTIVE_BANNER(
            //               //           width: MediaQuery.of(context)
            //               //               .size
            //               //               .width
            //               //               .toInt() -
            //               //               40, // considering EdgeInsets.all(20.0)
            //               //         ),
            //               //         child: Text('ADAPTIVE_BANNER'),
            //               //       ),
            //               //     ],
            //               //     child: Center(
            //               //       child: Text(
            //               //         'Banner size',
            //               //         style: TextStyle(
            //               //             fontWeight: FontWeight.w500,
            //               //             color: Colors.white),
            //               //       ),
            //               //     ),
            //               //   ),
            //               // ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          );
        } else if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        } else {
          return Center(child: CircularProgressIndicator(),);
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
 ///////////////
}


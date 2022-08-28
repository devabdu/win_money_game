import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/Ads/adsManager.dart';
import 'package:win_money_game/modules/xo/xo_utils.dart';
import 'package:win_money_game/shared/components/components.dart';

class Player {
  static const none = '';
  static const X = 'X';
  static const O = 'O';
}

class SecondXOScreen extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<SecondXOScreen> {
  static final countMatrix = 4;
  static final double size = 82;

  String lastMove = Player.none;
  late List<List<String>> matrix;
  ////////////////////////////////////
  //ads//
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    bannerSize = AdmobBannerSize.FULL_BANNER; //initializing banner size

    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitIdEx,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    ); //interstital Ad init

    interstitialAd.load();

    setEmptyFields();
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
        showDialog(
          //msg shown when finishing the 7 sec video ad
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
                    Text(
                        'Amount: ${args['amount']}'), //amount to be stored in db
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
  ////////

  void setEmptyFields() => setState(() => matrix = List.generate(
        countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
      ));

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          //backgroundColor: Color.fromRGBO(16, 13, 34, 1),
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            //centerTitle: true,
            //backgroundColor: Color.fromRGBO(16, 13, 34, 1),
            backgroundColor: Colors.amberAccent,
            iconTheme: const IconThemeData(
              color: Colors.deepPurple,
            ),
            title: const Text(
              'XO',
              style: TextStyle(color: Colors.deepPurple),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  //ads
                  if (selectTasaly) {
                    final isLoaded = await interstitialAd.isLoaded;
                    if (isLoaded ?? false) {
                      interstitialAd.show(); //interstital ad show
                    } else {
                      showSnackBar('Interstitial ad is still loading...');
                    }
                  }
                  showDialog<String>(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Exit',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                        'Are you sure you want to Exit the Game?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple,
                        ),
                      ),
                      backgroundColor: Colors.amberAccent,
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Exit'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.logout_outlined),
                color: Colors.deepPurple,
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ...Xo_Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildRow(int x) {
    final values = matrix[x];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Xo_Utils.modelBuilder(
          values,
          (y, value) => buildField(x, y),
        ),
      ),
    );
  }

  Color getShadowColor(String value) {
    switch (value) {
      case Player.O:
        return Colors.amberAccent;
      case Player.X:
        return Colors.deepPurple;
      default:
        return Color.fromRGBO(16, 13, 34, 1);
    }
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    final color = getShadowColor(value);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          primary: Color.fromRGBO(16, 13, 34, 1),
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 40,
                  color: color,
                ),
              ],
            ),
          ),
        ),
        onPressed: () => selectField(value, x, y),
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == Player.none) {
      final newValue = lastMove == Player.X ? Player.O : Player.X;

      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        showEndDialog('Player $newValue Won');
      } else if (isEnd()) {
        showEndDialog('Undecided Game');
      }
    }
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));

  /// Check out logic here: https://stackoverflow.com/a/1058804
  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  Future showEndDialog(String title) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.amberAccent,
          title: Text(
            title,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Press to Restart the Game',
            style: TextStyle(
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setEmptyFields();
                Navigator.of(context).pop();
              },
              child: Text('Restart'),
            )
          ],
        ),
      );

  //////////////
  //ads
  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }
///////////////
}

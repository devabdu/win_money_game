import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/modules/Ads/adsManager.dart';

import '../../../../shared/components/components.dart';



class PlayGamePage extends StatefulWidget {
  const PlayGamePage({Key? key}) : super(key: key);
  static String routeName = '/play_game_page';
  @override
  _PlayGamePageState createState() => _PlayGamePageState();
}

class _PlayGamePageState extends State<PlayGamePage> {
  ChessBoardController controller = ChessBoardController();
  List<String> gameMoves = [];
  var flipBoardOnMove = true;

  ////////////
  //ads
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  ///////////

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    controller = ChessBoardController();
    controller.addListener(() {
      if(_isCheckMate()){
        _showDialog("red");
      }
      if(_isDraw()){
        _showDialog(null);
      }});

    ///////////
    //ads
    bannerSize = AdmobBannerSize.FULL_BANNER; //initializing banner size
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitIdEx,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    ); //interstital Ad init
    interstitialAd.load();
    //////////
  }


  //////////
  //ads
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
                    const Text('Reward callback fired. Thanks Andrew!'),
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
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }
  /////////



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Chess',
          style: TextStyle(color: Colors.deepPurple),
        ),
        actions: [
          IconButton(
            onPressed: () async{
              //ads
              if(selectTasaly){
                final isLoaded = await interstitialAd.isLoaded;
                if (isLoaded ?? false) {
                  interstitialAd.show(); //interstital ad show
                } else {
                  showSnackBar(
                      'Interstitial ad is still loading...');
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 170),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 22,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      'https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Second player',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              // const SizedBox(width: 5),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: const Icon(
                              //     Icons.mic_rounded,
                              //     color: Colors.white,
                              //     size: 20,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ))
            ),
            _buildChessBoard(),
            SafeArea(
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 22,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      'https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'First Player',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              // const SizedBox(width: 5),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: const Icon(
                              //     Icons.mic_rounded,
                              //     color: Colors.white,
                              //     size: 20,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ))),
            _buildNotationAndOptions(),
          ],
        ),
    );
  }

  Widget _buildChessBoard() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: ChessBoard(
        controller: controller,
        boardColor: BoardColor.orange,
        boardOrientation: PlayerColor.white,

      ),
    );
  }

  Widget _buildNotationAndOptions() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: defaultButton(
                    function:  () {
                      _resetGame();
                    },
                    text: "Reset game",
                    isUpperCase: false,
                    textColor: Colors.deepPurple,
                    backgroundColorBox: Colors.amberAccent,
                    width: 170
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: defaultButton(
                    function:  () {
                      _undoMove();
                    },
                    text: "Undo Move",
                    isUpperCase: false,
                    textColor: Colors.deepPurple,
                    backgroundColorBox: Colors.amberAccent,
                    width: 170
                ),
              ),

              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal:10),
              //     child: FlatButton(
              //       height: 50,
              //       color: Colors.amberAccent,
              //       textColor: Colors.deepPurple,
              //       onPressed: () {
              //         _resetGame();
              //       },
              //       child: Text("Reset game"),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: FlatButton(
              //       height: 50,
              //       color: Colors.amberAccent,
              //       textColor: Colors.deepPurple,
              //       onPressed: () {
              //         _undoMove();
              //       },
              //       child: Text("Undo Move"),
              //     ),
              //   ),
              // ),
            ],
          ),
          Column(
            children: _buildMovesList(),
          )
        ],
      ),
    );
  }
  void _showDialog(String? winColor) {
    winColor != null
        ? showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Checkmate!"),
          content: new Text("$winColor wins!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             FlatButton(
              child: new Text("Play Again"),
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
            ),
             FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    )
        : showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Draw!"),
          content: new Text("The game is a draw!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             FlatButton(
              child: new Text("Play Again"),
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _resetGame() {
    controller.resetBoard();
    gameMoves.clear();
    setState(() {});
  }

  bool _isCheckMate(){
    return controller.isCheckMate();
  }

  bool _isDraw(){
    return controller.isDraw();
  }
  void _undoMove() {
    controller.game.undo_move();
    if(gameMoves.isNotEmpty) {
      gameMoves.removeLast();
    }
    setState(() {
    });
  }

  List<Widget> _buildMovesList() {
    List<Widget> children = [];

    for(int i = 0; i < gameMoves.length; i++) {
      if(i%2 == 0) {
        children.add(Text("${(i/2+ 1).toInt()}. ${gameMoves[i]} ${gameMoves.length > (i+1) ? gameMoves[i+1] : ""}"));
      }else {

      }
    }

    return children;

  }


  //////////////
  //ads
  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }
///////////////
}




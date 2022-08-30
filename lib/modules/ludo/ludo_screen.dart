import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class LudoScreen extends StatefulWidget {
  const LudoScreen({Key? key}) : super(key: key);

  @override
  State<LudoScreen> createState() => _LudoScreenState();
}

class _LudoScreenState extends State<LudoScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();
  late UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //centerTitle: true,
        //backgroundColor: Color.fromRGBO(16, 13, 34, 1),
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text(
          'Ludo',
          style: TextStyle(color: Colors.deepPurple),
        ),
        actions: [
          IconButton(
            onPressed: () async{
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
                    'Are you sure you want to exit the game?',
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
      body: UnityWidget(
        onUnityCreated: onUnityCreated,

        onUnityMessage: onUnityMessage,
      ),
    );
  }
  // Communcation from Flutter to Unity
  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo.name}');
    print('Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
  }
}
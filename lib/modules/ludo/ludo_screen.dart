import 'package:flutter/material.dart';

class LudoScreen extends StatefulWidget {
  const LudoScreen({Key? key}) : super(key: key);

  @override
  State<LudoScreen> createState() => _LudoScreenState();
}

class _LudoScreenState extends State<LudoScreen> {
  GlobalKey keyBar = GlobalKey();
  void _onPressed() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: keyBar,
        title: Text('Ludo'),
      ),
      body: Center(),
    );
  }
}
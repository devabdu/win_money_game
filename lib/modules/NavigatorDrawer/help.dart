import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text("Help",
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
        body: const Center(
          child: Text(
              'Help',
            style: TextStyle(
              color: Colors.white
            ),
          ),

        )
    );
  }
}
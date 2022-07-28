import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          iconTheme: const IconThemeData(
            color: Colors.deepPurple,
          ),
          title: const Text("Settings",
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        body: const Center(
          child: Text(
            'Settings',
            style: TextStyle(
                color: Colors.white
            ),
          ),

        )
    );
  }
}

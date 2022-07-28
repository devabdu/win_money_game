import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          iconTheme: const IconThemeData(
            color: Colors.deepPurple,
          ),
          title: const Text("Statistics",
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        body: const Center(
          child: Text(
            'Statistics',
            style: TextStyle(
                color: Colors.white
            ),
          ),

        )
    );
  }
}

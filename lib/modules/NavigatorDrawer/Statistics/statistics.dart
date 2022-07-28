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
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      'Tasaly Statistics',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    splashColor: Colors.deepPurple,
                    child: Image.asset(
                      "assets/images/Tasaly.png",
                      width: 190,
                      height: 200,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Rebh Statistics',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    splashColor: Colors.deepPurple,
                    child: Image.asset(
                      "assets/images/rebh.png",
                      width: 190,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/shared/components/components.dart';

class SelectPathScreen extends StatelessWidget {
  const SelectPathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Play for fun',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      'Without Ads and earn money',
                      style: TextStyle(
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
                          return navigateTo(context, const HomeLayoutScreen());
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              splashColor: Colors.deepPurple,
              child: Image.asset(
                "assets/images/Tasaly.png",
                width: double.infinity,
                height: 300,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Play to win money',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      'With Ads and earn money',
                      style: TextStyle(
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
                          return navigateTo(context, const HomeLayoutScreen());
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              splashColor: Colors.deepPurple,
              child: Image.asset(
                "assets/images/rebh.png",
                width: double.infinity,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/modules/chess/Old/components/play_game_page.dart';

import '../../../../shared/components/components.dart';

class ChessSelectBetScreen extends StatelessWidget {
  const ChessSelectBetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[500],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 350.0,
            ),
            items: images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    //width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: InkWell(
                      child: Image.asset(
                        i,
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        navigateTo(context, PlayGamePage());
                      },
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 100,
          ),
          defaultButton(
            function: () {
              navigateTo(context, PlayGamePage());
            },
            backgroundColorBox: Colors.amberAccent,
            textColor: Colors.deepPurple,
            text: 'Play',
            width: 200,
            isUpperCase: false,
          ),
        ],
      ),
    );
  }
}

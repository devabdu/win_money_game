import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo/first_xo_screen.dart';
import 'package:win_money_game/modules/xo/second_xo_screen.dart';
import 'package:win_money_game/modules/xo/third_xo_screen.dart';
import 'package:win_money_game/shared/component/component.dart';

class XoSelectBetScreen extends StatelessWidget {
  XoSelectBetScreen({Key? key}) : super(key: key);

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
                        if (select3x3 == true) {
                          navigateTo(context, FirstXOScreen());
                        } else if (select4x4 == true) {
                          navigateTo(context, SecondXOScreen());
                        } else if (select5x5 == true) {
                          navigateTo(context, ThirdXOScreen());
                        }
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
              if (select3x3 == true) {
                navigateTo(context, FirstXOScreen());
              } else if (select4x4 == true) {
                navigateTo(context, SecondXOScreen());
              } else if (select5x5 == true) {
                navigateTo(context, ThirdXOScreen());
              }
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

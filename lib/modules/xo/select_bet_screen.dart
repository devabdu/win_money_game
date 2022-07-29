import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo/first_xo_screen.dart';
import 'package:win_money_game/modules/xo/second_xo_screen.dart';
import 'package:win_money_game/modules/xo/third_xo_screen.dart';
import 'package:win_money_game/shared/component/component.dart';

class XoSelectBetScreen extends StatelessWidget {
  XoSelectBetScreen({Key? key}) : super(key: key);

  final List <String> xoImage = [

    'assets/images/50_coins.png',
    'assets/images/100_coins.png',
    'assets/images/500_coins.png',
    'assets/images/1k_coins.png',
    'assets/images/2.5k_coins.png',
    'assets/images/5k_coins.png',
    'assets/images/10k_coins.png',
    'assets/images/25k_coins.png',
    'assets/images/50k_coins.png',
    'assets/images/100k_coins.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 350.0,
            ),
            items: xoImage.map((i) {
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
                        child: Image.asset(i,
                          fit: BoxFit.fill,

                        ),
                        onTap: (){
                          navigateTo(context, FirstXOScreen());
                        },
                      ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 100,),
          defaultButton(
            function: () {
              if(select3x3 == true){
                print(select3x3);
                print(select4x4);
                print(select5x5);
                navigateTo(context, FirstXOScreen());
              }
              else if(select4x4 == true){
                print(select3x3);
                print(select4x4);
                print(select5x5);
                navigateTo(context, SecondXOScreen());
              }
              else if(select5x5 == true){
                print(select3x3);
                print(select4x4);
                print(select5x5);
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

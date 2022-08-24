import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/xo_create_or_join_xo_screen.dart';

import '../../shared/components/components.dart';

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
            items: images.map((image) {
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
                        image,
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        if(image == 'assets/images/50_coins.png'){
                          chose50 = true; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                          chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                        }
                        else if(image == 'assets/images/100_coins.png'){
                          chose50 = false; chose100 = true; chose500 = false; chose1k = false; chose2500 = false;
                          chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                        }
                        else if(image == 'assets/images/500_coins.png'){
                          chose50 = false; chose100 = false; chose500 = true; chose1k = false; chose2500 = false;
                          chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                        }
                        else if(image == 'assets/images/1k_coins.png'){
                          chose50 = false; chose100 = false; chose500 = false; chose1k = true; chose2500 = false;
                          chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                        }
                        else if(image == 'assets/images/2.5k_coins.png'){
                          chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = true;
                          chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                        }
                        else if(image == 'assets/images/5k_coins.png'){
                          chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                          chose5k = true; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                        }
                        else if(image == 'assets/images/10k_coins.png'){
                          chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                          chose5k = false; chose10k = true; chose25k = false; chose50k = false; chose100k = false;
                        }
                        else if(image == 'assets/images/25k_coins.png'){
                          chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                          chose5k = false; chose10k = false; chose25k = true; chose50k = false; chose100k = false;
                        }
                        else if(image == 'assets/images/50k_coins.png'){
                          chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                          chose5k = false; chose10k = false; chose25k = false; chose50k = true; chose100k = false;
                        }
                        else if(image == 'assets/images/100k_coins.png'){
                          chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                          chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = true;
                        }

                        navigateTo(context, CreateOrJoinXOScreen());
                      },
                    ),
                  );
                },
              );
            }).toList(),
          ),
          // const SizedBox(
          //   height: 100,
          // ),
          // defaultButton(
          //   function: () {
          //     navigateTo(context, CreateOrJoinXOScreen());
          //   },
          //   backgroundColorBox: Colors.amberAccent,
          //   textColor: Colors.deepPurple,
          //   text: 'Play',
          //   width: 200,
          //   isUpperCase: false,
          // ),
        ],
      ),
    );
  }
}

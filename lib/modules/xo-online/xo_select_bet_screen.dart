import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/modules/xo-online/xo_create_or_join_xo_screen.dart';

import '../../shared/components/components.dart';

class XoSelectBetScreen extends StatelessWidget {
  XoSelectBetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot){
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? const Center(child:Text('No User')) : Scaffold(
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

                                if(user.coins >= 50){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/100_coins.png'){
                                chose50 = false; chose100 = true; chose500 = false; chose1k = false; chose2500 = false;
                                chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                                if(user.coins >= 100){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/500_coins.png'){
                                chose50 = false; chose100 = false; chose500 = true; chose1k = false; chose2500 = false;
                                chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                                if(user.coins >= 500){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/1k_coins.png'){
                                chose50 = false; chose100 = false; chose500 = false; chose1k = true; chose2500 = false;
                                chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                                if(user.coins >= 1000){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/2.5k_coins.png'){
                                chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = true;
                                chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                                if(user.coins >= 2500){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/5k_coins.png'){
                                chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                                chose5k = true; chose10k = false; chose25k = false; chose50k = false; chose100k = false;
                                if(user.coins >= 5000){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/10k_coins.png'){
                                chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                                chose5k = false; chose10k = true; chose25k = false; chose50k = false; chose100k = false;
                                if(user.coins >= 10000){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/25k_coins.png'){
                                chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                                chose5k = false; chose10k = false; chose25k = true; chose50k = false; chose100k = false;
                                if(user.coins >= 25000){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/50k_coins.png'){
                                chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                                chose5k = false; chose10k = false; chose25k = false; chose50k = true; chose100k = false;
                                if(user.coins >= 50000){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                }
                                else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                              else if(image == 'assets/images/100k_coins.png'){
                                chose50 = false; chose100 = false; chose500 = false; chose1k = false; chose2500 = false;
                                chose5k = false; chose10k = false; chose25k = false; chose50k = false; chose100k = true;
                                if(user.coins>=100000){
                                  navigateTo(context, CreateOrJoinXOScreen());
                                } else{
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    backgroundColor: Colors.amberAccent,
                                    title: const Text('Sorry',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('You don\'t have enough coins',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                                }
                              }
                            },
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        } else if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}

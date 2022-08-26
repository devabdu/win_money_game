import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? const Center(child:Text('No User')) : Scaffold(
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
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Music',
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          defaultIconPlay(
                            iconSize: 30,
                            iconColor: Colors.deepPurple,
                              function: (){
                                if(isPlaying)
                                {
                                  setState(() {
                                    isPlaying = false;
                                  });
                                  stopMusic();
                                }
                                else {
                                  setState(() {
                                    isPlaying = true;
                                  });
                                  //playMusic('music.ogg.mp3');
                                  playTillTab('music.ogg.mp3');
                                }
                              }
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}


import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/shared/components/components.dart';

class PlayMusic extends StatefulWidget {
  const PlayMusic({Key? key}) : super(key: key);

  @override
  State<PlayMusic> createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    cache = AudioCache(fixedPlayer: player);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Text('Play Music', style: TextStyle(fontSize: 35, color: Colors.white),),
            alignment: Alignment.center,
            color: Colors.deepPurple,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              defaultIconPlay(
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
              })
            ],
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/modules/admin/admin_screen.dart';
import 'package:win_money_game/shared/audio_manager.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({Key? key}) : super(key: key);

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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: AudioManager.sfx,
                      builder: (context, sfx, child) => SwitchListTile(
                        title: const Text('Sound Effects',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: sfx,
                        activeColor: Colors.white,
                        onChanged: (value) => AudioManager.sfx.value = value,

                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: AudioManager.bgm,
                      builder: (context, bgm, child) => SwitchListTile(
                        title: const Text('Background Music',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: bgm,
                        activeColor: Colors.white,
                        onChanged: (value) => AudioManager.bgm.value = value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  user.isAdmin ? defaultButton(
                    function: (){
                      navigateTo(context, AdminScreen());
                    },
                    text: "Admin Settings",
                    isUpperCase: false,
                    textColor: Colors.white,
                    fontSize: 20.0,
                  ) : Center(),
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


import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_text.dart';
import 'package:win_money_game/providers/room_data_provider_5_5.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class WaitingLobbyFive extends StatefulWidget {
  const WaitingLobbyFive({Key? key}) : super(key: key);

  @override
  State<WaitingLobbyFive> createState() => _WaitingLobbyFiveState();
}

class _WaitingLobbyFiveState extends State<WaitingLobbyFive> {
  late TextEditingController roomIdController;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
      text:
      Provider.of<RoomDataProviderFive>(context, listen: false).roomData['_id'],
    );
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                  // shadows: [
                  //   Shadow(
                  //     blurRadius: 40,
                  //     color: Colors.blue,
                  //   ),
                  // ],
                  text: 'Lobby',
                  fontSize: 70,
                ),
                SizedBox(height: size.height * 0.08),
                CustomTextField(
                  controller: roomIdController,
                  hintText: '',
                  isReadOnly: true,
                ),
                SizedBox(height: size.height * 0.045),
                const Text(
                  'Waiting for a player to join...',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
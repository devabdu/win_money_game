import 'package:flutter/material.dart';
import 'package:win_money_game/providers/room_data_provider_4_4.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class WaitingLobbyFour extends StatefulWidget {
  const WaitingLobbyFour({Key? key}) : super(key: key);

  @override
  State<WaitingLobbyFour> createState() => _WaitingLobbyFourState();
}

class _WaitingLobbyFourState extends State<WaitingLobbyFour> {
  late TextEditingController roomIdController;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
      text:
      Provider.of<RoomDataProviderFour>(context, listen: false).roomData['_id'],
    );
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Waiting for a player to join...'),
        const SizedBox(height: 20),
        CustomTextField(
          controller: roomIdController,
          hintText: '',
          isReadOnly: true,
        ),
      ],
    );
  }
}
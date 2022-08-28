import 'package:flutter/material.dart';
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
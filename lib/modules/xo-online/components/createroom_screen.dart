import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_button.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_text.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_textfield.dart';
import 'package:win_money_game/shared/components/components.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Create Room',
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname',
              ),
              SizedBox(height: size.height * 0.045),
              defaultButton(
                function: () => _socketMethods.createRoom(
                  _nameController.text,
                ),
                backgroundColorBox: Colors.amberAccent,
                textColor: Colors.deepPurple,
                text: 'Create',
                width: 150,
                isUpperCase: false,
              ),
              // CustomButton(
              //     onTap: () => _socketMethods.createRoom(
              //       _nameController.text,
              //     ),
              //     // onTap: () => print('hello'),
              //     text: 'Create'),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_button.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_text.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_textfield.dart';
import 'package:win_money_game/shared/components/components.dart';

class CreateRoomScreen2 extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen2({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen2> createState() => _CreateRoomScreen2State();
}

class _CreateRoomScreen2State extends State<CreateRoomScreen2> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListenerFour(context);
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
                // shadows: [
                //   Shadow(
                //     blurRadius: 40,
                //     color: Colors.blue,
                //   ),
                // ],
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
                function: () => _socketMethods.createRoomFour(
                  _nameController.text,
                ),
                backgroundColorBox: Colors.amberAccent,
                textColor: Colors.deepPurple,
                text: 'Create',
                width: 150,
                isUpperCase: false,
              ),
              // CustomButton(
              //     onTap: () => _socketMethods.createRoomFour(
              //       _nameController.text,
              //     ),
              //     text: 'Create'
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
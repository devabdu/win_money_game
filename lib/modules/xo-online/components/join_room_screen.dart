import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_button.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_text.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_textfield.dart';
import 'package:win_money_game/shared/components/components.dart';


class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.updatePlayersStateListener(context);

    _socketMethods.joinRoomSuccessListenerFour(context);
    _socketMethods.updatePlayersStateListenerFour(context);

    _socketMethods.joinRoomSuccessListenerFive(context);
    _socketMethods.updatePlayersStateListenerFive(context);
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? const Center(child:Text('No User')) : Scaffold(
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
                      text: 'Join Room',
                      fontSize: 70,
                    ),
                    SizedBox(height: size.height * 0.08),
                    CustomTextField(
                      controller: _gameIdController,
                      hintText: 'Enter Game ID',
                    ),
                    SizedBox(height: size.height * 0.045),
                    defaultButton(
                      function:  () {
                        if (select3x3) {
                          if (chose50) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                50
                            );
                          } else if (chose100) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                100
                            );
                          } else if (chose500) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                500
                            );
                          } else if (chose1k) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                1000
                            );
                          } else if (chose2500) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                2500
                            );
                          } else if (chose5k) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                5000
                            );
                          } else if (chose10k) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                10000
                            );
                          } else if (chose25k) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                25000
                            );
                          } else if (chose50k) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                50000
                            );
                          } else if (chose100k) {
                            _socketMethods.joinRoom(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                100000
                            );
                          }
                        } else if(select4x4){
                          if (chose50) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                50
                            );
                          } else if (chose100) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                100
                            );
                          } else if (chose500) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                500
                            );
                          } else if (chose1k) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                1000
                            );
                          } else if (chose2500) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                2500
                            );
                          } else if (chose5k) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                5000
                            );
                          } else if (chose10k) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                10000
                            );
                          } else if (chose25k) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                25000
                            );
                          } else if (chose50k) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                50000
                            );
                          } else if (chose100k) {
                            _socketMethods.joinRoom4(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                100000
                            );
                          }
                        } else if(select5x5) {
                          if (chose50) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                50
                            );
                          } else if (chose100) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                100
                            );
                          } else if (chose500) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                500
                            );
                          } else if (chose1k) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                1000
                            );
                          } else if (chose2500) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                2500
                            );
                          } else if (chose5k) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                5000
                            );
                          } else if (chose10k) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                10000
                            );
                          } else if (chose25k) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                25000
                            );
                          } else if (chose50k) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                50000
                            );
                          } else if (chose100k) {
                            _socketMethods.joinRoom5(
                                user.name,
                                _gameIdController.text,
                                user.uId,
                                user.avatar,
                                100000
                            );
                          }
                        }
                      },
                      backgroundColorBox: Colors.amberAccent,
                      textColor: Colors.deepPurple,
                      text: 'Join',
                      width: 150,
                      isUpperCase: false,
                    ),
                    // CustomButton(
                    //   onTap: () => _socketMethods.joinRoom(
                    //     _nameController.text,
                    //     _gameIdController.text,
                    //   ),
                    //   text: 'Join',
                    // ),
                  ],
                ),
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
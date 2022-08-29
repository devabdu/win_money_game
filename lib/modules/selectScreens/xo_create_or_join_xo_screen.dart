import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/shared/components/components.dart';

import '../xo-online/components/join_room_screen.dart';

class CreateOrJoinXOScreen extends StatefulWidget {

  @override
  State<CreateOrJoinXOScreen> createState() => _CreateOrJoinXOScreenState();
}

class _CreateOrJoinXOScreenState extends State<CreateOrJoinXOScreen> {

  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    _socketMethods.createRoomSuccessListenerFour(context);
    _socketMethods.createRoomSuccessListenerFive(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Responsive(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButton(
                        function: () {
                          if(select3x3){
                            if(chose50){
                            _socketMethods.createRoom(
                                user.name,
                                user.uId,
                                user.avatar,
                                50
                            );
                          }else if(chose100){
                            _socketMethods.createRoom(
                                user.name,
                                user.uId,
                                user.avatar,
                                100
                            );
                          }else if(chose500){
                            _socketMethods.createRoom(
                                user.name,
                                user.uId,
                                user.avatar,
                                500
                            );
                          }else if(chose1k){
                              _socketMethods.createRoom(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  1000
                              );
                            }else if(chose2500){
                              _socketMethods.createRoom(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  2500
                              );
                            }else if(chose5k){
                              _socketMethods.createRoom(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  5000
                              );
                            }else if(chose10k){
                              _socketMethods.createRoom(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  10000
                              );
                            }else if(chose25k){
                              _socketMethods.createRoom(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  25000
                              );
                            }else if(chose50k){
                              _socketMethods.createRoom(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  50000
                              );
                            }else if(chose100k){
                              _socketMethods.createRoom(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  100000
                              );
                            }
                          }
                          else if(select4x4){
                            if(chose50){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  50
                              );
                            }else if(chose100){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  100
                              );
                            }else if(chose500){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  500
                              );
                            } else if(chose1k){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  1000
                              );
                            }else if(chose5k){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  5000
                              );
                            }else if(chose10k){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  10000
                              );
                            }else if(chose25k){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  25000
                              );
                            }else if(chose50k){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  50000
                              );
                            }else if(chose100k){
                              _socketMethods.createRoomFour(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  100000
                              );
                            }
                          } else if(select5x5)
                           if(chose50){
                            _socketMethods.createRoomFive(
                                user.name,
                                user.uId,
                                user.avatar,
                                50
                            );
                          }else if(chose100){
                            _socketMethods.createRoomFive(
                                user.name,
                                user.uId,
                                user.avatar,
                                100
                            );
                          }else if(chose500){
                            _socketMethods.createRoomFive(
                                user.name,
                                user.uId,
                                user.avatar,
                                500
                            );
                          }else if(chose1k){
                              _socketMethods.createRoomFive(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  1000
                              );
                            }else if(chose2500){
                             _socketMethods.createRoomFive(
                                 user.name,
                                 user.uId,
                                 user.avatar,
                                 2500
                             );
                           }else if(chose5k){
                              _socketMethods.createRoomFive(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  5000
                              );
                            }else if(chose10k){
                              _socketMethods.createRoomFive(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  10000
                              );
                            }else if(chose25k){
                              _socketMethods.createRoomFive(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  25000
                              );
                            }else if(chose50k){
                              _socketMethods.createRoomFive(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  50000
                              );
                            }else if(chose100k){
                              _socketMethods.createRoomFive(
                                  user.name,
                                  user.uId,
                                  user.avatar,
                                  100000
                              );
                            }
                        },
                        backgroundColorBox: Colors.amberAccent,
                        textColor: Colors.deepPurple,
                        text: 'Create Room',
                        width: 300,
                        isUpperCase: false,
                      ),
                      const SizedBox(height: 20),
                      defaultButton(
                        function: () {
                            navigateTo(context, JoinRoomScreen());
                          // else if(select4x4)
                          //   navigateTo(context, JoinRoomScreen2());
                          // else if(select5x5)
                          //   navigateTo(context, JoinRoomScreen3());
                        },
                        backgroundColorBox: Colors.amberAccent,
                        textColor: Colors.deepPurple,
                        text: 'Join Room',
                        width: 300,
                        isUpperCase: false,
                      ),
                    ],
                  ),
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

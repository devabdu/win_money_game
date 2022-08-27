// import 'package:flutter/material.dart';
// import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
// import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
// import 'package:win_money_game/modules/xo-online/widgets/custom_button.dart';
// import 'package:win_money_game/modules/xo-online/widgets/custom_text.dart';
// import 'package:win_money_game/modules/xo-online/widgets/custom_textfield.dart';
// import 'package:win_money_game/shared/components/components.dart';
//
//
// class JoinRoomScreen2 extends StatefulWidget {
//   static String routeName = '/join-room';
//   const JoinRoomScreen2({Key? key}) : super(key: key);
//
//   @override
//   State<JoinRoomScreen2> createState() => _JoinRoomScreen2State();
// }
//
// class _JoinRoomScreen2State extends State<JoinRoomScreen2> {
//   final TextEditingController _gameIdController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final SocketMethods _socketMethods = SocketMethods();
//
//   @override
//   void initState() {
//     super.initState();
//     _socketMethods.joinRoomSuccessListenerFour(context);
//     _socketMethods.updatePlayersStateListenerFour(context);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _gameIdController.dispose();
//     _nameController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: Colors.deepPurple,
//       body: Responsive(
//         child: Container(
//           margin: const EdgeInsets.symmetric(
//             horizontal: 20,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const CustomText(
//                 // shadows: [
//                 //   Shadow(
//                 //     blurRadius: 40,
//                 //     color: Colors.blue,
//                 //   ),
//                 // ],
//                 text: 'Join Room',
//                 fontSize: 70,
//               ),
//               SizedBox(height: size.height * 0.08),
//               CustomTextField(
//                 controller: _nameController,
//                 hintText: 'Enter your nickname',
//               ),
//               const SizedBox(height: 20),
//               CustomTextField(
//                 controller: _gameIdController,
//                 hintText: 'Enter Game ID',
//               ),
//               SizedBox(height: size.height * 0.045),
//               defaultButton(
//                 function:  () => _socketMethods.joinRoom4(
//                   _nameController.text,
//                   _gameIdController.text,
//                 ),
//                 backgroundColorBox: Colors.amberAccent,
//                 textColor: Colors.deepPurple,
//                 text: 'Join',
//                 width: 150,
//                 isUpperCase: false,
//               ),
//               // CustomButton(
//               //   onTap: () => _socketMethods.joinRoom4(
//               //     _nameController.text,
//               //     _gameIdController.text,
//               //   ),
//               //   text: 'Join',
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
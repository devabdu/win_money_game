import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/models/user_model.dart';
import '../../../shared/components/components.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var formKey = GlobalKey<FormState>();
  var avatarChoice = 0;

  String editName = '';
  TextEditingController? editNameController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? Center(child:Text('No User')) : Scaffold(
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              backgroundColor: Colors.amberAccent,
              iconTheme: const IconThemeData(
                color: Colors.deepPurple,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
              //centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: formKey,
                    child: Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: AssetImage(
                              'assets/images/avatar_${user.avatar}.png',
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      color: Colors.amberAccent,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Edit Avatar",
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.deepPurple,
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.white,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 30,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 150,
                                              child: GridView.builder(
                                                itemCount: 8,
                                                itemBuilder: (context, index){
                                                  return InkWell(
                                                    child: CircleAvatar(
                                                      backgroundImage: AssetImage(avatarImages[index]),
                                                      radius: 40,
                                                    ),
                                                    splashColor: Colors.deepPurple,
                                                    onTap: () async {
                                                      avatarChoice = await index + 1;
                                                      print(avatarChoice);
                                                      if(formKey.currentState!.validate())
                                                      {
                                                        updateAvatar(index: avatarChoice);
                                                        showDialog(context: context, builder: (context) => AlertDialog(
                                                          backgroundColor: Colors.amberAccent,
                                                          title: const Text('Avatar Updated',
                                                              style: TextStyle(
                                                                  color: Colors.deepPurple,
                                                                  fontWeight: FontWeight.bold),
                                                          ),
                                                          content: const Text('Your avatar has been updated successfully',
                                                            style: TextStyle(
                                                              color: Colors.deepPurple,
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(onPressed: (){
                                                              Navigator.pop(context);
                                                              Navigator.pop(context);
                                                              Navigator.pop(context);
                                                              Navigator.pop(context);
                                                            }, child: Text('Ok'),
                                                            ),
                                                          ],
                                                        ));
                                                      }
                                                    },
                                                  );
                                                },
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 2,
                                                  mainAxisSpacing: 10,
                                                  mainAxisExtent: 100,
                                                  crossAxisSpacing: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.amberAccent,
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    getFirstWord(user.name).capitalize(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Level ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${user.level}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      LinearPercentIndicator(
                        alignment: MainAxisAlignment.start,
                        width: 200.0,
                        lineHeight: 20.0,
                        percent: user.exp,
                        center: Text(
                          "${user.exp}%",
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        //trailing: Icon(Icons.mood),
                        linearStrokeCap: LinearStrokeCap.round,
                        backgroundColor: Colors.white,
                        progressColor: Colors.amberAccent,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.amberAccent,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${user.coins}',
                        style: const TextStyle(
                            color: Colors.amberAccent,
                            fontWeight: FontWeight.w400,
                            fontSize: 19),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //email
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // Center(
                  //   child: defaultButton(
                  //     function: () {
                  //       showModalBottomSheet(
                  //           isScrollControlled: true,
                  //           context: context,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //           builder: (context) {
                  //             return Container(
                  //               padding: const EdgeInsets.all(20),
                  //               color: Colors.amberAccent,
                  //               child: Padding(
                  //                 padding: EdgeInsets.only(
                  //                   bottom: MediaQuery.of(context).viewInsets.bottom,
                  //                   top: MediaQuery.of(context).viewInsets.top,
                  //                 ),
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: [
                  //                     const Text(
                  //                       "Edit Profile",
                  //                       style: TextStyle(
                  //                         fontSize: 25,
                  //                         fontWeight: FontWeight.w500,
                  //                         color: Colors.deepPurple,
                  //                       ),
                  //                     ),
                  //                     const Divider(
                  //                       color: Colors.white,
                  //                       thickness: 1,
                  //                       indent: 20,
                  //                       endIndent: 30,
                  //                     ),
                  //                     const SizedBox(
                  //                       height: 10,
                  //                     ),
                  //                     Row(
                  //                       children: [
                  //                         const Text(
                  //                           'Country:',
                  //                           style: TextStyle(
                  //                               color: Colors.deepPurple,
                  //                               fontSize: 19,
                  //                               fontWeight: FontWeight.w400),
                  //                         ),
                  //                         const SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                         CountryCodePicker(
                  //                           initialSelection: 'EG',
                  //                           showCountryOnly: false,
                  //                           showOnlyCountryWhenClosed: false,
                  //                           hideMainText: true,
                  //                           hideSearch: false,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     const Text(
                  //                       'Avatar:',
                  //                       style: TextStyle(
                  //                           color: Colors.deepPurple,
                  //                           fontSize: 19,
                  //                           fontWeight: FontWeight.w400),
                  //                     ),
                  //                     // Container(
                  //                     //   child: ,
                  //                     // ),
                  //                     const SizedBox(
                  //                       height: 40,
                  //                     ),
                  //                     defaultButton(
                  //                       function: () {},
                  //                       text: 'Save',
                  //                       isUpperCase: false,
                  //                       textColor: Colors.white,
                  //                       width: 150,
                  //                       backgroundColorBox: Colors.deepPurple,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           });
                  //     },
                  //     text: 'Edit',
                  //     isUpperCase: false,
                  //     textColor: Colors.deepPurple,
                  //     width: 150,
                  //     backgroundColorBox: Colors.amberAccent,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}

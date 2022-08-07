import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../shared/components/components.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // var formKey = GlobalKey<FormState>();
  String editName = '';
  TextEditingController? editNameController;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
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
            Center(
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage(
                      'assets/images/avatar_7.png',
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
                                                      ),
                                                      onTap: (){},
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
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              defaultButton(
                                                function: () {},
                                                text: 'Save',
                                                isUpperCase: false,
                                                textColor: Colors.white,
                                                width: 150,
                                                backgroundColorBox: Colors.deepPurple,
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
              getFirstWord(user.displayName!).capitalize(),
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
                  children: const [
                    Text(
                      'Level ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '100',
                      style: TextStyle(
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
                  percent: 0.5,
                  center: const Text(
                    "50.0%",
                    style: TextStyle(fontSize: 12.0),
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
              children: const [
                Icon(
                  Icons.monetization_on,
                  color: Colors.amberAccent,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '5,00000000000',
                  style: TextStyle(
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
              user.email!,
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
  }
}

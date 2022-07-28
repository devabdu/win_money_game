import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:win_money_game/shared/component/component.dart';

class ProfileScreen extends StatelessWidget {

  // var formKey = GlobalKey<FormState>();

   TextEditingController? emailController;

  @override
  Widget build(BuildContext context) {
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
            color:Colors.deepPurple,
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
            const Center(
              child: CircleAvatar(
                radius: 47,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage('https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg'),
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
            Row(
              children: [
                const Text(
                  'Mostafaahmed@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children:
              [
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
                    style:  TextStyle(fontSize: 12.0),
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
                Icon(Icons.monetization_on,
                  color: Colors.amberAccent,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '5,00000000000',
                  style:TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.w400,
                      fontSize: 19
                  ),
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
            Row(
              children: [
                const Text(
                  'Mostafaahmed@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: (){
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        builder: (context) {
                          return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "What's your email?",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Padding(
                                      padding:  EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom
                                      ),
                                      child: Column(
                                        children: [
                                          defaultFormField(
                                            controller: emailController!,
                                            type: TextInputType.emailAddress,
                                            validate: (value){},
                                            label: 'Email Address',
                                          ),
                                          const SizedBox(
                                            height: 60,
                                          ),
                                          defaultButton(
                                            function: (){},
                                            text: 'Update',
                                            isUpperCase: false,
                                            textColor: Colors.white,
                                            backgroundColorBox: Colors.teal,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          );
                        }
                    );
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/modules/admin/admin_screen.dart';

import '../../shared/components/components.dart';

class WeeklyMissions extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var firstMissionName = TextEditingController();
  var firstMissionCount = TextEditingController();
  var secondMissionName = TextEditingController();
  var secondMissionCount = TextEditingController();
  var thirdMissionName = TextEditingController();
  var thirdMissionCount = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text("Weekly Missions",
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: SingleChildScrollView(
        child:
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              const SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultFormField(
                      controller: firstMissionName,
                      type: TextInputType.name,
                      validate: (value) {
                        return validate(value!);
                      },
                      label: "First Mission Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: firstMissionCount,
                      type: TextInputType.number,
                      validate: (value) {
                        return validate(value!);
                      },
                      label: "First Mission Count",
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    defaultFormField(
                      controller: secondMissionName,
                      type: TextInputType.name,
                      validate: (value) {
                        return validate(value!);
                      },
                      label: "Second Mission Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: secondMissionCount,
                      type: TextInputType.number,
                      validate: (value) {
                        return validate(value!);
                      },
                      label: "Second Mission Count",
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    defaultFormField(
                      controller: thirdMissionName,
                      type: TextInputType.name,
                      validate: (value) {
                        return validate(value!);
                      },
                      label: "Third Mission Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: thirdMissionCount,
                      type: TextInputType.number,
                      validate: (value) {
                        return validate(value!);
                      },
                      label: "Third Mission Count",
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultButton(
                    function: (){
                      if(formKey.currentState!.validate()) {
                        updateWeeklyMissions(
                          firstMissionName: firstMissionName.text.capitalize(),
                          firstMissionCount: int.parse(firstMissionCount.text),
                          secondMissionName: secondMissionName.text.capitalize(),
                          secondMissionCount: int.parse(secondMissionCount.text),
                          thirdMissionName: thirdMissionName.text.capitalize(),
                          thirdMissionCount: int.parse(thirdMissionCount.text),
                        );
                        showDialog(context: context, builder: (context) => AlertDialog(
                          backgroundColor: Colors.amberAccent,
                          title: const Text('Missions Updated',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text('Weekly missions have been updated successfully',
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
                            }, child: const Text('Ok'),
                            ),
                          ],
                        ));
                      }
                    },
                    text: "Set Missions",
                    isUpperCase: false,
                    textColor: Colors.deepPurple,
                    fontSize: 20.0,
                  ),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
}
